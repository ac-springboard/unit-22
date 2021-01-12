\C medical_center

INSERT INTO patients (name)
VALUES ('jaja'),
       ('jojo'),
       ('juju');

INSERT INTO doctors (name)
VALUES ('Fester Bestertester'),
       ('Maximus Minimus');

INSERT INTO diseases (name)
VALUES ('Broken Heart'),
       ('Chronic Sillyness'),
       ('Verbal Diarrhea'),
       ('Chronic Trumpism');

INSERT INTO visits (doctors_id, patients_id)
VALUES (1, 2),
       (1, 3),
       (2, 3);

INSERT INTO visits_diseases (visits_id, diseases_id)
VALUES (1, 1),
       (3, 3);
