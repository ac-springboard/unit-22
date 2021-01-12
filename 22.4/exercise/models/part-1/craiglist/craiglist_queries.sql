\c craiglist

SELECT *
  FROM categories;
SELECT *
  FROM regions;
SELECT *
  FROM locations;
SELECT *
  FROM users;
SELECT *
  FROM posts;

UPDATE categories
   SET name='cat 1'
 WHERE id = 1;

SELECT *
  FROM posts p
       JOIN locations l ON l.id = p.locations_id
       JOIN regions r ON r.id = l.regions_id
       JOIN categories c ON c.id = p.categories_id
       JOIN users u ON u.id = p.users_id
;

SELECT p.title, p.text, l.name, c.name, u.name
  FROM posts p
       JOIN locations l ON l.id = p.locations_id
       JOIN regions r ON r.id = l.regions_id
       JOIN categories c ON c.id = p.categories_id
       JOIN users u ON u.id = p.users_id
;

SELECT r.name, COUNT(p.id)
  FROM regions r
       JOIN locations l ON l.regions_id = r.id
       JOIN posts p ON p.locations_id = l.id
       JOIN categories c ON c.id = p.categories_id
       JOIN users u ON u.id = p.users_id
 GROUP BY r.name
 ORDER BY r.name
;
