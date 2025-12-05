-- JSON
CREATE OR REPLACE FUNCTION fn_get_historico_rodadas_json(p_game_id UUID)
RETURNS JSON
LANGUAGE plpgsql
AS $$
DECLARE
    v_result JSON;
BEGIN
    SELECT json_build_object(
        'game_id', p_game_id,
        'rounds', (
            SELECT json_agg(
                json_build_object(
                    'round_number', gr.round_number,
                    'started_at', gr.started_at,
                    'ended_at', gr.ended_at,
                    'duration_seconds', EXTRACT(EPOCH FROM (gr.ended_at - gr.started_at)),
                    'question', (
                        SELECT json_build_object(
                            'content', q.content,
                            'options', q.options,
                            'correct_option', q.correct_option
                        )
                        FROM game_questions gq
                        JOIN questions q ON gq.question_id = q.id
                        WHERE gq.game_id = gr.game_id
                        AND gq.question_order = gr.round_number
                    ),
                    'answers', (
                        SELECT json_agg(
                            json_build_object(
                                'player_name', COALESCE(u.username, gu.name),
                                'selected_option', gra.selected_option,
                                'is_correct', gra.is_correct,
                                'answered_at', gra.answered_at
                            ) ORDER BY gra.answered_at
                        )
                        FROM game_round_answers gra
                        JOIN players p ON gra.player_id = p.id
                        LEFT JOIN users u ON p.user_id = u.id
                        LEFT JOIN guests gu ON p.guest_id = gu.id
                        WHERE gra.round_id = gr.id
                    ),
                    'statistics', json_build_object(
                        'total_answers', (
                            SELECT COUNT(*) 
                            FROM game_round_answers 
                            WHERE round_id = gr.id
                        ),
                        'correct_answers', (
                            SELECT COUNT(*) 
                            FROM game_round_answers 
                            WHERE round_id = gr.id AND is_correct = TRUE
                        ),
                        'accuracy_rate', (
                            SELECT ROUND(
                                COUNT(CASE WHEN is_correct THEN 1 END) * 100.0 / COUNT(*),
                                2
                            )
                            FROM game_round_answers 
                            WHERE round_id = gr.id
                        )
                    )
                ) ORDER BY gr.round_number
            )
            FROM game_round gr
            WHERE gr.game_id = p_game_id
        )
    )
    INTO v_result;
    
    RETURN v_result;
END;
$$;

SELECT jsonb_pretty(fn_get_historico_rodadas_json('a50e8400-e29b-41d4-a716-446655440001')::jsonb);


-- MINERACAO
CREATE OR REPLACE VIEW vw_performance_por_tema AS
SELECT 
    t.name as tema,
    COUNT(DISTINCT p.id) as total_jogadores,
    COUNT(*) as total_respostas,
    SUM(CASE WHEN gra.is_correct THEN 1 ELSE 0 END) as respostas_corretas,
    ROUND(
        AVG(CASE WHEN gra.is_correct THEN 100.0 ELSE 0.0 END), 
        2
    ) as taxa_acerto_percentual
FROM game_round_answers gra
JOIN players p ON gra.player_id = p.id
JOIN game_questions gq ON gra.question_id = gq.id
JOIN question_tags qt ON gq.question_id = qt.question_id
JOIN tags t ON qt.tag_id = t.id
GROUP BY t.name
ORDER BY taxa_acerto_percentual ASC;

SELECT * FROM vw_performance_por_tema;


SELECT 
    tema,
    taxa_acerto_percentual,
    CASE 
        WHEN taxa_acerto_percentual < 40 THEN 'Criar conteúdo premium de reforço'
        WHEN taxa_acerto_percentual < 60 THEN 'Adicionar modo treino'
        ELSE 'Criar desafios avançados'
    END as estrategia_recomendada
FROM vw_performance_por_tema;

-- PROCEDURE: COMMIT & ROLLBACK
CREATE OR REPLACE PROCEDURE sp_registrar_resposta(
    p_round_id UUID,
    p_player_id UUID,
    p_question_id UUID,
    p_selected_option INTEGER,
    OUT p_sucesso BOOLEAN,
    OUT p_mensagem TEXT,
    OUT p_is_correct BOOLEAN,
    OUT p_pontos_ganhos INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_correct_option INTEGER;
    v_round_ended BOOLEAN;
    v_game_id UUID;
BEGIN
    -- Inicializar variáveis de saída
    p_sucesso := FALSE;
    p_is_correct := FALSE;
    p_pontos_ganhos := 0;
    
    -- Verificar se rodada ainda está ativa
    SELECT 
        (ended_at IS NOT NULL),
        game_id
    INTO v_round_ended, v_game_id
    FROM game_round
    WHERE id = p_round_id;
    
    IF NOT FOUND THEN
        p_mensagem := 'Rodada não encontrada';
        -- Transação será revertida automaticamente em caso de exceção
        RAISE EXCEPTION 'Rodada não encontrada';
    END IF;
    
    IF v_round_ended THEN
        p_mensagem := 'Rodada já foi encerrada';
        RAISE EXCEPTION 'Rodada já foi encerrada';
    END IF;
    
    -- Verificar se já respondeu
    IF EXISTS(
        SELECT 1 FROM game_round_answers
        WHERE round_id = p_round_id 
        AND player_id = p_player_id 
        AND question_id = p_question_id
    ) THEN
        p_mensagem := 'Já respondeu esta questão';
        RAISE EXCEPTION 'Já respondeu esta questão';
    END IF;
    
    -- Buscar resposta correta
    SELECT q.correct_option INTO v_correct_option
    FROM game_questions gq
    JOIN questions q ON gq.question_id = q.id
    WHERE gq.id = p_question_id;
    
    IF NOT FOUND THEN
        p_mensagem := 'Questão não encontrada';
        RAISE EXCEPTION 'Questão não encontrada';
    END IF;
    
    -- Verificar se resposta está correta
    p_is_correct := (p_selected_option = v_correct_option);
    p_pontos_ganhos := CASE WHEN p_is_correct THEN 100 ELSE 0 END;
    
    -- Inserir resposta
    INSERT INTO game_round_answers (
        round_id, player_id, question_id, 
        selected_option, is_correct, answered_at
    ) VALUES (
        p_round_id, p_player_id, p_question_id,
        p_selected_option, p_is_correct, CURRENT_TIMESTAMP
    );
    
    -- Atualizar pontuação
    UPDATE game_scores
    SET 
        score = score + p_pontos_ganhos,
        correct_answers = correct_answers + CASE WHEN p_is_correct THEN 1 ELSE 0 END,
        total_questions = total_questions + 1,
        updated_at = CURRENT_TIMESTAMP
    WHERE player_id = p_player_id 
    AND game_id = v_game_id;
    
    -- Se não existe score ainda, criar
    IF NOT FOUND THEN
        INSERT INTO game_scores (player_id, game_id, score, correct_answers, total_questions)
        VALUES (
            p_player_id, 
            v_game_id, 
            p_pontos_ganhos,
            CASE WHEN p_is_correct THEN 1 ELSE 0 END,
            1
        );
    END IF;
    
    -- Sucesso - transação será commitada automaticamente
    p_sucesso := TRUE;
    p_mensagem := CASE 
        WHEN p_is_correct THEN FORMAT('Resposta correta! +%s pontos', p_pontos_ganhos)
        ELSE 'Resposta incorreta!'
    END;
    
EXCEPTION
    WHEN OTHERS THEN
        -- Em caso de erro, transação será revertida automaticamente (ROLLBACK)
        p_sucesso := FALSE;
        p_mensagem := 'Erro: ' || SQLERRM;
        p_is_correct := FALSE;
        p_pontos_ganhos := 0;
END;
$$;


DO $$
DECLARE
    v_sucesso BOOLEAN;
    v_mensagem TEXT;
    v_is_correct BOOLEAN;
    v_pontos INTEGER;
BEGIN
    CALL sp_registrar_resposta(
        'd50e8400-e29b-41d4-a716-446655440009',
        '750e8400-e29b-41d4-a716-446655440002',
        'b50e8400-e29b-41d4-a716-446655440007',
        2,
        v_sucesso,
        v_mensagem,
        v_is_correct,
        v_pontos
    );
    
    RAISE NOTICE '========================================';
    RAISE NOTICE 'RESULTADO DO REGISTRO DE RESPOSTA';
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Sucesso: %', v_sucesso;
    RAISE NOTICE 'Mensagem: %', v_mensagem;
    RAISE NOTICE 'Correta: %', v_is_correct;
    RAISE NOTICE 'Pontos ganhos: %', v_pontos;
    RAISE NOTICE '========================================';
END;
$$;

-- CURSOR
CREATE OR REPLACE PROCEDURE sp_atualizar_ranking_jogo(
    p_game_id UUID
)
LANGUAGE plpgsql
AS $$
DECLARE
    cur_ranking CURSOR FOR
        SELECT player_id, score, correct_answers
        FROM game_scores
        WHERE game_id = p_game_id
        ORDER BY score DESC, correct_answers DESC, player_id;
    
    v_record RECORD;
    v_position INTEGER := 1;
    v_total_players INTEGER;
BEGIN
    -- Contar jogadores
    SELECT COUNT(*) INTO v_total_players
    FROM game_scores
    WHERE game_id = p_game_id;
    
    RAISE NOTICE '========================================';
    RAISE NOTICE 'RANKING DO JOGO: %', p_game_id;
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Total de jogadores: %', v_total_players;
    RAISE NOTICE '========================================';
    
    -- Abrir cursor
    OPEN cur_ranking;
    
    LOOP
        FETCH cur_ranking INTO v_record;
        EXIT WHEN NOT FOUND;
        
        -- Atualizar posição
        UPDATE game_scores
        SET position = v_position,
            updated_at = CURRENT_TIMESTAMP
        WHERE player_id = v_record.player_id 
        AND game_id = p_game_id;
        
        -- Exibir informação
        RAISE NOTICE 'Posição %: Player % | Score: % | Acertos: %',
            v_position,
            v_record.player_id,
            v_record.score,
            v_record.correct_answers;
        
        v_position := v_position + 1;
    END LOOP;
    
    CLOSE cur_ranking;
    
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Ranking atualizado com sucesso!';
    RAISE NOTICE '========================================';
    
    COMMIT;
END;
$$;

-- Testar procedure com cursor
CALL sp_atualizar_ranking_jogo('a50e8400-e29b-41d4-a716-446655440001');