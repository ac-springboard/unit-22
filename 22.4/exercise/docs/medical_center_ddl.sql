------------------------------------------------
-- Schema medical_center
-- -----------------------------------------------------

DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\C medical_center
-- -----------------------------------------------------
-- Table doctors
-- -----------------------------------------------------
DROP TABLE IF EXISTS doctors;

CREATE TABLE IF NOT EXISTS doctors
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
);


-- -----------------------------------------------------
-- Table patients
-- -----------------------------------------------------
DROP TABLE IF EXISTS patients;

CREATE TABLE IF NOT EXISTS patients
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
);


-- -----------------------------------------------------
-- Table visits
-- -----------------------------------------------------
DROP TABLE IF EXISTS visits;

CREATE TABLE IF NOT EXISTS visits
(
    id SERIAL PRIMARY KEY,
    doctors_id  BIGINT   NOT NULL,
    patients_id BIGINT   NOT NULL,
    date        DATE NULL,
    PRIMARY KEY (id, doctors_id, patients_id),
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
DROP TABLE IF EXISTS diseases;

CREATE TABLE IF NOT EXISTS diseases
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(45) NULL,
    PRIMARY KEY (id)
);


-- -----------------------------------------------------
-- Table visit_diseases
-- -----------------------------------------------------
DROP TABLE IF EXISTS visit_diseases;

CREATE TABLE IF NOT EXISTS visit_diseases
(
    id SERIAL PRIMARY KEY,
    diseases_id BIGINT NOT NULL,
    visits_id   BIGINT NOT NULL,
    PRIMARY KEY (id, diseases_id, visits_id),
    CONSTRAINT fk_visit_diseases_diseases1
        FOREIGN KEY (diseases_id)
            REFERENCES diseases (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_visit_diseases_visits1
        FOREIGN KEY (visits_id)
            REFERENCES visits (id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
);
