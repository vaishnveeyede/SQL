-- Using Common Table Expressions (CTEs)
-- A CTE allows you to define a temporary result set that can be referenced within the main query. 
-- CTEs are especially useful for:
--   - Breaking down complex queries into smaller parts
--   - Recursive queries (e.g., hierarchical data)
--   - Reusing the same subquery multiple times in a single query

-- 1. Basic CTE example
WITH CTE_Example AS (
    SELECT 
        gender, 
        SUM(salary) AS total_salary,
        MIN(salary) AS min_salary,
        MAX(salary) AS max_salary,
        COUNT(salary) AS salary_count,
        AVG(salary) AS avg_salary
    FROM employee_demographics dem
    JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT *
FROM CTE_Example;

-- Note: A CTE must be immediately followed by a query that uses it.

-- 2. Using columns within a CTE for further calculations
WITH CTE_Example AS (
    SELECT 
        gender, 
        SUM(salary) AS total_salary, 
        COUNT(salary) AS salary_count
    FROM employee_demographics dem
    JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT 
    gender,
    ROUND(total_salary / salary_count, 2) AS recomputed_avg_salary
FROM CTE_Example;

-- 3. Multiple CTEs in one WITH expression
WITH CTE_Demographics AS (
    SELECT employee_id, gender, birth_date
    FROM employee_demographics
    WHERE birth_date > '1985-01-01'
),
CTE_Salaries AS (
    SELECT employee_id, salary
    FROM employee_salary
    WHERE salary >= 50000
)
SELECT d.employee_id, d.gender, s.salary
FROM CTE_Demographics d
LEFT JOIN CTE_Salaries s
    ON d.employee_id = s.employee_id;

-- 4. Renaming columns in a CTE for cleaner queries
WITH CTE_Stats (gender, total_salary, min_salary, max_salary, salary_count) AS (
    SELECT 
        gender, 
        SUM(salary), 
        MIN(salary), 
        MAX(salary), 
        COUNT(salary)
    FROM employee_demographics dem
    JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT 
    gender, 
    ROUND(total_salary / salary_count, 2) AS average_salary
FROM CTE_Stats
GROUP BY gender;

-- 5. Recursive CTE example: calculating factorial of numbers 1 to 5
WITH RECURSIVE Factorial_CTE AS (
    SELECT 1 AS n, 1 AS factorial
    UNION ALL
    SELECT n + 1, factorial * (n + 1)
    FROM Factorial_CTE
    WHERE n < 5
)
SELECT *
FROM Factorial_CTE;


-- 6. Filtering with CTEs to find employees with above-average salaries
WITH AvgSalary AS (
    SELECT AVG(salary) AS avg_salary
    FROM employee_salary
)
SELECT e.employee_id, e.first_name, e.last_name, s.salary
FROM employee_salary s
JOIN employee_demographics e
    ON e.employee_id = s.employee_id
JOIN AvgSalary a
    ON s.salary > a.avg_salary;

-- Notes:
-- - A CTE only exists for the duration of the statement that follows it.
-- - Use CTEs for better readability, especially when queries become deeply nested.
-- - For temporary storage across multiple queries, use Temporary Tables instead.
