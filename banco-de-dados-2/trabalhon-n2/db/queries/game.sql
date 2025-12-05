 -- ============================================
-- GAMES QUERIES
-- =============================================

-- name: CreateGame :one
INSERT INTO games (
    host_id, name, description, theme, status
)
VALUES (
    @host_id, @name, @description, @theme, @status
)
RETURNING *;

-- name: GetGameByID :one
SELECT * FROM games
WHERE id = @id;

-- name: GetGameWithHost :one
SELECT 
    g.*,
    p.id as host_player_id,
    u.username as host_username,
    u.first_name as host_first_name,
    u.last_name as host_last_name,
    guest.name as host_guest_name
FROM games g
INNER JOIN players p ON g.host_id = p.id
LEFT JOIN users u ON p.user_id = u.id
LEFT JOIN guests guest ON p.guest_id = guest.id
WHERE g.id = @id;

-- name: ListGames :many
SELECT * FROM games
WHERE host_id = @host_id OR status = @status
ORDER BY created_at DESC
LIMIT @limit_val OFFSET @offset_val;

-- name: UpdateGameStatus :one
UPDATE games
SET 
    status = @status,
    updated_at = CURRENT_TIMESTAMP
WHERE id = @id
RETURNING *;

-- name: UpdateGame :one
UPDATE games
SET 
    name = COALESCE(@name, name),
    description = COALESCE(@description, description),
    theme = COALESCE(@theme, theme),
    updated_at = CURRENT_TIMESTAMP
WHERE id = @id
RETURNING *;

-- name: FinishGame :one
UPDATE games
SET 
    status = 'completed',
    finished_at = CURRENT_TIMESTAMP,
    updated_at = CURRENT_TIMESTAMP
WHERE id = @id
RETURNING *;

-- name: StartGame :one
UPDATE games
SET 
    status = 'in_progress',
    updated_at = CURRENT_TIMESTAMP
WHERE id = @id
RETURNING *;

-- name: DeleteGame :exec
DELETE FROM games
WHERE id = @id;

-- name: CountGames :one
SELECT COUNT(*) FROM games;

-- name: CountGamesByStatus :one
SELECT COUNT(*) FROM games
WHERE status = @status;

-- ============================================
-- PLAYER_GAMES QUERIES
-- ============================================

-- name: AddPlayerToGame :one
INSERT INTO player_games (
    player_id, game_id, role
)
VALUES (
    @player_id, @game_id, @role
)
RETURNING *;

-- name: GetPlayerGame :one
SELECT * FROM player_games
WHERE player_id = @player_id AND game_id = @game_id;

-- name: ListPlayersInGame :many
SELECT 
    pg.*,
    p.id as player_id,
    u.username,
    u.first_name,
    u.last_name,
    u.icon,
    g.name as guest_name
FROM player_games pg
INNER JOIN players p ON pg.player_id = p.id
LEFT JOIN users u ON p.user_id = u.id
LEFT JOIN guests g ON p.guest_id = g.id
WHERE pg.game_id = @game_id
ORDER BY pg.joined_at;

-- name: ListGamesByPlayer :many
SELECT 
    g.*,
    pg.role,
    pg.joined_at,
    pg.completed_at
FROM games g
INNER JOIN player_games pg ON g.id = pg.game_id
WHERE pg.player_id = @player_id
ORDER BY pg.joined_at DESC
LIMIT @limit_val OFFSET @offset_val;

-- name: RemovePlayerFromGame :exec
UPDATE player_games
SET left_at = CURRENT_TIMESTAMP
WHERE player_id = @player_id AND game_id = @game_id;

-- name: CompletePlayerGame :exec
UPDATE player_games
SET completed_at = CURRENT_TIMESTAMP
WHERE player_id = @player_id AND game_id = @game_id;

-- name: CountPlayersInGame :one
SELECT COUNT(*) FROM player_games
WHERE game_id = @game_id AND left_at IS NULL;

-- name: DeletePlayerGame :exec
DELETE FROM player_games
WHERE player_id = @player_id AND game_id = @game_id;

-- ============================================
-- GAME_CONFIGURATIONS QUERIES
-- ============================================

-- name: CreateGameConfiguration :one
INSERT INTO game_configurations (
    game_id, time_per_question, randomize_questions, 
    streak_multiplier, streak_start, room_size, 
    questions_count, prompt
)
VALUES (
    @game_id, @time_per_question, @randomize_questions,
    @streak_multiplier, @streak_start, @room_size,
    @questions_count, @prompt
)
RETURNING *;

-- name: GetGameConfiguration :one
SELECT * FROM game_configurations
WHERE game_id = @game_id;

-- name: UpdateGameConfiguration :one
UPDATE game_configurations
SET 
    time_per_question = COALESCE(@time_per_question, time_per_question),
    randomize_questions = COALESCE(@randomize_questions, randomize_questions),
    streak_multiplier = COALESCE(@streak_multiplier, streak_multiplier),
    streak_start = COALESCE(@streak_start, streak_start),
    room_size = COALESCE(@room_size, room_size),
    questions_count = COALESCE(@questions_count, questions_count),
    prompt = COALESCE(@prompt, prompt),
    updated_at = CURRENT_TIMESTAMP
WHERE game_id = @game_id
RETURNING *;

-- name: DeleteGameConfiguration :exec
DELETE FROM game_configurations
WHERE game_id = @game_id;

-- ============================================
-- GAME_EVENTS QUERIES
-- ============================================

-- name: CreateGameEvent :one
INSERT INTO game_events (
    game_id, event_type, event_data
)
VALUES (
    @game_id, @event_type, @event_data
)
RETURNING *;

-- name: GetGameEvent :one
SELECT * FROM game_events
WHERE id = @id;

-- name: ListGameEvents :many
SELECT * FROM game_events
WHERE game_id = @game_id
ORDER BY created_at DESC
LIMIT @limit_val OFFSET @offset_val;

-- name: ListGameEventsByType :many
SELECT * FROM game_events
WHERE game_id = @game_id AND event_type = @event_type
ORDER BY created_at DESC
LIMIT @limit_val OFFSET @offset_val;

-- name: DeleteGameEvent :exec
DELETE FROM game_events
WHERE id = @id;

-- name: DeleteGameEvents :exec
DELETE FROM game_events
WHERE game_id = @game_id;

-- ============================================
-- GAME_SCORES QUERIES
-- ============================================

-- name: CreateGameScore :one
INSERT INTO game_scores (
    player_id, game_id, score, correct_answers, total_questions
)
VALUES (
    @player_id, @game_id, @score, @correct_answers, @total_questions
)
RETURNING *;

-- name: GetGameScore :one
SELECT * FROM game_scores
WHERE player_id = @player_id AND game_id = @game_id;

-- name: GetGameScoreWithPlayerInfo :one
SELECT 
    gs.*,
    u.username,
    u.first_name,
    u.last_name,
    u.icon,
    g.name as guest_name
FROM game_scores gs
INNER JOIN players p ON gs.player_id = p.id
LEFT JOIN users u ON p.user_id = u.id
LEFT JOIN guests g ON p.guest_id = g.id
WHERE gs.player_id = @player_id AND gs.game_id = @game_id;

-- name: ListGameScores :many
SELECT 
    gs.*,
    u.username,
    u.first_name,
    u.last_name,
    u.icon,
    g.name as guest_name
FROM game_scores gs
INNER JOIN players p ON gs.player_id = p.id
LEFT JOIN users u ON p.user_id = u.id
LEFT JOIN guests g ON p.guest_id = g.id
WHERE gs.game_id = @game_id
ORDER BY gs.score DESC, gs.created_at ASC;

-- name: ListPlayerScores :many
SELECT 
    gs.*,
    gm.name as game_name,
    gm.theme as game_theme
FROM game_scores gs
INNER JOIN games gm ON gs.game_id = gm.id
WHERE gs.player_id = @player_id
ORDER BY gs.created_at DESC
LIMIT @limit_val OFFSET @offset_val;

-- name: UpdateGameScore :one
UPDATE game_scores
SET 
    score = @score,
    correct_answers = @correct_answers,
    total_questions = @total_questions,
    position = @position,
    updated_at = CURRENT_TIMESTAMP
WHERE player_id = @player_id AND game_id = @game_id
RETURNING *;

-- name: UpdateGameScorePosition :exec
UPDATE game_scores
SET 
    position = @position,
    updated_at = CURRENT_TIMESTAMP
WHERE player_id = @player_id AND game_id = @game_id;

-- name: IncrementGameScore :one
UPDATE game_scores
SET 
    score = score + @points,
    correct_answers = correct_answers + @correct_increment,
    total_questions = total_questions + 1,
    updated_at = CURRENT_TIMESTAMP
WHERE player_id = @player_id AND game_id = @game_id
RETURNING *;

-- name: DeleteGameScore :exec
DELETE FROM game_scores
WHERE player_id = @player_id AND game_id = @game_id;

-- name: GetTopScores :many
SELECT 
    gs.*,
    u.username,
    u.first_name,
    u.last_name,
    u.icon,
    g.name as guest_name,
    gm.name as game_name
FROM game_scores gs
INNER JOIN players p ON gs.player_id = p.id
INNER JOIN games gm ON gs.game_id = gm.id
LEFT JOIN users u ON p.user_id = u.id
LEFT JOIN guests g ON p.guest_id = g.id
ORDER BY gs.score DESC
LIMIT @limit_val;

-- ============================================
-- GAME_ROUND QUERIES
-- ============================================

-- name: CreateGameRound :one
INSERT INTO game_round (
    game_id, round_number
)
VALUES (
    @game_id, @round_number
)
RETURNING *;

-- name: GetGameRound :one
SELECT * FROM game_round
WHERE id = @id;

-- name: GetGameRoundByNumber :one
SELECT * FROM game_round
WHERE game_id = @game_id AND round_number = @round_number;

-- name: ListGameRounds :many
SELECT * FROM game_round
WHERE game_id = @game_id
ORDER BY round_number;

-- name: GetCurrentGameRound :one
SELECT * FROM game_round
WHERE game_id = @game_id AND ended_at IS NULL
ORDER BY round_number DESC
LIMIT 1;

-- name: EndGameRound :one
UPDATE game_round
SET ended_at = CURRENT_TIMESTAMP
WHERE id = @id
RETURNING *;

-- name: DeleteGameRound :exec
DELETE FROM game_round
WHERE id = @id;

-- name: CountGameRounds :one
SELECT COUNT(*) FROM game_round
WHERE game_id = @game_id;