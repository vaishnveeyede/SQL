-- Select all columns from the employee_demographics table
SELECT * FROM parks_and_recreation.employee_demographics;

-- Select only the first_name column from the employee_demographics table
SELECT first_name 
FROM parks_and_recreation.employee_demographics;

-- Select first_name, gender, age and add 20 to age (as a calculated column)
SELECT first_name, 
       gender,
       age,
       age + 20 AS age_in_future
FROM parks_and_recreation.employee_demographics;

-- Select all distinct gender values
SELECT DISTINCT gender 
FROM parks_and_recreation.employee_demographics;

-- Select all distinct age values
SELECT DISTINCT age
FROM parks_and_recreation.employee_demographics;

-- Select all columns from the employee_salary table
SELECT * FROM parks_and_recreation.employee_salary;

-- Select all distinct occupations
SELECT DISTINCT occupation 
FROM parks_and_recreation.employee_salary;

-- -------------------- WHERE Clause Examples --------------------

-- Select employee record where first name is 'Leslie'
SELECT * FROM employee_salary
WHERE first_name = 'Leslie';

-- Select all employees with salary greater than or equal to 50000
SELECT * FROM employee_salary
WHERE salary >= 50000;

-- Select all employees with salary less than or equal to 50000
SELECT * FROM employee_salary
WHERE salary <= 50000;

-- Select employee with first name 'April' and last name 'Ludgate'
SELECT * FROM employee_demographics
WHERE first_name = 'April' AND last_name = 'Ludgate';

-- Select employees who are not assigned to any department (dept_id is NULL)
SELECT * FROM employee_salary
WHERE dept_id IS NULL;

-- Select employees whose salary is between 50000 and 70000 (inclusive)
SELECT * FROM employee_salary
WHERE salary BETWEEN 50000 AND 70000;

-- Select first names of all female employees
SELECT first_name 
FROM parks_and_recreation.employee_demographics
WHERE gender = 'Female';

-- Select employees born after January 1, 1985
SELECT * FROM employee_demographics
WHERE birth_date > '1985-01-01';

-- -------------------- Logical Operators: AND, OR, NOT --------------------

-- Select male employees born after January 1, 1985
SELECT * FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male';

-- Select employees named 'Leslie' aged 44 OR any employee older than 55
SELECT * FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;

-- Select employees whose salary is NOT equal to 70000
SELECT * FROM employee_salary
WHERE salary <> 70000;

-- Select employees born in the month of March
SELECT * FROM employee_demographics
WHERE MONTH(birth_date) = 3;

-- Select employees aged exactly 35 or 36
SELECT * FROM employee_demographics
WHERE age IN (35, 36);


-- Select employees whose first name starts with 'A'
SELECT * FROM employee_demographics
WHERE first_name LIKE 'A%';

-- First names starting with 'A'
SELECT * FROM employee_demographics
WHERE first_name LIKE 'j%';

-- First names ending with 'e'
SELECT * FROM employee_demographics
WHERE first_name LIKE '%e';

-- First names containing 'nn'
SELECT * FROM employee_demographics
WHERE first_name LIKE '%nn%';

-- Last names containing 'ger'
SELECT * FROM employee_demographics
WHERE last_name LIKE '%ger%';

-- Occupation starts with 'Director'
SELECT * FROM employee_salary
WHERE occupation LIKE 'Director%';

-- Occupation contains 'Manager'
SELECT * FROM employee_salary
WHERE occupation LIKE '%Manager%';

-- Case-insensitive search for names containing 'ann'
SELECT * FROM employee_demographics
WHERE LOWER(first_name) LIKE '%ann%';

-- Advanced Wildcard Examples

-- First names where second letter is 'o'
SELECT * FROM employee_demographics
WHERE first_name LIKE '_o%';

-- Last names that are exactly 5 characters long
SELECT * FROM employee_demographics
WHERE last_name LIKE '_____';





