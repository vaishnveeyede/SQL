-- GROUP BY is used to group rows based on one or more columns and is often paired with aggregate functions (AVG(), MIN(), MAX(), COUNT(), SUM()).

SELECT * 
FROM employee_demographics;

-- Group by gender only (will give one row per gender)
SELECT gender 
FROM employee_demographics
GROUP BY gender;

-- Invalid: first_name not in GROUP BY or aggregate function
-- This may work in MySQL but not recommended. Should fix by including proper aggregation or grouping
SELECT gender, COUNT(first_name) AS count
FROM employee_demographics
GROUP BY gender;

-- Group occupations to see distinct ones
SELECT occupation 
FROM employee_salary
GROUP BY occupation;

-- Group by both occupation and salary (each unique pair will appear as one row)
SELECT occupation, salary 
FROM employee_salary
GROUP BY occupation, salary;

-- Aggregate: Average age grouped by gender
SELECT gender, AVG(age) AS avg_age 
FROM employee_demographics
GROUP BY gender;

-- Full aggregation: Min, Max, Count, Avg age grouped by gender
SELECT gender, 
       MIN(age) AS min_age, 
       MAX(age) AS max_age, 
       COUNT(age) AS total_employees, 
       AVG(age) AS average_age
FROM employee_demographics
GROUP BY gender;

-- ORDER BY is used to sort result sets. Default is ASC (ascending). Use DESC for descending order.
-- Order all employees alphabetically by first name
SELECT * 
FROM employee_demographics
ORDER BY first_name;

-- Order all employees by first name in descending order (Z → A)
SELECT * 
FROM employee_demographics
ORDER BY first_name DESC;

-- Order by gender first (A-Z), then by age (youngest to oldest) within each gender
SELECT * 
FROM employee_demographics
ORDER BY gender, age;

-- Order by gender and age both in descending order
SELECT * 
FROM employee_demographics
ORDER BY gender DESC, age DESC;

-- Column position usage: ORDER BY 5, 4 means order by the 5th and 4th columns
-- Not recommended: Use column names instead of positions for clarity and reliability
SELECT * 
FROM employee_demographics
ORDER BY 5 DESC, 4 DESC;

