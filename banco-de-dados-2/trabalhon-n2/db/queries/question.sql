-- ============================================
-- QUESTIONS QUERIES
-- ============================================

-- name: CreateQuestion :one
INSERT INTO questions (
    content, options, correct_option, explanation
)
VALUES (
    @content, @options, @correct_option, @explanation
)
RETURNING *;

-- name: GetQuestionByID :one
SELECT * FROM questions
WHERE id = @id;

-- name: ListQuestions :many
SELECT * FROM questions
ORDER BY created_at DESC
LIMIT @limit_val OFFSET @offset_val;

-- name: UpdateQuestion :one
UPDATE questions
SET 
    content = COALESCE(@content, content),
    options = COALESCE(@options, options),
    correct_option = COALESCE(@correct_option, correct_option),
    explanation = COALESCE(@explanation, explanation),
    updated_at = CURRENT_TIMESTAMP
WHERE id = @id
RETURNING *;

-- name: DeleteQuestion :exec
DELETE FROM questions
WHERE id = @id;

-- name: CountQuestions :one
SELECT COUNT(*) FROM questions;

-- ============================================
-- TAGS QUERIES
-- ============================================

-- name: CreateTag :one
INSERT INTO tags (name)
VALUES (@name)
ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name
RETURNING *;

-- name: GetTagByID :one
SELECT * FROM tags
WHERE id = @id;

-- name: GetTagByName :one
SELECT * FROM tags
WHERE name = @name;

-- name: ListTags :many
SELECT * FROM tags
ORDER BY name
LIMIT @limit_val OFFSET @offset_val;

-- name: DeleteTag :exec
DELETE FROM tags
WHERE id = @id;

-- name: CountTags :one
SELECT COUNT(*) FROM tags;

-- ============================================
-- QUESTION_TAGS QUERIES
-- ============================================

-- name: AddTagToQuestion :exec
INSERT INTO question_tags (question_id, tag_id)
VALUES (@question_id, @tag_id)
ON CONFLICT (question_id, tag_id) DO NOTHING;

-- name: RemoveTagFromQuestion :exec
DELETE FROM question_tags
WHERE question_id = @question_id AND tag_id = @tag_id;

-- name: GetQuestionWithTags :one
SELECT 
    q.*,
    COALESCE(
        json_agg(
            json_build_object('id', t.id, 'name', t.name)
        ) FILTER (WHERE t.id IS NOT NULL),
        '[]'
    ) as tags
FROM questions q
LEFT JOIN question_tags qt ON q.id = qt.question_id
LEFT JOIN tags t ON qt.tag_id = t.id
WHERE q.id = @question_id
GROUP BY q.id;

-- name: CountQuestionsByTag :one
SELECT COUNT(*) FROM question_tags
WHERE tag_id = @tag_id;

-- name: DeleteQuestionTags :exec
DELETE FROM question_tags
WHERE question_id = @question_id;

-- ============================================
-- GAME_QUESTIONS QUERIES
-- ============================================

-- name: AddQuestionToGame :one
INSERT INTO game_questions (
    game_id, question_id, question_order
)
VALUES (
    @game_id, @question_id, @question_order
)
RETURNING *;

-- name: GetGameQuestion :one
SELECT * FROM game_questions
WHERE id = @id;

-- name: ListGameQuestions :many
SELECT 
    gq.*,
    q.content,
    q.options,
    q.correct_option,
    q.explanation
FROM game_questions gq
INNER JOIN questions q ON gq.question_id = q.id
WHERE gq.game_id = @game_id
ORDER BY gq.question_order;

-- name: GetGameQuestionByOrder :one
SELECT 
    gq.*,
    q.content,
    q.options,
    q.correct_option,
    q.explanation
FROM game_questions gq
INNER JOIN questions q ON gq.question_id = q.id
WHERE gq.game_id = @game_id AND gq.question_order = @question_order;

-- name: RemoveQuestionFromGame :exec
DELETE FROM game_questions
WHERE game_id = @game_id AND question_id = @question_id;

-- name: DeleteGameQuestions :exec
DELETE FROM game_questions
WHERE game_id = @game_id;

-- name: CountGameQuestions :one
SELECT COUNT(*) FROM game_questions
WHERE game_id = @game_id;

-- name: ReorderGameQuestions :exec
UPDATE game_questions
SET question_order = @new_order
WHERE id = @id;

-- ============================================
-- GAME_ROUND_ANSWERS QUERIES
-- ============================================

-- name: CreateGameRoundAnswer :one
INSERT INTO game_round_answers (
    round_id, player_id, question_id, selected_option, is_correct
)
VALUES (
    @round_id, @player_id, @question_id, @selected_option, @is_correct
)
RETURNING *;

-- name: GetGameRoundAnswer :one
SELECT * FROM game_round_answers
WHERE id = @id;

-- name: GetPlayerAnswer :one
SELECT * FROM game_round_answers
WHERE round_id = @round_id 
  AND player_id = @player_id 
  AND question_id = @question_id;

-- name: ListRoundAnswers :many
SELECT 
    gra.*,
    p.id as player_id,
    u.username,
    u.first_name,
    u.last_name,
    g.name as guest_name
FROM game_round_answers gra
INNER JOIN players p ON gra.player_id = p.id
LEFT JOIN users u ON p.user_id = u.id
LEFT JOIN guests g ON p.guest_id = g.id
WHERE gra.round_id = @round_id
ORDER BY gra.answered_at;

-- name: ListPlayerAnswersInRound :many
SELECT 
    gra.*,
    gq.question_order,
    q.content as question_content,
    q.options,
    q.correct_option
FROM game_round_answers gra
INNER JOIN game_questions gq ON gra.question_id = gq.id
INNER JOIN questions q ON gq.question_id = q.id
WHERE gra.round_id = @round_id AND gra.player_id = @player_id
ORDER BY gq.question_order;

-- name: CountCorrectAnswersInRound :one
SELECT COUNT(*) FROM game_round_answers
WHERE round_id = @round_id 
  AND player_id = @player_id 
  AND is_correct = true;

-- name: CountPlayerAnswersInRound :one
SELECT COUNT(*) FROM game_round_answers
WHERE round_id = @round_id AND player_id = @player_id;

-- name: GetRoundStatistics :one
SELECT 
    COUNT(*) as total_answers,
    COUNT(*) FILTER (WHERE is_correct = true) as correct_answers,
    COUNT(*) FILTER (WHERE is_correct = false) as incorrect_answers,
    AVG(EXTRACT(EPOCH FROM (answered_at - 
        (SELECT started_at FROM game_round WHERE game_round.id = @round_id)
    ))) as average_response_time
FROM game_round_answers
WHERE round_id = @round_id;

-- name: DeleteGameRoundAnswer :exec
DELETE FROM game_round_answers
WHERE id = @id;

-- name: DeleteRoundAnswers :exec
DELETE FROM game_round_answers
WHERE round_id = @round_id;