--- String Functions ------

-- LENGTH(): Returns the number of bytes (not characters) in a string
SELECT LENGTH('skyfall');

-- Apply LENGTH to each employee's first name and sort by length (ascending)
SELECT first_name, LENGTH(first_name) AS name_length
FROM employee_demographics
ORDER BY name_length;

-- UPPER(): Converts string to uppercase
SELECT UPPER('sky');

-- Apply UPPER to column
SELECT first_name, UPPER(first_name) AS upper_name
FROM employee_demographics;

-- LOWER(): Converts string to lowercase
SELECT LOWER('SKY');

-- Apply LOWER to column
SELECT first_name, LOWER(first_name) AS lower_name
FROM employee_demographics;

-- TRIM(): Removes both leading and trailing spaces
SELECT TRIM('       sky        ');

-- LTRIM(): Removes leading spaces
SELECT LTRIM('       sky');

-- RTRIM(): Removes trailing spaces
SELECT RTRIM('sky       ');

-- LEFT(): Returns a fixed number of characters from the left
SELECT LEFT('Alexander', 4);

-- Apply LEFT to names
SELECT first_name, LEFT(first_name, 4) AS first_four_letters
FROM employee_demographics;

-- RIGHT(): Returns characters from the right
SELECT RIGHT('Alexander', 6);

-- Apply RIGHT to names
SELECT first_name, RIGHT(first_name, 4) AS last_four_letters
FROM employee_demographics;

-- SUBSTRING(): Extract characters from a given start position and length
SELECT SUBSTRING('Alexander', 2, 3) AS sub_part;

-- Extract birth year from birth_date
SELECT birth_date, SUBSTRING(birth_date, 1, 4) AS birth_year
FROM employee_demographics;

-- REPLACE(): Replaces all instances of a substring
SELECT REPLACE('Alexander', 'e', '*');

-- Replace characters in column values
SELECT first_name, REPLACE(first_name, 'a', 'z') AS replaced_name
FROM employee_demographics;

-- LOCATE(): Returns position of first occurrence of substring
SELECT LOCATE('x', 'Alexander') AS position_x;

-- LOCATE returns position of first 'e'
SELECT LOCATE('e', 'Alexander') AS position_e;

-- LOCATE in column values
SELECT first_name, LOCATE('a', first_name) AS position_a
FROM employee_demographics;

-- LOCATE longer string
SELECT first_name, LOCATE('Mic', first_name) AS position_mic
FROM employee_demographics;

-- CONCAT(): Concatenates two or more strings
SELECT CONCAT('Alex', 'Freberg') AS full_string;

-- Combine first and last name as full name
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;

-- CHAR_LENGTH(): Returns number of characters (not bytes)
SELECT CHAR_LENGTH('Alexander') AS char_length;

-- REVERSE(): Reverses a string
SELECT REVERSE('Alexander') AS reversed;

-- REPEAT(): Repeats a string N number of times
SELECT REPEAT('Na', 3) AS repeated;

-- ASCII(): Returns ASCII code of first character
SELECT ASCII('A') AS ascii_A;

-- INSTR(): Similar to LOCATE but reversed argument order
SELECT INSTR('Alexander', 'e') AS position_e_instr;

-- LPAD() & RPAD(): Pads the string on left/right with characters to a certain length
SELECT LPAD('123', 6, '0') AS left_padded;   
SELECT RPAD('123', 6, '*') AS right_padded;  

-- ELT(): Returns the Nth string from a list
SELECT ELT(2, 'first', 'second', 'third') AS second_value;  

-- FIELD(): Returns the index of the value from a list
SELECT FIELD('b', 'a', 'b', 'c') AS index_value; 

-- FORMAT(): Rounds number to given decimals and returns as string
SELECT FORMAT(12345.6789, 2) AS formatted; 

-- SPACE(): Adds space of given length
SELECT CONCAT('Hello', SPACE(5), 'World') AS spaced;


