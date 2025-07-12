--  WHERE is used to filter individual rows *before* aggregation
--  HAVING is used to filter *after* aggregation (on grouped results)

select * from employee_demographics;

-- This returns average age per gender
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

--  This will NOT work because WHERE cannot be used with aggregate functions like AVG()
SELECT gender, AVG(age)
FROM employee_demographics
WHERE AVG(age) > 40
GROUP BY gender;

-- ❌ ERROR: Invalid use of aggregate function in WHERE clause

--  This works: we group by gender and then filter groups where average age > 40
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

--  Using an alias 'AVG_age' and then filtering on it in the HAVING clause
SELECT gender, AVG(age) AS AVG_age
FROM employee_demographics
GROUP BY gender
HAVING AVG_age > 40;


-- Occupations with Average Salary Above 60,000

SELECT occupation, AVG(salary) AS avg_salary
FROM employee_salary
GROUP BY occupation
HAVING avg_salary > 60000;

-- Departments with More Than 1 Employee

SELECT dept_id, COUNT(*) AS employee_count
FROM employee_salary
GROUP BY dept_id
HAVING employee_count > 1;

-- Departments with Minimum Salary Less Than 30000

SELECT dept_id, MIN(salary) AS min_salary
FROM employee_salary
GROUP BY dept_id
HAVING min_salary < 30000;
