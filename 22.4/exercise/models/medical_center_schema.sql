------------------------------------------------
-- Schema medical_center
-- -----------------------------------------------------

-- Notes:
-- 1 -- For the sake of simplicity no extra (non-required on the exercise) column was added.
-- 2 -- Run this file from command line like: psql < medical_center_schema.sql
-- 3 -- To populate data, use the file medical_center_data.sql

\c postgres

DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center

-- -----------------------------------------------------
-- Table doctors
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS doctors
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL
);


-- -----------------------------------------------------
-- Table patients
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS patients
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL
);


-- -----------------------------------------------------
-- Table visits
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS visits
(
    id          SERIAL PRIMARY KEY,
    doctors_id  BIGINT NOT NULL,
    patients_id BIGINT NOT NULL,
    CONSTRAINT fk_visits_doctors
        FOREIGN KEY (doctors_id)
            REFERENCES doctors (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_visits_patients1
        FOREIGN KEY (patients_id)
            REFERENCES patients (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table diseases
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS diseases
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(45) NULL
);


-- -----------------------------------------------------
-- Table visits_diseases
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS visits_diseases
(
    id          SERIAL PRIMARY KEY,
    diseases_id BIGINT NOT NULL,
    visits_id   BIGINT NOT NULL,
    CONSTRAINT fk_visits_diseases_diseases1
        FOREIGN KEY (diseases_id)
            REFERENCES diseases (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_visits_diseases_visits1
        FOREIGN KEY (visits_id)
            REFERENCES visits (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
);

\c postgres
