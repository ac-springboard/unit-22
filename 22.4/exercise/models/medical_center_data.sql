\c medical_center

insert into patients        (name)
                            values ('jaja'), ('jojo'), ('juju');

insert into doctors         (name)
                            values ('Fester Bestertester'), ('Maximus Minimus');

insert into diseases        (name)
                            values ('Broken Heart'), ('Chronic Sillyness'), ('Verbal Diarrhea'), ('Chronic Trumpism');

insert into visits          (doctors_id, patients_id)
                            values ( 1, 2), (1, 3), (2, 3);

insert into visits_diseases  (visits_id, diseases_id)
                            values ( 1, 1), (3, 3);
