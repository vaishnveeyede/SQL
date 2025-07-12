-- Use the Parks_and_Recreation database
USE `Parks_and_Recreation`;

-- View all records from employee demographics
SELECT * 
FROM employee_demographics;

-- View all records from employee salary
SELECT * 
FROM employee_salary;

-- 🔁 INNER JOIN: Returns only records that have matching values in both tables
SELECT *
FROM employee_demographics AS ed
INNER JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id;

-- Select specific columns using INNER JOIN
SELECT 
    ed.employee_id,
    ed.age,
    es.occupation
FROM employee_demographics AS ed
JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id;

-- LEFT JOIN: Returns all records from the left table, and matched records from the right table. 
-- If no match, NULLs will be shown for right table columns.
SELECT * 
FROM employee_demographics AS ed
LEFT JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id;

-- RIGHT JOIN: Returns all records from the right table, and matched records from the left table.
-- If no match, NULLs will be shown for left table columns.
SELECT * 
FROM employee_demographics AS ed
RIGHT JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id;

-- SELF JOIN: Join the same table to itself.
-- Here we join each employee to the next employee in the list by employee_id.
SELECT * 
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
    ON emp1.employee_id + 1 = emp2.employee_id;

-- SELF JOIN with selected columns and aliases for clarity
SELECT 
    emp1.employee_id AS emp_santa,
    emp1.first_name AS first_name_Santa,
    emp1.last_name AS last_name_Santa,
    emp2.employee_id AS emp_id,
    emp2.first_name AS first_name_emp,
    emp2.last_name AS last_name_emp
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
    ON emp1.employee_id + 1 = emp2.employee_id;

-- MULTI-TABLE JOIN: Joining three tables - employee_demographics, employee_salary, and parks_departments
-- This will return employee details along with their salary and department information.
SELECT *
FROM employee_demographics AS ed
INNER JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id
INNER JOIN parks_departments AS pd
    ON es.dept_id = pd.department_id;

-- View all records from the parks_departments table
SELECT * 
FROM parks_departments;

----  JOIN + WHERE clause: Filter employees with salary > 50,000
SELECT ed.first_name, ed.age, es.occupation, es.salary
FROM employee_demographics AS ed
JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id
WHERE es.salary > 50000;

---- JOIN + GROUP BY: Count employees in each department
SELECT pd.department_name, COUNT(*) AS employee_count
FROM employee_salary AS es
JOIN parks_departments AS pd
    ON es.dept_id = pd.department_id
GROUP BY pd.department_name;

---- NNER JOIN with filtering: Find employees with same first name but different IDs
SELECT emp1.first_name, emp1.employee_id AS id1, emp2.employee_id AS id2
FROM employee_demographics AS emp1
JOIN employee_demographics AS emp2
    ON emp1.first_name = emp2.first_name 
   AND emp1.employee_id != emp2.employee_id;

-- JOIN + BETWEEN clause: Find employees with mid-range salaries
SELECT ed.first_name, es.salary
FROM employee_demographics AS ed
JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id
WHERE es.salary BETWEEN 30000 AND 60000;