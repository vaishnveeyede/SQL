-- WINDOW FUNCTIONS IN SQL
-- Window functions are similar to GROUP BY but they do not roll results into a single row.
-- They allow calculations over partitions (groups) of data while retaining individual rows.
-- We’ll explore AVG, SUM, ROW_NUMBER, RANK, and DENSE_RANK.

-- View all employees
SELECT * 
FROM employee_demographics;

-- 1. GROUP BY example: average salary by gender
SELECT gender, ROUND(AVG(salary), 1) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
GROUP BY gender;

-- 2. Window function: average salary across all employees (no partition)
SELECT 
    dem.employee_id, 
    dem.first_name, 
    gender, 
    salary,
    AVG(salary) OVER() AS avg_salary_overall
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- 3. Partition by gender: average salary within each gender group
SELECT 
    dem.employee_id, 
    dem.first_name, 
    gender, 
    salary,
    AVG(salary) OVER(PARTITION BY gender) AS avg_salary_by_gender
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- 4. Rolling sum by gender, ordered by employee_id
SELECT 
    dem.employee_id, 
    dem.first_name, 
    gender, 
    salary,
    SUM(salary) OVER(PARTITION BY gender ORDER BY employee_id) AS rolling_salary_total
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- 5. ROW_NUMBER: unique row number within each gender group
SELECT 
    dem.employee_id, 
    dem.first_name, 
    gender, 
    salary,
    ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- 6. Compare ROW_NUMBER vs. RANK
SELECT 
    dem.employee_id, 
    dem.first_name, 
    gender, 
    salary,
    ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
    RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_1
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- RANK() allows for ties: if two employees share the same salary, they get the same rank, 
-- and the next rank number is skipped.
