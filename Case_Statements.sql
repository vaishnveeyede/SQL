
-- CASE STATEMENTS IN SQL
-- A CASE statement adds conditional logic to queries,
-- similar to IF...ELSE in programming languages or Excel.


-- 1. VIEW ALL EMPLOYEES
USE `Parks_and_Recreation`;
SELECT * 
FROM employee_demographics;

-- 2. CLASSIFY EMPLOYEES BY AGE GROUP
--    - Young: <= 30
--    - Middle-aged: 31-50
--    - Senior: > 50

SELECT 
    first_name, 
    last_name, 
    age,
    CASE
        WHEN age <= 30 THEN 'Young'
        WHEN age BETWEEN 31 AND 50 THEN 'Middle-aged'
        ELSE 'Senior'
    END AS age_category
FROM employee_demographics;


-- 3. CLASSIFY EMPLOYEES WITH CUSTOM LABELS
--    (A playful version with humorous naming)

SELECT 
    first_name, 
    last_name, 
    age,
    CASE
        WHEN age <= 30 THEN 'Young'
        WHEN age BETWEEN 31 AND 50 THEN 'Old'
        WHEN age > 50 THEN 'On Death''s Door'
    END AS age_label
FROM employee_demographics;


-- 4. VIEW EMPLOYEE SALARIES
SELECT * 
FROM employee_salary;

-- 5. CALCULATE NEW SALARY BASED ON RAISE POLICY
--    - Salary < 45,000: 7% raise
--    - Salary >= 45,000: 5% raise

SELECT 
    first_name, 
    last_name, 
    salary,
    CASE
        WHEN salary >= 45000 THEN salary + (salary * 0.05)
        WHEN salary < 45000 THEN salary + (salary * 0.07)
    END AS new_salary
FROM employee_salary;


-- 6. ADD BONUS CALCULATION
--    - 10% bonus for Finance Department (dept_id = 6)
SELECT 
    first_name, 
    last_name, 
    salary,
    CASE
        WHEN salary >= 45000 THEN salary + (salary * 0.05)
        WHEN salary < 45000 THEN salary + (salary * 0.07)
    END AS new_salary,
    CASE
        WHEN dept_id = 6 THEN salary * 0.10
        ELSE 0
    END AS bonus
FROM employee_salary;


-- 7. FINAL PAY INCLUDING RAISE AND BONUS

SELECT 
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary >= 45000 THEN salary + (salary * 0.05)
        WHEN salary < 45000 THEN salary + (salary * 0.07)
    END + 
    CASE
        WHEN dept_id = 6 THEN salary * 0.10
        ELSE 0
    END AS total_pay
FROM employee_salary;

