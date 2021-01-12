-- -----------------------------------------------------
-- DATABASE soccer_league
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS soccer_league CASCADE;
DROP DATABASE IF EXISTS soccer_league;
CREATE DATABASE soccer_league;

\c soccer_league;

-- -----------------------------------------------------
-- Table teams
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS teams
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL
)
;

-- -----------------------------------------------------
-- Table games
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS games
(
    id   SERIAL PRIMARY KEY,
    date date NOT NULL
)
;

-- -----------------------------------------------------
-- Table players
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS players
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(45) NULL,
    teams_id BIGINT      NOT NULL,
    CONSTRAINT fk_players_teams1
        FOREIGN KEY (teams_id)
            REFERENCES teams (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

-- -----------------------------------------------------
-- Table referees
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS referees
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL
)
;

-- -----------------------------------------------------
-- Table matches
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS matches
(
    id          SERIAL PRIMARY KEY,
    team1_id    BIGINT NOT NULL,
    team2_id    BIGINT NOT NULL,
    games_id    BIGINT NOT NULL,
    referees_id BIGINT NOT NULL,
    CONSTRAINT fk_teams_games_teams1
        FOREIGN KEY (team1_id)
            REFERENCES teams (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_teams_games_teams2
        FOREIGN KEY (team2_id)
            REFERENCES teams (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_teams_games_games1
        FOREIGN KEY (games_id)
            REFERENCES games (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_matches_referees1
        FOREIGN KEY (referees_id)
            REFERENCES referees (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

-- -----------------------------------------------------
-- Table goals
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS goals
(
    id         SERIAL PRIMARY KEY,
    number     INT    NULL,
    players_id BIGINT NOT NULL,
    matches_id BIGINT NOT NULL,
    CONSTRAINT fk_goals_players1
        FOREIGN KEY (players_id)
            REFERENCES players (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_goals_matches1
        FOREIGN KEY (matches_id)
            REFERENCES matches (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;
