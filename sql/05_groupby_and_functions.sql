USE devacademy;

-- 6. AGGREGATIONS, GROUP BY, HAVING

-- 6.1 Count total students

SELECT COUNT(*) AS total_students
FROM students;

-- 6.1 Average course price

SELECT AVG(price) AS average_price
FROM courses;

-- 6.1 Number of courses per level

SELECT level,
       COUNT(*) AS total_courses
FROM courses  
GROUP BY level;

-- 6.2 Count enrollments per payment_status

SELECT payment_status,
       COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY payment_status
ORDER BY total_enrollments DESC;

-- 6.3 Count number of students per company

SELECT company_id,
       COUNT(*) AS total_students
FROM students
GROUP BY company_id
ORDER BY company_id ASC;

-- 6.4 Show only companies with more than 2 students

SELECT company_id AS company,
       COUNT(*) AS students
FROM students
GROUP BY company_id
HAVING COUNT(*) > 2;

-- 6.5 Get minimum and maximum age of students using birth_date

SELECT 
    MIN(TIMESTAMPDIFF(YEAR, birth_date, CURDATE())) AS youngest_age,
    MAX(TIMESTAMPDIFF(YEAR, birth_date, CURDATE())) AS oldest_age
FROM students;

-- 7. STRING FUNCTIONS, CASE, NULL HANDLING

-- 7.1 List students with "full_name" column

SELECT CONCAT(name, ' ', surname) AS full_name
FROM students;

-- 7.2 List courses with a formatted price string:
-- "Course: [name] - [price]€"

SELECT name,
       price,
       CONCAT('Course: ', name, ' - ', price, '€') AS formatted_price
FROM courses;

-- 7.3 Add a descriptive column for payment_status using CASE

SELECT *,
       CASE
           WHEN payment_status = 'PAID' THEN 'Payment completed'
           WHEN payment_status = 'PENDING' THEN 'Pending payment'
           ELSE 'Cancelled'
       END AS payment_description
FROM enrollments;

-- 7.4 List students showing company_id or the text "No company" using IFNULL

SELECT *, 
       IFNULL(company_id, 'No company') AS company_display
FROM students;
