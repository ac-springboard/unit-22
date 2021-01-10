-- write your queries here
-- 1 -- Join the two tables so that every column and record appears, regardless of if there is not an owner_id.
SELECT *
  FROM owners AS o
       FULL JOIN vehicles AS v ON v.owner_id = o.id;

-- 2 -- Count the number of cars for each owner. Display the owners first_name, last_name and count of vehicles.
--      The first_name should be ordered in ascending order.
SELECT o.first_name, o.last_name, COUNT(v.owner_id)
  FROM owners AS o
       FULL JOIN vehicles AS v ON v.owner_id = o.id
 GROUP BY v.owner_id, o.first_name, o.last_name, o.first_name
 ORDER BY o.first_name;

-- 3 -- Count the number of cars for each owner
--      and display the average price for each of the cars as integers.
--      Display the owners first_name, last_name, average price and count of vehicles.
--      The first_name should be ordered in descending order.
--      Only display results with more than one vehicle and an average price greater than 10000.
SELECT o.first_name, o.last_name, ROUND(AVG(v.price)), COUNT(v.id)
  FROM owners AS o
       JOIN vehicles AS v ON v.owner_id = o.id
 GROUP BY o.id, o.first_name, o.last_name
HAVING COUNT(v.id) > 1
   AND ROUND(AVG(v.price)) > 10000
 ORDER BY o.first_name DESC
;
