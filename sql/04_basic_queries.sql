USE devacademy;

-- 5. BASIC QUERIES

-- 5.1 Select all students ordered by register_date (DESC)

SELECT * 
FROM students
ORDER BY register_date DESC;

-- 5.2 Select name and email from students whose email ends with "@gmail.com"

SELECT name, email 
FROM students 
WHERE email LIKE '%@gmail.com';

-- 5.3 Select the 3 cheapest courses (by price ASC)

SELECT name, price
FROM courses
ORDER BY price ASC 
LIMIT 3;

-- 5.4 Select teachers whose specialty contains "Data"

SELECT name, specialty
FROM teachers
WHERE specialty LIKE '%Data%';

-- 5.5 Select students with NULL email

SELECT name 
FROM students
WHERE email IS NULL;

-- 5.6 Select students whose country is Spain or Mexico

SELECT *
FROM students
WHERE country IN ('Spain', 'Mexico');

-- 5.7 Select courses with price between 100 and 500

SELECT * 
FROM courses 
WHERE price BETWEEN 100 AND 500;
