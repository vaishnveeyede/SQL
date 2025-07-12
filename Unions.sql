--- UNION combines results from two or more SELECT queries into a single result set.
--- It removes duplicate rows by default.
--- The number and data types of columns must match in each SELECT.

-- Combine first_name and last_name from both tables without duplicates

SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT  -- DISTINCT is optional, because UNION removes duplicates by default
SELECT first_name, last_name
FROM employee_salary;

-- Combine first_name and last_name from both tables, including duplicates

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;

-- Tagging records with custom labels and combining into a unified set

SELECT first_name, last_name, 'old man' AS label
FROM employee_demographics
WHERE age > 40 AND gender = 'male'
UNION
SELECT first_name, last_name, 'old lady' AS label
FROM employee_demographics
WHERE age > 40 AND gender = 'female'
UNION
SELECT first_name, last_name, 'High paid employee' AS label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name;

-- Add a source column to identify where each row came from

SELECT first_name, last_name, 'Demographics' AS source
FROM employee_demographics
UNION ALL
SELECT first_name, last_name, 'Salary' AS source
FROM employee_salary;

-- Union of employees not found in both tables (using LEFT JOIN + NULL filter)

-- Employees in demographics but not in salary
SELECT ed.first_name, ed.last_name, 'Only in Demographics' AS status
FROM employee_demographics ed
LEFT JOIN employee_salary es ON ed.employee_id = es.employee_id
WHERE es.employee_id IS NULL

UNION

-- Employees in salary but not in demographics
SELECT es.first_name, es.last_name, 'Only in Salary' AS status
FROM employee_salary es
LEFT JOIN employee_demographics ed ON es.employee_id = ed.employee_id
WHERE ed.employee_id IS NULL;




