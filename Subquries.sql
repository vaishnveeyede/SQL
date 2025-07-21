-- SUBQUERIES IN SQL
-- A subquery is a query within another query.
-- It can be used in SELECT, FROM, or WHERE clauses.

-- 1. VIEW ALL EMPLOYEES
SELECT *
FROM employee_demographics;

-- 2. SUBQUERY IN WHERE CLAUSE
-- Find employees who work in the Parks and Recreation Department (dept_id = 1)
-- Using a subquery to filter employee_id from employee_salary table
SELECT *
FROM employee_demographics
WHERE employee_id IN (
    SELECT employee_id
    FROM employee_salary
    WHERE dept_id = 1
);

-- NOTE: A subquery must return only one column when used in an IN() clause.
-- The following will cause an error:
-- SELECT employee_id, salary FROM employee_salary WHERE dept_id = 1;

-- 3. SUBQUERY IN SELECT CLAUSE
-- Compare each employee's salary with the overall average salary.
SELECT 
    first_name, 
    salary,
    (SELECT AVG(salary) FROM employee_salary) AS average_salary
FROM employee_salary;

-- Here, the subquery runs once and returns a single value (average salary),
-- which is compared against each row in the outer query.

-- 4. SUBQUERY IN FROM CLAUSE
-- Create a temporary table with aggregated employee age statistics by gender.
SELECT *
FROM (
    SELECT 
        gender, 
        MIN(age) AS Min_age, 
        MAX(age) AS Max_age, 
        COUNT(age) AS Count_age,
        AVG(age) AS Avg_age
    FROM employee_demographics
    GROUP BY gender
) AS Agg_Table;

-- Now we can query this "virtual table":
SELECT 
    gender, 
    AVG(Min_age) AS avg_min_age
FROM (
    SELECT 
        gender, 
        MIN(age) AS Min_age, 
        MAX(age) AS Max_age, 
        COUNT(age) AS Count_age,
        AVG(age) AS Avg_age
    FROM employee_demographics
    GROUP BY gender
) AS Agg_Table
GROUP BY gender;

-- 5. SUBQUERY WITH COMPARISON OPERATOR
-- Find employees whose salary is greater than the average salary.
SELECT 
    first_name, 
    salary
FROM employee_salary
WHERE salary > (
    SELECT AVG(salary)
    FROM employee_salary
);

-- 6. CORRELATED SUBQUERY
-- Find employees whose salary is greater than the average salary 
-- in their own department.
SELECT 
    e.first_name,
    e.salary,
    e.dept_id
FROM employee_salary e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employee_salary
    WHERE dept_id = e.dept_id
);

-- 7. SUBQUERY WITH EXISTS
-- Check if there are employees in a specific department (e.g., dept_id = 2).
SELECT *
FROM employee_demographics d
WHERE EXISTS (
    SELECT 1
    FROM employee_salary s
    WHERE s.employee_id = d.employee_id
      AND s.dept_id = 2
);

-- 8. NESTED SUBQUERY
-- Find employees earning the highest salary.
SELECT *
FROM employee_salary
WHERE salary = (
    SELECT MAX(salary)
    FROM employee_salary
);

-- 9. USING SUBQUERY IN ORDER BY
-- Order employees by how close their salary is to the overall average.
SELECT 
    first_name,
    salary
FROM employee_salary
ORDER BY ABS(salary - (SELECT AVG(salary) FROM employee_salary));
