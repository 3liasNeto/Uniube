CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- * ENUM TYPES
CREATE TYPE player_role AS ENUM ('participant', 'host');
CREATE TYPE game_status AS ENUM ('waiting', 'in_progress', 'completed');

-- *============================================
-- * USERS, GUESTS AND PLAYERS TABLES
-- *============================================

CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    icon VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

-- * Índices para users
CREATE INDEX idx_users_username ON users(username) WHERE deleted_at IS NULL;
CREATE INDEX idx_users_email ON users(email) WHERE deleted_at IS NULL;
CREATE INDEX idx_users_deleted_at ON users(deleted_at) WHERE deleted_at IS NOT NULL;

CREATE TABLE guests (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    session_token VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- *Índice para guests
CREATE INDEX idx_guests_session_token ON guests(session_token);

CREATE TABLE players (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID UNIQUE,
    guest_id UUID UNIQUE,
    total_quizzes_taken INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (guest_id) REFERENCES guests(id) ON DELETE CASCADE,
    CHECK (
        (user_id IS NOT NULL AND guest_id IS NULL) OR
        (user_id IS NULL AND guest_id IS NOT NULL)
    )
);

-- * Índices para players
CREATE INDEX idx_players_user_id ON players(user_id) WHERE user_id IS NOT NULL;
CREATE INDEX idx_players_guest_id ON players(guest_id) WHERE guest_id IS NOT NULL;

-- * ============================================
-- * GAMES TABLE
-- * ============================================

CREATE TABLE games (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(500),
    theme VARCHAR(100),
    status game_status DEFAULT 'waiting',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    finished_at TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES players(id) ON DELETE CASCADE
);

-- * Índices para games
CREATE INDEX idx_games_host_id ON games(host_id);
CREATE INDEX idx_games_status ON games(status);
CREATE INDEX idx_games_created_at ON games(created_at DESC);
CREATE INDEX idx_games_status_created ON games(status, created_at DESC);

-- *============================================
-- * INTERMEDIATE TABLE BETWEEN PLAYERS AND GAMES
-- *============================================

CREATE TABLE player_games (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    player_id UUID NOT NULL,
    game_id UUID NOT NULL,
    role player_role DEFAULT 'participant',
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    left_at TIMESTAMP,
    completed_at TIMESTAMP,
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE,
    UNIQUE(player_id, game_id)
);

-- * Índices para player_games
CREATE INDEX idx_player_games_player_id ON player_games(player_id);
CREATE INDEX idx_player_games_game_id ON player_games(game_id);
CREATE INDEX idx_player_games_role ON player_games(role);
CREATE INDEX idx_player_games_joined_at ON player_games(joined_at DESC);

-- * ============================================
-- * GAME CONFIGURATIONS
-- * ============================================

CREATE TABLE game_configurations (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    game_id UUID NOT NULL,
    time_per_question INTEGER DEFAULT 30,
    randomize_questions BOOLEAN DEFAULT FALSE,
    streak_multiplier INTEGER DEFAULT 1,
    streak_start INTEGER DEFAULT 3,
    room_size INTEGER DEFAULT 6 CHECK (room_size <= 12),
    questions_count INTEGER DEFAULT 6 CHECK (questions_count <= 20),
    prompt JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE,
    UNIQUE(game_id)
);

-- * Índice para game_configurations
CREATE INDEX idx_game_configurations_game_id ON game_configurations(game_id);

-- * ============================================
-- * GAME EVENTS
-- * ============================================

CREATE TABLE game_events (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    game_id UUID NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    event_data JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE
);

-- * Índices para game_events
CREATE INDEX idx_game_events_game_id ON game_events(game_id);
CREATE INDEX idx_game_events_type ON game_events(event_type);
CREATE INDEX idx_game_events_created_at ON game_events(created_at DESC);
CREATE INDEX idx_game_events_game_created ON game_events(game_id, created_at DESC);

-- * ============================================
-- * GAME SCORES
-- * ============================================

CREATE TABLE game_scores (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    player_id UUID NOT NULL,
    game_id UUID NOT NULL,
    score INTEGER DEFAULT 0,
    correct_answers INTEGER DEFAULT 0,
    total_questions INTEGER DEFAULT 0,
    position INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE,
    UNIQUE(player_id, game_id)
);

-- * Índices para game_scores
CREATE INDEX idx_game_scores_player_id ON game_scores(player_id);
CREATE INDEX idx_game_scores_game_id ON game_scores(game_id);
CREATE INDEX idx_game_scores_score ON game_scores(score DESC);
CREATE INDEX idx_game_scores_game_score ON game_scores(game_id, score DESC);
CREATE INDEX idx_game_scores_position ON game_scores(game_id, position);

-- * ============================================
-- * GAME ROUNDS
-- * ============================================

CREATE TABLE game_round (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    game_id UUID NOT NULL,
    round_number INTEGER NOT NULL,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ended_at TIMESTAMP,
    FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE,
    UNIQUE(game_id, round_number)
);

-- * Índices para game_round
CREATE INDEX idx_game_round_game_id ON game_round(game_id);
CREATE INDEX idx_game_round_game_round ON game_round(game_id, round_number);

-- *============================================
-- * QUESTIONS TABLES
-- *============================================

CREATE TABLE questions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    content TEXT NOT NULL,
    options JSONB NOT NULL,
    correct_option INTEGER NOT NULL,
    explanation TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- * Índices para questions
CREATE INDEX idx_questions_created_at ON questions(created_at DESC);

-- *============================================
-- * TAGS TABLE
-- *============================================

CREATE TABLE tags (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- * Índice para tags
CREATE INDEX idx_tags_name ON tags(name);

-- *============================================
-- * QUESTION_TAGS
-- *============================================

CREATE TABLE question_tags (
    question_id UUID NOT NULL,
    tag_id UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (question_id, tag_id),
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

-- * Índices para question_tags
CREATE INDEX idx_question_tags_question_id ON question_tags(question_id);
CREATE INDEX idx_question_tags_tag_id ON question_tags(tag_id);

-- *============================================
-- * GAME QUESTIONS
-- *============================================

CREATE TABLE game_questions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    game_id UUID NOT NULL,
    question_id UUID NOT NULL,
    question_order INTEGER NOT NULL,
    FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE RESTRICT,
    UNIQUE(game_id, question_order),
    UNIQUE(game_id, question_id)
);

-- *  Índices para game_questions
CREATE INDEX idx_game_questions_game_id ON game_questions(game_id);
CREATE INDEX idx_game_questions_question_id ON game_questions(question_id);
CREATE INDEX idx_game_questions_game_order ON game_questions(game_id, question_order);

-- *============================================
-- * GAME ROUND ANSWERS
-- *============================================

CREATE TABLE game_round_answers (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    round_id UUID NOT NULL,
    player_id UUID NOT NULL,
    question_id UUID NOT NULL,
    selected_option INTEGER NOT NULL,
    is_correct BOOLEAN NOT NULL,
    answered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (round_id) REFERENCES game_round(id) ON DELETE CASCADE,
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES game_questions(id) ON DELETE CASCADE,
    UNIQUE(round_id, player_id, question_id)
);

-- * Índices para game_round_answers
CREATE INDEX idx_game_round_answers_round_id ON game_round_answers(round_id);
CREATE INDEX idx_game_round_answers_player_id ON game_round_answers(player_id);
CREATE INDEX idx_game_round_answers_question_id ON game_round_answers(question_id);
CREATE INDEX idx_game_round_answers_is_correct ON game_round_answers(is_correct);
CREATE INDEX idx_game_round_answers_answered_at ON game_round_answers(answered_at);