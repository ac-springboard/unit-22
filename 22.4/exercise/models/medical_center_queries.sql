-- Note: I've create theses queries as a review of the main query statements and as a test for this database
--
-----------------------------
-- Connect to the database --
-----------------------------
--
\C medical_center
--
-------------------
-- Basic queries --
-------------------
--
SELECT *
  FROM patients;
--
--
SELECT *
  FROM doctors;
--
--
SELECT *
  FROM diseases;
--
--
SELECT *
  FROM visits_diseases;
--
--
SELECT *
  FROM visits;
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
--
-- List visits II --
--
SELECT *
  FROM visits v
       JOIN doctors d ON v.doctors_id = d.id
       JOIN patients p ON v.patients_id = p.id
;
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

--
-- List all patients and visits (or null if there's no visit)--
--
SELECT *
  FROM patients p
       LEFT JOIN visits v ON p.id = v.patients_id
;
--
-- List all patients that never visited the doctor I --
--
SELECT p.name
  FROM patients p
 WHERE p.id NOT IN (SELECT patients_id FROM visits);
--
-- List all patients that never visited the doctor II --
--
SELECT p.name
  FROM patients p
       LEFT JOIN visits v ON p.id = v.patients_id
 WHERE v.id IS NULL;
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
