-- LIMIT restricts the number of rows returned by a query. Useful for previewing data or pagination.
USE `Parks_and_Recreation`;
SELECT * FROM parks_and_recreation.employee_demographics;

-- Select first 3 rows from the table
SELECT *
FROM employee_demographics
LIMIT 3;

-- Select first 3 rows after sorting by first name alphabetically
SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3;

-- View the entire table ordered by first name for reference
SELECT *
FROM employee_demographics
ORDER BY first_name;

-- Skip first 3 rows and return next 2 rows (pagination-style)
SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3, 2;

-- Find the third oldest person
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1;

-- Starts at index 2 (3rd person), returns 1 row

------ Aliasing is used to rename columns or tables (for readability or formatting).
-- Rename MUltiple columns

SELECT 
  first_name AS FirstName,
  last_name AS LastName,
  age AS AgeYears,
  gender AS GenderType
FROM employee_demographics;

SELECT 
  occupation AS JobTitle,
  MAX(salary) AS MaxSalary
FROM employee_salary
GROUP BY occupation
ORDER BY MaxSalary DESC
LIMIT 3;
-- Top 3 highest-paying job titles