-- Note: I've create theses queries as a review of the main query statements and as a test for this database
--
-----------------------------
-- Connect to the database --
-----------------------------
--
\C medical_center
Title is "medical_center".
--
-------------------
-- Basic queries --
-------------------
--
SELECT *
  FROM patients;
medical_center
 id | name 
----+------
  1 | jaja
  2 | jojo
  3 | juju
(3 rows)

--
--
SELECT *
  FROM doctors;
      medical_center
 id |        name         
----+---------------------
  1 | Fester Bestertester
  2 | Maximus Minimus
(2 rows)

--
--
SELECT *
  FROM diseases;
     medical_center
 id |       name        
----+-------------------
  1 | Broken Heart
  2 | Chronic Sillyness
  3 | Verbal Diarrhea
  4 | Chronic Trumpism
(4 rows)

--
--
SELECT *
  FROM visits_diseases;
        medical_center
 id | diseases_id | visits_id 
----+-------------+-----------
  1 |           1 |         1
  2 |           3 |         3
(2 rows)

--
--
SELECT *
  FROM visits;
        medical_center
 id | doctors_id | patients_id 
----+------------+-------------
  1 |          1 |           2
  2 |          1 |           3
  3 |          2 |           3
(3 rows)

--
----------------------------------
-- Queries with JOIN and others --
----------------------------------
--
--
-- List visits I --
--
SELECT *
  FROM doctors d
       JOIN visits v ON v.doctors_id = d.id
       JOIN patients p ON v.patients_id = p.id
;
                            medical_center
 id |        name         | id | doctors_id | patients_id | id | name 
----+---------------------+----+------------+-------------+----+------
  1 | Fester Bestertester |  1 |          1 |           2 |  2 | jojo
  1 | Fester Bestertester |  2 |          1 |           3 |  3 | juju
  2 | Maximus Minimus     |  3 |          2 |           3 |  3 | juju
(3 rows)

--
-- List visits II --
--
SELECT *
  FROM visits v
       JOIN doctors d ON v.doctors_id = d.id
       JOIN patients p ON v.patients_id = p.id
;
                            medical_center
 id | doctors_id | patients_id | id |        name         | id | name 
----+------------+-------------+----+---------------------+----+------
  1 |          1 |           2 |  1 | Fester Bestertester |  2 | jojo
  2 |          1 |           3 |  1 | Fester Bestertester |  3 | juju
  3 |          2 |           3 |  2 | Maximus Minimus     |  3 | juju
(3 rows)

--
-- List number of patients by doctor --
--
SELECT d.name, COUNT(p.name)
  FROM doctors d
       JOIN visits v ON v.doctors_id = d.id
       JOIN patients p ON v.patients_id = p.id
 GROUP BY d.name
 ORDER BY d.name
;
       medical_center
        name         | count 
---------------------+-------
 Fester Bestertester |     2
 Maximus Minimus     |     1
(2 rows)

--
-- List visits where diseases where diagnosed --
--
SELECT *
  FROM doctors d
       JOIN visits v ON v.doctors_id = d.id
       JOIN patients p ON v.patients_id = p.id
       JOIN visits_diseases vd ON vd.visits_id = v.id
       JOIN diseases ds ON ds.id = vd.diseases_id
;
                                                       medical_center
 id |        name         | id | doctors_id | patients_id | id | name | id | diseases_id | visits_id | id |      name       
----+---------------------+----+------------+-------------+----+------+----+-------------+-----------+----+-----------------
  1 | Fester Bestertester |  1 |          1 |           2 |  2 | jojo |  1 |           1 |         1 |  1 | Broken Heart
  2 | Maximus Minimus     |  3 |          2 |           3 |  3 | juju |  2 |           3 |         3 |  3 | Verbal Diarrhea
(2 rows)

--
-- List doctor's name, patient's name visit id, and disease name on visits where diseases were diagnosed --
--
SELECT d.name AS "Doctor", p.name AS "Patient", v.id AS "Visit ID", ds.name AS "Disease"
  FROM doctors d
       JOIN visits v ON v.doctors_id = d.id
       JOIN patients p ON v.patients_id = p.id
       JOIN visits_diseases vd ON vd.visits_id = v.id
       JOIN diseases ds ON ds.id = vd.diseases_id
;
                       medical_center
       Doctor        | Patient | Visit ID |     Disease     
---------------------+---------+----------+-----------------
 Fester Bestertester | jojo    |        1 | Broken Heart
 Maximus Minimus     | juju    |        3 | Verbal Diarrhea
(2 rows)

--
-- List all data --
--
SELECT d.name AS "Doctor", p.name AS "Patient", v.id AS "Visit ID", ds.name AS "Disease"
  FROM doctors d
       FULL JOIN visits v ON v.doctors_id = d.id
       FULL JOIN patients p ON v.patients_id = p.id
       FULL JOIN visits_diseases vd ON vd.visits_id = v.id
       FULL JOIN diseases ds ON ds.id = vd.diseases_id
;
                        medical_center
       Doctor        | Patient | Visit ID |      Disease      
---------------------+---------+----------+-------------------
 Fester Bestertester | jojo    |        1 | Broken Heart
 Maximus Minimus     | juju    |        3 | Verbal Diarrhea
                     | jaja    |          | 
 Fester Bestertester | juju    |        2 | 
                     |         |          | Chronic Sillyness
                     |         |          | Chronic Trumpism
(6 rows)

--
-- List all patients and visits (or null if there's no visit)--
--
SELECT *
  FROM patients p
       LEFT JOIN visits v ON p.id = v.patients_id
;
              medical_center
 id | name | id | doctors_id | patients_id 
----+------+----+------------+-------------
  2 | jojo |  1 |          1 |           2
  3 | juju |  2 |          1 |           3
  3 | juju |  3 |          2 |           3
  1 | jaja |    |            |            
(4 rows)

--
-- List all patients that never visited the doctor I --
--
SELECT p.name
  FROM patients p
 WHERE p.id NOT IN (SELECT patients_id FROM visits);
medical_center
 name 
------
 jaja
(1 row)

--
-- List all patients that never visited the doctor II --
--
SELECT p.name
  FROM patients p
       LEFT JOIN visits v ON p.id = v.patients_id
 WHERE v.id IS NULL;
medical_center
 name 
------
 jaja
(1 row)

;
--
-- List visit id, doctor's name, patient's name, diseases' name (or "-" if no disease)
-- of all patients that had visited the medical center.
--
SELECT v.id   AS "Visit ID",
       d.name AS "Doctor",
       p.name AS "Patient",
       CASE
           WHEN ds.name IS NULL
               THEN '-'
           ELSE ds.name
           END   "Diseases"
  FROM visits v
       JOIN doctors d ON d.id = v.doctors_id
       JOIN patients p ON p.id = v.patients_id
       LEFT JOIN visits_diseases vd ON vd.visits_id = v.id
       LEFT JOIN diseases ds ON ds.id = vd.diseases_id
 ORDER BY d.name
;
                       medical_center
 Visit ID |       Doctor        | Patient |    Diseases     
----------+---------------------+---------+-----------------
        1 | Fester Bestertester | jojo    | Broken Heart
        2 | Fester Bestertester | juju    | -
        3 | Maximus Minimus     | juju    | Verbal Diarrhea
(3 rows)

