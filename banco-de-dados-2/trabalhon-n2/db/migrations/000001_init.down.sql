-- ============================================================================
-- Migration: 000001_init.down.sql
-- Descrição: Reverte a inicialização completa do banco de dados
-- ============================================================================

-- Remover views
DROP VIEW IF EXISTS v_game_leaderboard;
DROP VIEW IF EXISTS v_players_info;

-- Remover triggers
DROP TRIGGER IF EXISTS update_questions_updated_at ON questions;
DROP TRIGGER IF EXISTS update_game_scores_updated_at ON game_scores;
DROP TRIGGER IF EXISTS update_game_configurations_updated_at ON game_configurations;
DROP TRIGGER IF EXISTS update_games_updated_at ON games;
DROP TRIGGER IF EXISTS update_players_updated_at ON players;
DROP TRIGGER IF EXISTS update_guests_updated_at ON guests;
DROP TRIGGER IF EXISTS update_users_updated_at ON users;

-- Remover function
DROP FUNCTION IF EXISTS update_updated_at_column();

-- Remover tabelas (ordem reversa das dependências)
DROP TABLE IF EXISTS game_round_answers CASCADE;
DROP TABLE IF EXISTS game_questions CASCADE;
DROP TABLE IF EXISTS question_tags CASCADE;
DROP TABLE IF EXISTS tags CASCADE;
DROP TABLE IF EXISTS questions CASCADE;
DROP TABLE IF EXISTS game_round CASCADE;
DROP TABLE IF EXISTS game_scores CASCADE;
DROP TABLE IF EXISTS game_events CASCADE;
DROP TABLE IF EXISTS game_configurations CASCADE;
DROP TABLE IF EXISTS player_games CASCADE;
DROP TABLE IF EXISTS games CASCADE;
DROP TABLE IF EXISTS players CASCADE;
DROP TABLE IF EXISTS guests CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Remover tipos personalizados (enums)
DROP TYPE IF EXISTS game_status;
DROP TYPE IF EXISTS player_role;

-- Remover extensões (comentado por segurança)
-- DROP EXTENSION IF EXISTS "uuid-ossp";