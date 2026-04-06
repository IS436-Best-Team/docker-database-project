-- =============================================================
-- 02_insert_data.sql
-- Player Management System
-- Sample data to populate all tables for testing
-- =============================================================

USE player_management;

-- -------------------------------------------------------------
-- League
-- -------------------------------------------------------------
INSERT INTO League (league_name, season, age_division, game_length_minutes, period_count, substitution_interval_minutes, minimum_playtime_minutes, foul_disqualification_limit, max_players_on_court) VALUES
('City Rec Basketball League', 'Spring 2025', 'U14',   48, 4, 6, 10, 5, 5),
('Downtown Youth Hoops',       'Spring 2025', 'U12',   40, 4, 5,  8, 5, 5),
('Metro Adult League',         'Spring 2025', 'Adult', 48, 4, 8, 12, 6, 5);

-- -------------------------------------------------------------
-- Team
-- -------------------------------------------------------------
INSERT INTO Team (league_id, team_name, is_active) VALUES
(1, 'Blue Thunder',   TRUE),
(1, 'Red Rockets',    TRUE),
(2, 'Green Machines', TRUE),
(3, 'Silver Wolves',  TRUE);

-- -------------------------------------------------------------
-- CoachUser
-- -------------------------------------------------------------
INSERT INTO CoachUser (first_name, last_name, email, password_hash, role, is_active) VALUES
('Marcus', 'Johnson',  'marcus@playermgmt.com',  '$2b$12$abc123hashedpassword1', 'head_coach',  TRUE),
('Diana',  'Torres',   'diana@playermgmt.com',   '$2b$12$abc123hashedpassword2', 'head_coach',  TRUE),
('Kevin',  'Patel',    'kevin@playermgmt.com',   '$2b$12$abc123hashedpassword3', 'assistant',   TRUE),
('Sandra', 'Williams', 'sandra@playermgmt.com',  '$2b$12$abc123hashedpassword4', 'head_coach',  TRUE);

-- -------------------------------------------------------------
-- TeamCoach
-- -------------------------------------------------------------
INSERT INTO TeamCoach (team_id, user_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4);

-- -------------------------------------------------------------
-- Player
-- -------------------------------------------------------------
INSERT INTO Player (team_id, jersey_number, default_status, is_active) VALUES
-- Blue Thunder (team 1)
(1,  3, 'eligible', TRUE),
(1,  7, 'eligible', TRUE),
(1, 10, 'eligible', TRUE),
(1, 12, 'eligible', TRUE),
(1, 15, 'eligible', TRUE),
(1, 21, 'eligible', TRUE),
(1, 24, 'eligible', TRUE),
-- Red Rockets (team 2)
(2,  4, 'eligible', TRUE),
(2,  8, 'eligible', TRUE),
(2, 11, 'eligible', TRUE),
(2, 14, 'eligible', TRUE),
(2, 22, 'eligible', TRUE);

-- -------------------------------------------------------------
-- Game
-- -------------------------------------------------------------
INSERT INTO Game (league_id, team_id, created_by, opponent_name, game_date, location, status) VALUES
(1, 1, 1, 'Red Rockets',    '2025-03-10', 'Main Gym - Court 1',  'completed'),
(1, 1, 1, 'Green Machines', '2025-03-17', 'Main Gym - Court 2',  'completed'),
(1, 2, 2, 'Blue Thunder',   '2025-03-10', 'Main Gym - Court 1',  'completed'),
(1, 1, 1, 'Silver Wolves',  '2025-03-24', 'Downtown Rec Center', 'scheduled');

-- -------------------------------------------------------------
-- GameRoster
-- -------------------------------------------------------------
INSERT INTO GameRoster (game_id, player_id, initial_status, is_present) VALUES
(1, 1, 'eligible', TRUE),
(1, 2, 'eligible', TRUE),
(1, 3, 'eligible', TRUE),
(1, 4, 'eligible', TRUE),
(1, 5, 'eligible', TRUE),
(1, 6, 'eligible', TRUE),
(1, 7, 'eligible', TRUE);

-- -------------------------------------------------------------
-- PlayerGameStatus
-- -------------------------------------------------------------
INSERT INTO PlayerGameStatus (game_id, player_id, current_status, status_color, minutes_played, foul_count, is_disqualified, is_unavailable) VALUES
(1, 1, 'benched',      'yellow', 18, 2, FALSE, FALSE),
(1, 2, 'eligible',     'green',  32, 1, FALSE, FALSE),
(1, 3, 'eligible',     'green',  30, 0, FALSE, FALSE),
(1, 4, 'disqualified', 'red',    22, 5, TRUE,  FALSE),
(1, 5, 'eligible',     'green',  28, 3, FALSE, FALSE),
(1, 6, 'injured',      'gray',   14, 0, FALSE, TRUE),
(1, 7, 'eligible',     'green',  35, 1, FALSE, FALSE);

-- -------------------------------------------------------------
-- Substitution
-- -------------------------------------------------------------
INSERT INTO Substitution (game_id, player_in_id, player_out_id, substitution_time, recorded_by) VALUES
(1, 6, 1, '2025-03-10 19:12:00', 1),
(1, 1, 3, '2025-03-10 19:24:00', 1),
(1, 3, 5, '2025-03-10 19:36:00', 3);

-- -------------------------------------------------------------
-- Foul
-- -------------------------------------------------------------
INSERT INTO Foul (game_id, player_id, foul_number, foul_time, recorded_by) VALUES
(1, 4, 1, '2025-03-10 19:08:00', 1),
(1, 4, 2, '2025-03-10 19:15:00', 1),
(1, 1, 1, '2025-03-10 19:18:00', 1),
(1, 4, 3, '2025-03-10 19:22:00', 3),
(1, 5, 1, '2025-03-10 19:27:00', 3),
(1, 4, 4, '2025-03-10 19:31:00', 1),
(1, 4, 5, '2025-03-10 19:40:00', 1),
(1, 1, 2, '2025-03-10 19:44:00', 1);

-- -------------------------------------------------------------
-- Injury
-- -------------------------------------------------------------
INSERT INTO Injury (game_id, player_id, injury_time, notes, recorded_by) VALUES
(1, 6, '2025-03-10 19:10:00', 'Twisted ankle on drive to the basket, removed from game.', 1);

-- -------------------------------------------------------------
-- AIQuery
-- -------------------------------------------------------------
INSERT INTO AIQuery (user_id, team_id, game_id, query_text, query_type, response_text, created_at) VALUES
(1, 1, 1, 'Which players are at risk of fouling out?',   'foul_risk',      'Players #12 (4 fouls) and #3 (2 fouls) are approaching the limit.',        '2025-03-10 19:35:00'),
(1, 1, 1, 'Who has the least playtime this game?',       'playtime_check', 'Player #21 has only 14 minutes. Consider rotating them in next period.',    '2025-03-10 19:40:00'),
(2, 2, 3, 'Suggest a substitution to balance playtime.', 'substitution',   'Swap player #8 in for #22 — #22 has exceeded minimum playtime threshold.', '2025-03-10 19:50:00');

-- -------------------------------------------------------------
-- Report
-- -------------------------------------------------------------
INSERT INTO Report (generated_by, team_id, game_id, report_type, report_data, created_at) VALUES
(1, 1, 1,    'game_summary',   '{"score": "42-38", "fouls": 8, "substitutions": 3, "injuries": 1}',    '2025-03-10 21:00:00'),
(1, 1, NULL, 'season_summary', '{"games_played": 2, "avg_fouls_per_game": 4.5, "total_injuries": 1}',  '2025-03-18 09:00:00');
