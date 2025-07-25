-- Using Temporary Tables in SQL
-- Temporary tables are only visible to the session that created them. 
-- They are commonly used to store intermediate results, simplify complex queries, 
-- or manipulate data before inserting into permanent tables.

-- 1. Creating a temporary table manually (less common way)

CREATE TEMPORARY TABLE temp_table (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    favorite_movie VARCHAR(100)
);

-- Insert sample data
INSERT INTO temp_table (first_name, last_name, favorite_movie)
VALUES 
('Alex', 'Freberg', 'The Lord of the Rings: The Two Towers'),
('John', 'Doe', 'Inception'),
('Sarah', 'Smith', 'Interstellar');

-- Query the temporary table
SELECT * 
FROM temp_table;

-- Update data in the temporary table
SET SQL_SAFE_UPDATES = 0;
UPDATE temp_table
SET favorite_movie = 'The Lord of the Rings: The Fellowship of the Ring'
WHERE first_name = 'Alex';

-- Delete a record
DELETE FROM temp_table
WHERE last_name = 'Doe';

SELECT * FROM temp_table;


-- 2. Creating a temporary table using SELECT INTO (preferred)


CREATE TEMPORARY TABLE salary_over_50k AS
SELECT *
FROM employee_salary
WHERE salary > 50000;

-- Verify data in the new temp table
SELECT * 
FROM salary_over_50k;

-- Add a calculated column to the temp table
ALTER TABLE salary_over_50k ADD COLUMN bonus DECIMAL(10,2);

-- Update the bonus column based on salary
UPDATE salary_over_50k
SET bonus = salary * 0.10;

SELECT * FROM salary_over_50k;


-- 3. Using JOIN with a temporary table


SELECT e.employee_id, e.first_name, e.last_name, s.salary, s.bonus
FROM employee_demographics e
JOIN salary_over_50k s
    ON e.employee_id = s.employee_id;


-- 4. Dropping temporary tables

DROP TEMPORARY TABLE IF EXISTS temp_table;
DROP TEMPORARY TABLE IF EXISTS salary_over_50k;


-- Notes:
-- - Temporary tables automatically get deleted when your session ends.
-- - Useful for breaking down complex queries into smaller, manageable steps.
-- - If you just need to transform data for a single query, consider using a CTE (Common Table Expression).
