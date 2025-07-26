-- TRIGGERS

-- Definition:
-- A Trigger is a block of code that automatically executes 
-- when a specified event (INSERT, UPDATE, DELETE) occurs on a table.

-- Why use Triggers?
-- - To enforce business rules automatically.
-- - To maintain data consistency between related tables.
-- - To log changes or audit activities.
-- - To prevent invalid transactions.

-- Example Setup: 
-- We have two tables: employee_salary and employee_demographics.
-- When a new employee is inserted into employee_salary, 
-- we want to automatically insert their demographic details into employee_demographics.

SELECT * FROM employee_salary;
SELECT * FROM employee_demographics;

USE parks_and_recreation;
DELIMITER $$

CREATE TRIGGER employee_insert2
AFTER INSERT ON employee_salary
FOR EACH ROW
BEGIN
    -- Automatically add a record to employee_demographics
    INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$

DELIMITER ;

-- Test the Trigger
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);

-- Check if demographics table is updated
SELECT * FROM employee_demographics;

-- Cleanup test data
DELETE FROM employee_salary WHERE employee_id = 13;



-- 1. Trigger BEFORE UPDATE: Automatically prevent salary decreases
DELIMITER $$

CREATE TRIGGER prevent_salary_decrease
BEFORE UPDATE ON employee_salary
FOR EACH ROW
BEGIN
    IF NEW.salary < OLD.salary THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Salary decrease not allowed.';
    END IF;
END $$

DELIMITER ;

-- 2. Trigger AFTER DELETE: Archive deleted records
CREATE TABLE IF NOT EXISTS employee_salary_archive AS SELECT * FROM employee_salary WHERE 1=0;

DELIMITER $$

CREATE TRIGGER archive_deleted_employee
AFTER DELETE ON employee_salary
FOR EACH ROW
BEGIN
    INSERT INTO employee_salary_archive 
    VALUES (OLD.employee_id, OLD.first_name, OLD.last_name, OLD.occupation, OLD.salary, OLD.dept_id);
END $$

DELIMITER ;



-- EVENTS (Scheduled Tasks)

-- Definition:
-- An Event is a scheduled job in MySQL that runs SQL statements 
-- automatically at a specific time or interval.

-- Why use Events?
-- - Automate repetitive tasks.
-- - Schedule data cleanup, reporting, or updates.
-- - Reduce manual intervention.

-- Example: Retire employees aged 60+ automatically
SHOW EVENTS;

DROP EVENT IF EXISTS delete_retirees;

DELIMITER $$

CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
    DELETE FROM parks_and_recreation.employee_demographics
    WHERE age >= 60;
END $$

DELIMITER ;

-- Check table to see if records are updated
SELECT * FROM parks_and_recreation.employee_demographics;


-- 1. Disable event after use
ALTER EVENT delete_retirees DISABLE;

-- 2. Enable event
ALTER EVENT delete_retirees ENABLE;

