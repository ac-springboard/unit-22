-- Notes:
-- 1 -- For the sake of simplicity no extra (non-required on the exercise) column was added.
-- 2 -- Run this file from command line like: psql < craiglist_schema.sql
-- 3 -- To populate data, use the file craiglig_data.sql

-- -----------------------------------------------------
-- Schema craiglist
-- -----------------------------------------------------
\c acampos

DROP SCHEMA IF EXISTS craiglist CASCADE;
DROP DATABASE IF EXISTS craiglist;

-- -----------------------------------------------------
-- Schema craiglist
-- -----------------------------------------------------
CREATE DATABASE craiglist;

\c craiglist

-- -----------------------------------------------------
-- Table regions
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS regions
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL
)
;

-- -----------------------------------------------------
-- Table locations
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS locations
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(45) NOT NULL,
    regions_id bigint      NOT NULL,
    CONSTRAINT fk_locations_regions1
        FOREIGN KEY (regions_id)
            REFERENCES regions (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;

-- -----------------------------------------------------
-- Table categories
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS categories
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL
)
;

-- -----------------------------------------------------
-- Table users
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS users
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL
)
;

-- -----------------------------------------------------
-- Table posts
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS posts
(
    id            SERIAL PRIMARY KEY,
    title         VARCHAR(45) NOT NULL,
    text          TEXT        NULL,
    locations_id  BIGINT      NOT NULL,
    categories_id BIGINT      NOT NULL,
    users_id      BIGINT      NOT NULL,
    CONSTRAINT fk_posts_locations
        FOREIGN KEY (locations_id)
            REFERENCES locations (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_posts_categories1
        FOREIGN KEY (categories_id)
            REFERENCES categories (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_posts_users1
        FOREIGN KEY (users_id)
            REFERENCES users (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
;
