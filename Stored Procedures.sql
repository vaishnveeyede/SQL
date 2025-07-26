-- WHAT IS A STORED PROCEDURE?
---- A stored procedure is a precompiled set of one or more SQL statements 
---- stored on the database server. 

-- Key Points:
--- 1. Encapsulates repetitive or complex logic in one reusable unit.
--- 2. Reduces code duplication in applications.
--- 3. Improves performance since SQL is precompiled.
--- 4. Helps with better security: restrict direct table access, use parameters.
--- 5. Easier to maintain and update business logic.

-- WHY DO WE USE STORED PROCEDURES?
--- To improve performance (precompiled and optimized by the DB engine).
--- To enforce consistent logic across applications.
--- To handle complex transactions and conditional logic.
--- To reduce network traffic (run multiple SQL statements in one call).
--- To simplify security by granting EXECUTE permissions only.

-- 1. SIMPLE QUERY (WITHOUT A STORED PROCEDURE)
SELECT *
FROM employee_salary
WHERE salary >= 60000;

-- 2. BASIC STORED PROCEDURE (SINGLE QUERY)
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 60000;

CALL large_salaries();

3. USING DELIMITER & BEGIN-END BLOCK FOR MULTIPLE QUERIES
DELIMITER $$

CREATE PROCEDURE large_salaries2()
BEGIN
    SELECT *
    FROM employee_salary
    WHERE salary >= 60000;

    SELECT *
    FROM employee_salary
    WHERE salary BETWEEN 50000 AND 59999;
END $$

DELIMITER ;

CALL large_salaries2();

-- 4. PROCEDURE WITH INPUT PARAMETER
USE `parks_and_recreation`;
DROP PROCEDURE IF EXISTS `large_salaries3`;

DELIMITER $$

CREATE PROCEDURE large_salaries3(IN employee_id_param INT)
BEGIN
    SELECT *
    FROM employee_salary
    WHERE salary >= 60000
      AND employee_id = employee_id_param;
END $$

DELIMITER ;

CALL large_salaries3(1);

-- 5. PROCEDURE WITH MULTIPLE PARAMETERS (FILTER BY occupation & SALARY)
DROP PROCEDURE IF EXISTS filter_employees;

DELIMITER $$

CREATE PROCEDURE filter_employees(
    IN min_salary DECIMAL(10,2),
    IN occupation_name VARCHAR(100)
)
BEGIN
    SELECT employee_id, first_name, last_name, salary, occupation
    FROM employee_salary
    WHERE salary >= min_salary
      AND occupation = occupation_name
    ORDER BY salary DESC;
END $$

DELIMITER ;
select * from employee_salary;
CALL filter_employees(50000, 'Office Manager');

-- 6. PROCEDURE WITH OUTPUT PARAMETER (COUNT OF HIGH SALARY EMPLOYEES)
DROP PROCEDURE IF EXISTS get_total_high_salary;

DELIMITER $$

CREATE PROCEDURE get_total_high_salary(
    IN min_salary DECIMAL(10,2),
    OUT total_count INT
)
BEGIN
    SELECT COUNT(*) INTO total_count
    FROM employee_salary
    WHERE salary >= min_salary;
END $$

DELIMITER ;

SET @total = 0;
CALL get_total_high_salary(60000, @total);
SELECT @total AS Total_High_Salary_Employees;

-- 7. PROCEDURE WITH CONDITIONAL LOGIC (IF-ELSE)
DROP PROCEDURE IF EXISTS check_salary_level;

DELIMITER $$

CREATE PROCEDURE check_salary_level(IN emp_id INT)
BEGIN
    DECLARE emp_salary DECIMAL(10,2);

    SELECT salary INTO emp_salary
    FROM employee_salary
    WHERE employee_id = emp_id;

    IF emp_salary >= 70000 THEN
        SELECT 'High Salary Level' AS Salary_Level;
    ELSEIF emp_salary >= 50000 THEN
        SELECT 'Medium Salary Level' AS Salary_Level;
    ELSE
        SELECT 'Low Salary Level' AS Salary_Level;
    END IF;
END $$

DELIMITER ;

CALL check_salary_level(2);


