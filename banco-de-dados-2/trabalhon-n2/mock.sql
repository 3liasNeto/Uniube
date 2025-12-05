INSERT INTO users (id, username, first_name, last_name, email, password, icon) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'joao_silva', 'João', 'Silva', 'joao.silva@email.com', 'hash_senha_123', 'https://avatar.example.com/joao.png'),
('550e8400-e29b-41d4-a716-446655440002', 'maria_santos', 'Maria', 'Santos', 'maria.santos@email.com', 'hash_senha_456', 'https://avatar.example.com/maria.png'),
('550e8400-e29b-41d4-a716-446655440003', 'pedro_oliveira', 'Pedro', 'Oliveira', 'pedro.oliveira@email.com', 'hash_senha_789', 'https://avatar.example.com/pedro.png'),
('550e8400-e29b-41d4-a716-446655440004', 'ana_costa', 'Ana', 'Costa', 'ana.costa@email.com', 'hash_senha_101', 'https://avatar.example.com/ana.png'),
('550e8400-e29b-41d4-a716-446655440005', 'carlos_ferreira', 'Carlos', 'Ferreira', 'carlos.ferreira@email.com', 'hash_senha_202', 'https://avatar.example.com/carlos.png'),
('550e8400-e29b-41d4-a716-446655440006', 'julia_almeida', 'Julia', 'Almeida', 'julia.almeida@email.com', 'hash_senha_303', 'https://avatar.example.com/julia.png');

-- ============================================
-- 2. INSERINDO CONVIDADOS
-- ============================================

INSERT INTO guests (id, name, session_token) VALUES
('650e8400-e29b-41d4-a716-446655440001', 'Visitante_001', 'token_guest_aaa111'),
('650e8400-e29b-41d4-a716-446655440002', 'Visitante_002', 'token_guest_bbb222'),
('650e8400-e29b-41d4-a716-446655440003', 'Visitante_003', 'token_guest_ccc333');

-- ============================================
-- 3. INSERINDO JOGADORES
-- ============================================

-- Jogadores registrados (usuários)
INSERT INTO players (id, user_id, guest_id, total_quizzes_taken) VALUES
('750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', NULL, 15),
('750e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', NULL, 22),
('750e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', NULL, 8),
('750e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440004', NULL, 31),
('750e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440005', NULL, 12),
('750e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440006', NULL, 19);

-- Jogadores convidados (guests)
INSERT INTO players (id, user_id, guest_id, total_quizzes_taken) VALUES
('750e8400-e29b-41d4-a716-446655440007', NULL, '650e8400-e29b-41d4-a716-446655440001', 3),
('750e8400-e29b-41d4-a716-446655440008', NULL, '650e8400-e29b-41d4-a716-446655440002', 1),
('750e8400-e29b-41d4-a716-446655440009', NULL, '650e8400-e29b-41d4-a716-446655440003', 5);

-- ============================================
-- 4. INSERINDO TAGS
-- ============================================

INSERT INTO tags (id, name) VALUES
('850e8400-e29b-41d4-a716-446655440001', 'História'),
('850e8400-e29b-41d4-a716-446655440002', 'Geografia'),
('850e8400-e29b-41d4-a716-446655440003', 'Ciências'),
('850e8400-e29b-41d4-a716-446655440004', 'Matemática'),
('850e8400-e29b-41d4-a716-446655440005', 'Literatura'),
('850e8400-e29b-41d4-a716-446655440006', 'Tecnologia'),
('850e8400-e29b-41d4-a716-446655440007', 'Esportes'),
('850e8400-e29b-41d4-a716-446655440008', 'Entretenimento'),
('850e8400-e29b-41d4-a716-446655440009', 'Arte'),
('850e8400-e29b-41d4-a716-446655440010', 'Cultura Geral');

-- ============================================
-- 5. INSERINDO PERGUNTAS
-- ============================================

-- Perguntas de História
INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440001', 
 'Em que ano foi proclamada a Independência do Brasil?',
 '["1500", "1822", "1889", "1930"]'::jsonb,
 1,
 'A Independência do Brasil foi proclamada em 7 de setembro de 1822 por Dom Pedro I.');

INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440002',
 'Qual foi a primeira civilização a desenvolver a escrita?',
 '["Egípcios", "Sumérios", "Gregos", "Romanos"]'::jsonb,
 1,
 'Os Sumérios, na Mesopotâmia, desenvolveram a escrita cuneiforme por volta de 3200 a.C.');

-- Perguntas de Geografia
INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440003',
 'Qual é o maior país do mundo em extensão territorial?',
 '["Canadá", "China", "Estados Unidos", "Rússia"]'::jsonb,
 3,
 'A Rússia possui aproximadamente 17 milhões de km², sendo o maior país do mundo.');

INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440004',
 'Qual é a capital da Austrália?',
 '["Sydney", "Melbourne", "Canberra", "Brisbane"]'::jsonb,
 2,
 'Canberra é a capital da Austrália desde 1908.');

-- Perguntas de Ciências
INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440005',
 'Qual é o elemento químico mais abundante no universo?',
 '["Oxigênio", "Carbono", "Hidrogênio", "Hélio"]'::jsonb,
 2,
 'O Hidrogênio representa cerca de 75% da massa do universo.');

INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440006',
 'Quantos planetas existem no Sistema Solar?',
 '["7", "8", "9", "10"]'::jsonb,
 1,
 'Desde 2006, o Sistema Solar é oficialmente composto por 8 planetas, após Plutão ser reclassificado.');

-- Perguntas de Matemática
INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440007',
 'Quanto é a raiz quadrada de 144?',
 '["10", "11", "12", "13"]'::jsonb,
 2,
 'A raiz quadrada de 144 é 12, pois 12 × 12 = 144.');

INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440008',
 'Qual é o valor de Pi (π) aproximadamente?',
 '["2.14", "3.14", "4.14", "5.14"]'::jsonb,
 1,
 'Pi (π) é aproximadamente 3,14159...');

-- Perguntas de Literatura
INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440009',
 'Quem escreveu "Dom Casmurro"?',
 '["José de Alencar", "Machado de Assis", "Castro Alves", "Clarice Lispector"]'::jsonb,
 1,
 'Dom Casmurro foi escrito por Machado de Assis e publicado em 1899.');

INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440010',
 'Qual destes é um livro de Jorge Amado?',
 '["Grande Sertão: Veredas", "Capitães da Areia", "O Cortiço", "Memórias Póstumas"]'::jsonb,
 1,
 'Capitães da Areia é uma obra de Jorge Amado publicada em 1937.');

-- Perguntas de Tecnologia
INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440011',
 'O que significa a sigla SQL?',
 '["Standard Query Language", "Structured Query Language", "Simple Query Language", "System Query Language"]'::jsonb,
 1,
 'SQL significa Structured Query Language, linguagem de consulta estruturada.');

INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440012',
 'Quem é considerado o pai da computação?',
 '["Bill Gates", "Steve Jobs", "Alan Turing", "Mark Zuckerberg"]'::jsonb,
 2,
 'Alan Turing é considerado o pai da computação por suas contribuições fundamentais.');

-- Perguntas de Esportes
INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440013',
 'Quantos jogadores tem um time de futebol em campo?',
 '["10", "11", "12", "13"]'::jsonb,
 1,
 'Um time de futebol tem 11 jogadores em campo, incluindo o goleiro.');

INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440014',
 'Em que ano o Brasil ganhou sua primeira Copa do Mundo?',
 '["1950", "1958", "1962", "1970"]'::jsonb,
 1,
 'O Brasil ganhou sua primeira Copa do Mundo em 1958, na Suécia.');

-- Perguntas de Entretenimento
INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440015',
 'Qual é o filme com maior bilheteria da história?',
 '["Titanic", "Avatar", "Vingadores: Ultimato", "Star Wars"]'::jsonb,
 1,
 'Avatar é o filme com maior bilheteria da história, arrecadando quase 3 bilhões de dólares.');

INSERT INTO questions (id, content, options, correct_option, explanation) VALUES
('950e8400-e29b-41d4-a716-446655440016',
 'Qual banda lançou a música "Bohemian Rhapsody"?',
 '["The Beatles", "Queen", "Led Zeppelin", "Pink Floyd"]'::jsonb,
 1,
 'Bohemian Rhapsody foi lançada pela banda Queen em 1975.');

-- ============================================
-- 6. ASSOCIANDO TAGS ÀS PERGUNTAS
-- ============================================

-- História
INSERT INTO question_tags (question_id, tag_id) VALUES
('950e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440001'),
('950e8400-e29b-41d4-a716-446655440002', '850e8400-e29b-41d4-a716-446655440001');

-- Geografia
INSERT INTO question_tags (question_id, tag_id) VALUES
('950e8400-e29b-41d4-a716-446655440003', '850e8400-e29b-41d4-a716-446655440002'),
('950e8400-e29b-41d4-a716-446655440004', '850e8400-e29b-41d4-a716-446655440002');

-- Ciências
INSERT INTO question_tags (question_id, tag_id) VALUES
('950e8400-e29b-41d4-a716-446655440005', '850e8400-e29b-41d4-a716-446655440003'),
('950e8400-e29b-41d4-a716-446655440006', '850e8400-e29b-41d4-a716-446655440003');

-- Matemática
INSERT INTO question_tags (question_id, tag_id) VALUES
('950e8400-e29b-41d4-a716-446655440007', '850e8400-e29b-41d4-a716-446655440004'),
('950e8400-e29b-41d4-a716-446655440008', '850e8400-e29b-41d4-a716-446655440004');

-- Literatura
INSERT INTO question_tags (question_id, tag_id) VALUES
('950e8400-e29b-41d4-a716-446655440009', '850e8400-e29b-41d4-a716-446655440005'),
('950e8400-e29b-41d4-a716-446655440010', '850e8400-e29b-41d4-a716-446655440005');

-- Tecnologia
INSERT INTO question_tags (question_id, tag_id) VALUES
('950e8400-e29b-41d4-a716-446655440011', '850e8400-e29b-41d4-a716-446655440006'),
('950e8400-e29b-41d4-a716-446655440012', '850e8400-e29b-41d4-a716-446655440006');

-- Esportes
INSERT INTO question_tags (question_id, tag_id) VALUES
('950e8400-e29b-41d4-a716-446655440013', '850e8400-e29b-41d4-a716-446655440007'),
('950e8400-e29b-41d4-a716-446655440014', '850e8400-e29b-41d4-a716-446655440007');

-- Entretenimento
INSERT INTO question_tags (question_id, tag_id) VALUES
('950e8400-e29b-41d4-a716-446655440015', '850e8400-e29b-41d4-a716-446655440008'),
('950e8400-e29b-41d4-a716-446655440016', '850e8400-e29b-41d4-a716-446655440008');

-- ============================================
-- 7. INSERINDO JOGOS
-- ============================================

-- Jogo 1: Quiz de História (Completo)
INSERT INTO games (id, host_id, name, description, theme, status, created_at, finished_at) VALUES
('a50e8400-e29b-41d4-a716-446655440001',
 '750e8400-e29b-41d4-a716-446655440001',
 'Quiz de História do Brasil',
 'Teste seus conhecimentos sobre a história brasileira',
 'História',
 'completed',
 NOW() - INTERVAL '5 days',
 NOW() - INTERVAL '5 days' + INTERVAL '45 minutes');

-- Jogo 2: Quiz de Ciências (Em progresso)
INSERT INTO games (id, host_id, name, description, theme, status, created_at) VALUES
('a50e8400-e29b-41d4-a716-446655440002',
 '750e8400-e29b-41d4-a716-446655440002',
 'Desafio de Ciências',
 'Perguntas sobre física, química e biologia',
 'Ciências',
 'in_progress',
 NOW() - INTERVAL '30 minutes');

-- Jogo 3: Quiz Geral (Aguardando)
INSERT INTO games (id, host_id, name, description, theme, status, created_at) VALUES
('a50e8400-e29b-41d4-a716-446655440003',
 '750e8400-e29b-41d4-a716-446655440004',
 'Quiz Geral - Conhecimentos Diversos',
 'Um pouco de tudo para testar seu conhecimento',
 'Geral',
 'waiting',
 NOW() - INTERVAL '10 minutes');

-- Jogo 4: Quiz de Tecnologia (Completo)
INSERT INTO games (id, host_id, name, description, theme, status, created_at, finished_at) VALUES
('a50e8400-e29b-41d4-a716-446655440004',
 '750e8400-e29b-41d4-a716-446655440005',
 'Tech Quiz 2024',
 'Perguntas sobre tecnologia e programação',
 'Tecnologia',
 'completed',
 NOW() - INTERVAL '2 days',
 NOW() - INTERVAL '2 days' + INTERVAL '1 hour');

-- ============================================
-- 8. CONFIGURAÇÕES DOS JOGOS
-- ============================================

INSERT INTO game_configurations (game_id, time_per_question, randomize_questions, streak_multiplier, streak_start, room_size, questions_count, prompt) VALUES
('a50e8400-e29b-41d4-a716-446655440001', 30, FALSE, 2, 3, 6, 6, '{"tema": "História do Brasil", "dificuldade": "média"}'::jsonb),
('a50e8400-e29b-41d4-a716-446655440002', 45, TRUE, 1, 5, 8, 8, '{"tema": "Ciências", "dificuldade": "difícil"}'::jsonb),
('a50e8400-e29b-41d4-a716-446655440003', 20, TRUE, 2, 2, 12, 10, '{"tema": "Conhecimentos Gerais", "dificuldade": "fácil"}'::jsonb),
('a50e8400-e29b-41d4-a716-446655440004', 25, FALSE, 3, 3, 6, 6, '{"tema": "Tecnologia", "dificuldade": "média"}'::jsonb);

-- ============================================
-- 9. PERGUNTAS DOS JOGOS
-- ============================================

-- Jogo 1: Quiz de História
INSERT INTO game_questions (id, game_id, question_id, question_order) VALUES
('b50e8400-e29b-41d4-a716-446655440001', 'a50e8400-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440001', 1),
('b50e8400-e29b-41d4-a716-446655440002', 'a50e8400-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440002', 2),
('b50e8400-e29b-41d4-a716-446655440003', 'a50e8400-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440009', 3),
('b50e8400-e29b-41d4-a716-446655440004', 'a50e8400-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440010', 4),
('b50e8400-e29b-41d4-a716-446655440005', 'a50e8400-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440013', 5),
('b50e8400-e29b-41d4-a716-446655440006', 'a50e8400-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440014', 6);

-- Jogo 2: Quiz de Ciências
INSERT INTO game_questions (id, game_id, question_id, question_order) VALUES
('b50e8400-e29b-41d4-a716-446655440007', 'a50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440005', 1),
('b50e8400-e29b-41d4-a716-446655440008', 'a50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440006', 2),
('b50e8400-e29b-41d4-a716-446655440009', 'a50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440007', 3),
('b50e8400-e29b-41d4-a716-446655440010', 'a50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440008', 4),
('b50e8400-e29b-41d4-a716-446655440011', 'a50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440003', 5),
('b50e8400-e29b-41d4-a716-446655440012', 'a50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440004', 6),
('b50e8400-e29b-41d4-a716-446655440013', 'a50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440011', 7),
('b50e8400-e29b-41d4-a716-446655440014', 'a50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440012', 8);

-- Jogo 3: Quiz Geral
INSERT INTO game_questions (id, game_id, question_id, question_order) VALUES
('b50e8400-e29b-41d4-a716-446655440015', 'a50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440001', 1),
('b50e8400-e29b-41d4-a716-446655440016', 'a50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440003', 2),
('b50e8400-e29b-41d4-a716-446655440017', 'a50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440005', 3),
('b50e8400-e29b-41d4-a716-446655440018', 'a50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440007', 4),
('b50e8400-e29b-41d4-a716-446655440019', 'a50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440009', 5),
('b50e8400-e29b-41d4-a716-446655440020', 'a50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440011', 6),
('b50e8400-e29b-41d4-a716-446655440021', 'a50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440013', 7),
('b50e8400-e29b-41d4-a716-446655440022', 'a50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440015', 8),
('b50e8400-e29b-41d4-a716-446655440023', 'a50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440002', 9),
('b50e8400-e29b-41d4-a716-446655440024', 'a50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440004', 10);

-- Jogo 4: Quiz de Tecnologia
INSERT INTO game_questions (id, game_id, question_id, question_order) VALUES
('b50e8400-e29b-41d4-a716-446655440025', 'a50e8400-e29b-41d4-a716-446655440004', '950e8400-e29b-41d4-a716-446655440011', 1),
('b50e8400-e29b-41d4-a716-446655440026', 'a50e8400-e29b-41d4-a716-446655440004', '950e8400-e29b-41d4-a716-446655440012', 2),
('b50e8400-e29b-41d4-a716-446655440027', 'a50e8400-e29b-41d4-a716-446655440004', '950e8400-e29b-41d4-a716-446655440006', 3),
('b50e8400-e29b-41d4-a716-446655440028', 'a50e8400-e29b-41d4-a716-446655440004', '950e8400-e29b-41d4-a716-446655440007', 4),
('b50e8400-e29b-41d4-a716-446655440029', 'a50e8400-e29b-41d4-a716-446655440004', '950e8400-e29b-41d4-a716-446655440008', 5),
('b50e8400-e29b-41d4-a716-446655440030', 'a50e8400-e29b-41d4-a716-446655440004', '950e8400-e29b-41d4-a716-446655440015', 6);

-- ============================================
-- 10. JOGADORES NOS JOGOS
-- ============================================

-- Jogo 1 (Completo) - 4 jogadores
INSERT INTO player_games (id, player_id, game_id, role, joined_at, completed_at) VALUES
('c50e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', 'a50e8400-e29b-41d4-a716-446655440001', 'host', NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days' + INTERVAL '45 minutes'),
('c50e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002', 'a50e8400-e29b-41d4-a716-446655440001', 'participant', NOW() - INTERVAL '5 days' + INTERVAL '2 minutes', NOW() - INTERVAL '5 days' + INTERVAL '45 minutes'),
('c50e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440003', 'a50e8400-e29b-41d4-a716-446655440001', 'participant', NOW() - INTERVAL '5 days' + INTERVAL '5 minutes', NOW() - INTERVAL '5 days' + INTERVAL '45 minutes'),
('c50e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440007', 'a50e8400-e29b-41d4-a716-446655440001', 'participant', NOW() - INTERVAL '5 days' + INTERVAL '8 minutes', NOW() - INTERVAL '5 days' + INTERVAL '45 minutes');

-- Jogo 2 (Em progresso) - 5 jogadores
INSERT INTO player_games (id, player_id, game_id, role, joined_at) VALUES
('c50e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440002', 'a50e8400-e29b-41d4-a716-446655440002', 'host', NOW() - INTERVAL '30 minutes'),
('c50e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440004', 'a50e8400-e29b-41d4-a716-446655440002', 'participant', NOW() - INTERVAL '28 minutes'),
('c50e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440005', 'a50e8400-e29b-41d4-a716-446655440002', 'participant', NOW() - INTERVAL '25 minutes'),
('c50e8400-e29b-41d4-a716-446655440008', '750e8400-e29b-41d4-a716-446655440006', 'a50e8400-e29b-41d4-a716-446655440002', 'participant', NOW() - INTERVAL '23 minutes'),
('c50e8400-e29b-41d4-a716-446655440009', '750e8400-e29b-41d4-a716-446655440008', 'a50e8400-e29b-41d4-a716-446655440002', 'participant', NOW() - INTERVAL '20 minutes');

-- Jogo 3 (Aguardando) - 3 jogadores
INSERT INTO player_games (id, player_id, game_id, role, joined_at) VALUES
('c50e8400-e29b-41d4-a716-446655440010', '750e8400-e29b-41d4-a716-446655440004', 'a50e8400-e29b-41d4-a716-446655440003', 'host', NOW() - INTERVAL '10 minutes'),
('c50e8400-e29b-41d4-a716-446655440011', '750e8400-e29b-41d4-a716-446655440001', 'a50e8400-e29b-41d4-a716-446655440003', 'participant', NOW() - INTERVAL '8 minutes'),
('c50e8400-e29b-41d4-a716-446655440012', '750e8400-e29b-41d4-a716-446655440003', 'a50e8400-e29b-41d4-a716-446655440003', 'participant', NOW() - INTERVAL '5 minutes');

-- Jogo 4 (Completo) - 6 jogadores
INSERT INTO player_games (id, player_id, game_id, role, joined_at, completed_at) VALUES
('c50e8400-e29b-41d4-a716-446655440013', '750e8400-e29b-41d4-a716-446655440005', 'a50e8400-e29b-41d4-a716-446655440004', 'host', NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days' + INTERVAL '1 hour'),
('c50e8400-e29b-41d4-a716-446655440014', '750e8400-e29b-41d4-a716-446655440001', 'a50e8400-e29b-41d4-a716-446655440004', 'participant', NOW() - INTERVAL '2 days' + INTERVAL '1 minute', NOW() - INTERVAL '2 days' + INTERVAL '1 hour'),
('c50e8400-e29b-41d4-a716-446655440015', '750e8400-e29b-41d4-a716-446655440002', 'a50e8400-e29b-41d4-a716-446655440004', 'participant', NOW() - INTERVAL '2 days' + INTERVAL '3 minutes', NOW() - INTERVAL '2 days' + INTERVAL '1 hour'),
('c50e8400-e29b-41d4-a716-446655440016', '750e8400-e29b-41d4-a716-446655440004', 'a50e8400-e29b-41d4-a716-446655440004', 'participant', NOW() - INTERVAL '2 days' + INTERVAL '4 minutes', NOW() - INTERVAL '2 days' + INTERVAL '1 hour'),
('c50e8400-e29b-41d4-a716-446655440017', '750e8400-e29b-41d4-a716-446655440006', 'a50e8400-e29b-41d4-a716-446655440004', 'participant', NOW() - INTERVAL '2 days' + INTERVAL '5 minutes', NOW() - INTERVAL '2 days' + INTERVAL '1 hour'),
('c50e8400-e29b-41d4-a716-446655440018', '750e8400-e29b-41d4-a716-446655440009', 'a50e8400-e29b-41d4-a716-446655440004', 'participant', NOW() - INTERVAL '2 days' + INTERVAL '7 minutes', NOW() - INTERVAL '2 days' + INTERVAL '1 hour');

-- ============================================
-- 11. RODADAS DOS JOGOS
-- ============================================

-- Jogo 1 - 6 rodadas (completo)
INSERT INTO game_round (id, game_id, round_number, started_at, ended_at) VALUES
('d50e8400-e29b-41d4-a716-446655440001', 'a50e8400-e29b-41d4-a716-446655440001', 1, NOW() - INTERVAL '5 days' + INTERVAL '10 minutes', NOW() - INTERVAL '5 days' + INTERVAL '15 minutes'),
('d50e8400-e29b-41d4-a716-446655440002', 'a50e8400-e29b-41d4-a716-446655440001', 2, NOW() - INTERVAL '5 days' + INTERVAL '15 minutes', NOW() - INTERVAL '5 days' + INTERVAL '20 minutes'),
('d50e8400-e29b-41d4-a716-446655440003', 'a50e8400-e29b-41d4-a716-446655440001', 3, NOW() - INTERVAL '5 days' + INTERVAL '20 minutes', NOW() - INTERVAL '5 days' + INTERVAL '25 minutes'),
('d50e8400-e29b-41d4-a716-446655440004', 'a50e8400-e29b-41d4-a716-446655440001', 4, NOW() - INTERVAL '5 days' + INTERVAL '25 minutes', NOW() - INTERVAL '5 days' + INTERVAL '30 minutes'),
('d50e8400-e29b-41d4-a716-446655440005', 'a50e8400-e29b-41d4-a716-446655440001', 5, NOW() - INTERVAL '5 days' + INTERVAL '30 minutes', NOW() - INTERVAL '5 days' + INTERVAL '35 minutes'),
('d50e8400-e29b-41d4-a716-446655440006', 'a50e8400-e29b-41d4-a716-446655440001', 6, NOW() - INTERVAL '5 days' + INTERVAL '35 minutes', NOW() - INTERVAL '5 days' + INTERVAL '40 minutes');

-- Jogo 2 - 3 rodadas (em progresso)
INSERT INTO game_round (id, game_id, round_number, started_at, ended_at) VALUES
('d50e8400-e29b-41d4-a716-446655440007', 'a50e8400-e29b-41d4-a716-446655440002', 1, NOW() - INTERVAL '25 minutes', NOW() - INTERVAL '20 minutes'),
('d50e8400-e29b-41d4-a716-446655440008', 'a50e8400-e29b-41d4-a716-446655440002', 2, NOW() - INTERVAL '20 minutes', NOW() - INTERVAL '15 minutes'),
('d50e8400-e29b-41d4-a716-446655440009', 'a50e8400-e29b-41d4-a716-446655440002', 3, NOW() - INTERVAL '15 minutes', NULL);

-- Jogo 4 - 6 rodadas (completo)
INSERT INTO game_round (id, game_id, round_number, started_at, ended_at) VALUES
('d50e8400-e29b-41d4-a716-446655440010', 'a50e8400-e29b-41d4-a716-446655440004', 1, NOW() - INTERVAL '2 days' + INTERVAL '10 minutes', NOW() - INTERVAL '2 days' + INTERVAL '20 minutes'),
('d50e8400-e29b-41d4-a716-446655440011', 'a50e8400-e29b-41d4-a716-446655440004', 2, NOW() - INTERVAL '2 days' + INTERVAL '20 minutes', NOW() - INTERVAL '2 days' + INTERVAL '30 minutes'),
('d50e8400-e29b-41d4-a716-446655440012', 'a50e8400-e29b-41d4-a716-446655440004', 3, NOW() - INTERVAL '2 days' + INTERVAL '30 minutes', NOW() - INTERVAL '2 days' + INTERVAL '40 minutes'),
('d50e8400-e29b-41d4-a716-446655440013', 'a50e8400-e29b-41d4-a716-446655440004', 4, NOW() - INTERVAL '2 days' + INTERVAL '40 minutes', NOW() - INTERVAL '2 days' + INTERVAL '50 minutes'),
('d50e8400-e29b-41d4-a716-446655440014', 'a50e8400-e29b-41d4-a716-446655440004', 5, NOW() - INTERVAL '2 days' + INTERVAL '50 minutes', NOW() - INTERVAL '2 days' + INTERVAL '55 minutes'),
('d50e8400-e29b-41d4-a716-446655440015', 'a50e8400-e29b-41d4-a716-446655440004', 6, NOW() - INTERVAL '2 days' + INTERVAL '55 minutes', NOW() - INTERVAL '2 days' + INTERVAL '60 minutes');

-- ============================================
-- 12. RESPOSTAS DOS JOGADORES
-- ============================================

-- Jogo 1, Rodada 1
INSERT INTO game_round_answers (round_id, player_id, question_id, selected_option, is_correct) VALUES
('d50e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', 'b50e8400-e29b-41d4-a716-446655440001', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440002', 'b50e8400-e29b-41d4-a716-446655440001', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440003', 'b50e8400-e29b-41d4-a716-446655440001', 0, FALSE),
('d50e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440007', 'b50e8400-e29b-41d4-a716-446655440001', 1, TRUE);

-- Jogo 1, Rodada 2
INSERT INTO game_round_answers (round_id, player_id, question_id, selected_option, is_correct) VALUES
('d50e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440001', 'b50e8400-e29b-41d4-a716-446655440002', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002', 'b50e8400-e29b-41d4-a716-446655440002', 2, FALSE),
('d50e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440003', 'b50e8400-e29b-41d4-a716-446655440002', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440007', 'b50e8400-e29b-41d4-a716-446655440002', 0, FALSE);

-- Jogo 1, Rodada 3
INSERT INTO game_round_answers (round_id, player_id, question_id, selected_option, is_correct) VALUES
('d50e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440001', 'b50e8400-e29b-41d4-a716-446655440003', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440002', 'b50e8400-e29b-41d4-a716-446655440003', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440003', 'b50e8400-e29b-41d4-a716-446655440003', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440007', 'b50e8400-e29b-41d4-a716-446655440003', 2, FALSE);

-- Jogo 1, Rodada 4
INSERT INTO game_round_answers (round_id, player_id, question_id, selected_option, is_correct) VALUES
('d50e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440001', 'b50e8400-e29b-41d4-a716-446655440004', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440002', 'b50e8400-e29b-41d4-a716-446655440004', 0, FALSE),
('d50e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440003', 'b50e8400-e29b-41d4-a716-446655440004', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440007', 'b50e8400-e29b-41d4-a716-446655440004', 1, TRUE);

-- Jogo 1, Rodada 5
INSERT INTO game_round_answers (round_id, player_id, question_id, selected_option, is_correct) VALUES
('d50e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440001', 'b50e8400-e29b-41d4-a716-446655440005', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440002', 'b50e8400-e29b-41d4-a716-446655440005', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440003', 'b50e8400-e29b-41d4-a716-446655440005', 0, FALSE),
('d50e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440007', 'b50e8400-e29b-41d4-a716-446655440005', 1, TRUE);

-- Jogo 1, Rodada 6
INSERT INTO game_round_answers (round_id, player_id, question_id, selected_option, is_correct) VALUES
('d50e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440001', 'b50e8400-e29b-41d4-a716-446655440006', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440002', 'b50e8400-e29b-41d4-a716-446655440006', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440003', 'b50e8400-e29b-41d4-a716-446655440006', 1, TRUE),
('d50e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440007', 'b50e8400-e29b-41d4-a716-446655440006', 2, FALSE);

-- ============================================
-- 13. PONTUAÇÕES DOS JOGOS
-- ============================================

-- Jogo 1 (Completo)
INSERT INTO game_scores (player_id, game_id, score, correct_answers, total_questions, position) VALUES
('750e8400-e29b-41d4-a716-446655440001', 'a50e8400-e29b-41d4-a716-446655440001', 600, 6, 6, 1),
('750e8400-e29b-41d4-a716-446655440002', 'a50e8400-e29b-41d4-a716-446655440001', 400, 4, 6, 2),
('750e8400-e29b-41d4-a716-446655440003', 'a50e8400-e29b-41d4-a716-446655440001', 400, 4, 6, 3),
('750e8400-e29b-41d4-a716-446655440007', 'a50e8400-e29b-41d4-a716-446655440001', 300, 3, 6, 4);

-- Jogo 2 (Em progresso) - pontuações parciais
INSERT INTO game_scores (player_id, game_id, score, correct_answers, total_questions) VALUES
('750e8400-e29b-41d4-a716-446655440002', 'a50e8400-e29b-41d4-a716-446655440002', 200, 2, 3),
('750e8400-e29b-41d4-a716-446655440004', 'a50e8400-e29b-41d4-a716-446655440002', 300, 3, 3),
('750e8400-e29b-41d4-a716-446655440005', 'a50e8400-e29b-41d4-a716-446655440002', 200, 2, 3),
('750e8400-e29b-41d4-a716-446655440006', 'a50e8400-e29b-41d4-a716-446655440002', 100, 1, 3),
('750e8400-e29b-41d4-a716-446655440008', 'a50e8400-e29b-41d4-a716-446655440002', 200, 2, 3);

-- Jogo 4 (Completo)
INSERT INTO game_scores (player_id, game_id, score, correct_answers, total_questions, position) VALUES
('750e8400-e29b-41d4-a716-446655440005', 'a50e8400-e29b-41d4-a716-446655440004', 500, 5, 6, 1),
('750e8400-e29b-41d4-a716-446655440001', 'a50e8400-e29b-41d4-a716-446655440004', 500, 5, 6, 2),
('750e8400-e29b-41d4-a716-446655440004', 'a50e8400-e29b-41d4-a716-446655440004', 400, 4, 6, 3),
('750e8400-e29b-41d4-a716-446655440002', 'a50e8400-e29b-41d4-a716-446655440004', 400, 4, 6, 4),
('750e8400-e29b-41d4-a716-446655440006', 'a50e8400-e29b-41d4-a716-446655440004', 300, 3, 6, 5),
('750e8400-e29b-41d4-a716-446655440009', 'a50e8400-e29b-41d4-a716-446655440004', 200, 2, 6, 6);

-- ============================================
-- 14. EVENTOS DOS JOGOS
-- ============================================

-- Jogo 1 - Eventos
INSERT INTO game_events (game_id, event_type, event_data, created_at) VALUES
('a50e8400-e29b-41d4-a716-446655440001', 'game_created', '{"host": "João Silva", "theme": "História"}'::jsonb, NOW() - INTERVAL '5 days'),
('a50e8400-e29b-41d4-a716-446655440001', 'player_joined', '{"player": "Maria Santos"}'::jsonb, NOW() - INTERVAL '5 days' + INTERVAL '2 minutes'),
('a50e8400-e29b-41d4-a716-446655440001', 'player_joined', '{"player": "Pedro Oliveira"}'::jsonb, NOW() - INTERVAL '5 days' + INTERVAL '5 minutes'),
('a50e8400-e29b-41d4-a716-446655440001', 'player_joined', '{"player": "Visitante_001"}'::jsonb, NOW() - INTERVAL '5 days' + INTERVAL '8 minutes'),
('a50e8400-e29b-41d4-a716-446655440001', 'game_started', '{"players_count": 4}'::jsonb, NOW() - INTERVAL '5 days' + INTERVAL '10 minutes'),
('a50e8400-e29b-41d4-a716-446655440001', 'round_started', '{"round_number": 1}'::jsonb, NOW() - INTERVAL '5 days' + INTERVAL '10 minutes'),
('a50e8400-e29b-41d4-a716-446655440001', 'round_ended', '{"round_number": 1}'::jsonb, NOW() - INTERVAL '5 days' + INTERVAL '15 minutes'),
('a50e8400-e29b-41d4-a716-446655440001', 'game_completed', '{"winner": "João Silva", "score": 600}'::jsonb, NOW() - INTERVAL '5 days' + INTERVAL '45 minutes');

-- Jogo 2 - Eventos
INSERT INTO game_events (game_id, event_type, event_data, created_at) VALUES
('a50e8400-e29b-41d4-a716-446655440002', 'game_created', '{"host": "Maria Santos", "theme": "Ciências"}'::jsonb, NOW() - INTERVAL '30 minutes'),
('a50e8400-e29b-41d4-a716-446655440002', 'player_joined', '{"player": "Ana Costa"}'::jsonb, NOW() - INTERVAL '28 minutes'),
('a50e8400-e29b-41d4-a716-446655440002', 'player_joined', '{"player": "Carlos Ferreira"}'::jsonb, NOW() - INTERVAL '25 minutes'),
('a50e8400-e29b-41d4-a716-446655440002', 'player_joined', '{"player": "Julia Almeida"}'::jsonb, NOW() - INTERVAL '23 minutes'),
('a50e8400-e29b-41d4-a716-446655440002', 'player_joined', '{"player": "Visitante_002"}'::jsonb, NOW() - INTERVAL '20 minutes'),
('a50e8400-e29b-41d4-a716-446655440002', 'game_started', '{"players_count": 5}'::jsonb, NOW() - INTERVAL '15 minutes'),
('a50e8400-e29b-41d4-a716-446655440002', 'round_started', '{"round_number": 3}'::jsonb, NOW() - INTERVAL '15 minutes');

-- Jogo 3 - Eventos
INSERT INTO game_events (game_id, event_type, event_data, created_at) VALUES
('a50e8400-e29b-41d4-a716-446655440003', 'game_created', '{"host": "Ana Costa", "theme": "Geral"}'::jsonb, NOW() - INTERVAL '10 minutes'),
('a50e8400-e29b-41d4-a716-446655440003', 'player_joined', '{"player": "João Silva"}'::jsonb, NOW() - INTERVAL '8 minutes'),
('a50e8400-e29b-41d4-a716-446655440003', 'player_joined', '{"player": "Pedro Oliveira"}'::jsonb, NOW() - INTERVAL '5 minutes');

-- Jogo 4 - Eventos
INSERT INTO game_events (game_id, event_type, event_data, created_at) VALUES
('a50e8400-e29b-41d4-a716-446655440004', 'game_created', '{"host": "Carlos Ferreira", "theme": "Tecnologia"}'::jsonb, NOW() - INTERVAL '2 days'),
('a50e8400-e29b-41d4-a716-446655440004', 'game_started', '{"players_count": 6}'::jsonb, NOW() - INTERVAL '2 days' + INTERVAL '10 minutes'),
('a50e8400-e29b-41d4-a716-446655440004', 'game_completed', '{"winner": "Carlos Ferreira", "score": 500}'::jsonb, NOW() - INTERVAL '2 days' + INTERVAL '1 hour');
