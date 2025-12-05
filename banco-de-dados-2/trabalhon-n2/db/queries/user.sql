 -- ============================================
-- USER QUERIES
-- =============================================
-- name: CreateUser :one
INSERT INTO users (
    username, first_name, last_name, email, password, icon
)
VALUES (
    @username, @first_name, @last_name, @email, @password, @icon
)
RETURNING *;

-- name: GetUserByID :one
SELECT * FROM users
WHERE id = @id AND deleted_at IS NULL;

-- name: GetUserByEmail :one
SELECT * FROM users
WHERE email = @email AND deleted_at IS NULL;

-- name: GetUserByUsername :one
SELECT * FROM users
WHERE username = @username AND deleted_at IS NULL;

-- name: ListUsers :many
SELECT * FROM users
WHERE deleted_at IS NULL
ORDER BY created_at DESC
LIMIT @limit_val OFFSET @offset_val;

-- name: UpdateUser :one
UPDATE users
SET 
    username = COALESCE(@username, username),
    first_name = COALESCE(@first_name, first_name),
    last_name = COALESCE(@last_name, last_name),
    email = COALESCE(@email, email),
    icon = COALESCE(@icon, icon),
    updated_at = CURRENT_TIMESTAMP
WHERE id = @id AND deleted_at IS NULL
RETURNING *;

-- name: UpdateUserPassword :exec
UPDATE users
SET 
    password = @password,
    updated_at = CURRENT_TIMESTAMP
WHERE id = @id AND deleted_at IS NULL;

-- name: SoftDeleteUser :exec
UPDATE users
SET deleted_at = CURRENT_TIMESTAMP
WHERE id = @id;

-- name: HardDeleteUser :exec
DELETE FROM users
WHERE id = @id;

-- name: CountUsers :one
SELECT COUNT(*) FROM users
WHERE deleted_at IS NULL;

-- name: SearchUsersByUsername :many
SELECT * FROM users
WHERE username ILIKE '%' || @search_term || '%'
  AND deleted_at IS NULL
ORDER BY username
LIMIT @limit_val;

-- ============================================
-- GUESTS QUERIES
-- ============================================

-- name: CreateGuest :one
INSERT INTO guests (name, session_token)
VALUES (@name, @session_token)
RETURNING *;

-- name: GetGuestByID :one
SELECT * FROM guests
WHERE id = @id;

-- name: GetGuestBySessionToken :one
SELECT * FROM guests
WHERE session_token = @session_token;

-- name: DeleteGuest :exec
DELETE FROM guests
WHERE id = @id;

-- name: ListGuests :many
SELECT * FROM guests
ORDER BY created_at DESC
LIMIT @limit_val OFFSET @offset_val;

-- ============================================
-- PLAYERS QUERIES
-- ============================================

-- name: CreatePlayerFromUser :one
INSERT INTO players (user_id)
VALUES (@user_id)
RETURNING *;

-- name: CreatePlayerFromGuest :one
INSERT INTO players (guest_id)
VALUES (@guest_id)
RETURNING *;

-- name: GetPlayerByID :one
SELECT * FROM players
WHERE id = @id;

-- name: GetPlayerByUserID :one
SELECT * FROM players
WHERE user_id = @user_id;

-- name: GetPlayerByGuestID :one
SELECT * FROM players
WHERE guest_id = @guest_id;

-- name: GetPlayerWithUserInfo :one
SELECT 
    p.*,
    u.username,
    u.first_name,
    u.last_name,
    u.email,
    u.icon as user_icon,
    g.name as guest_name
FROM players p
LEFT JOIN users u ON p.user_id = u.id
LEFT JOIN guests g ON p.guest_id = g.id
WHERE p.id = @id;

-- name: ListPlayers :many
SELECT 
    p.*,
    u.username,
    u.first_name,
    u.last_name,
    g.name as guest_name
FROM players p
LEFT JOIN users u ON p.user_id = u.id
LEFT JOIN guests g ON p.guest_id = g.id
ORDER BY p.created_at DESC
LIMIT @limit_val OFFSET @offset_val;

-- name: UpdatePlayerQuizzesTaken :exec
UPDATE players
SET 
    total_quizzes_taken = total_quizzes_taken + 1,
    updated_at = CURRENT_TIMESTAMP
WHERE id = @id;

-- name: GetPlayerStats :one
SELECT 
    p.id,
    p.total_quizzes_taken,
    COUNT(DISTINCT pg.game_id) as total_games_played,
    COALESCE(AVG(gs.score), 0) as average_score,
    COALESCE(MAX(gs.score), 0) as best_score,
    COALESCE(SUM(gs.correct_answers), 0) as total_correct_answers,
    COALESCE(SUM(gs.total_questions), 0) as total_questions_answered
FROM players p
LEFT JOIN player_games pg ON p.id = pg.player_id
LEFT JOIN game_scores gs ON p.id = gs.player_id
WHERE p.id = @id
GROUP BY p.id, p.total_quizzes_taken;

-- name: DeletePlayer :exec
DELETE FROM players
WHERE id = @id;

-- name: CountPlayers :one
SELECT COUNT(*) FROM players;