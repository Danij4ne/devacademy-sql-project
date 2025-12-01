USE devacademy;

-- 13. UPDATE, DELETE, ALTER, DROP

-- 13.1 UPDATE:
-- Change payment_status for some enrollments

UPDATE enrollments 
SET payment_status = 'PAID'
WHERE student_id = 7;

UPDATE enrollments 
SET payment_status = 'PAID'
WHERE student_id = 2 AND course_id = 5;

-- 13.2 DELETE:
-- Delete specific enrollments using WHERE

DELETE FROM enrollments
WHERE student_id = 2 AND course_id = 3;

-- 13.3 ALTER TABLE:
-- Add "phone" column to students
-- Modify size of surname in teachers
-- Drop an unnecessary column in students

ALTER TABLE students 
ADD COLUMN phone VARCHAR(20);

ALTER TABLE teachers 
MODIFY COLUMN surname VARCHAR(80);

ALTER TABLE students 
DROP COLUMN phone;

-- 14. FINAL QUERIES (REPORTS)

-- 14.1 Show the top 5 students with the highest number of courses:
-- - full name
-- - total number of courses
-- - company (if any)

SELECT 
    CONCAT(s.name, ' ', s.surname) AS fullname,
    COUNT(e.course_id) AS total_courses,
    IFNULL(cmp.name, 'No company') AS company
FROM students s
LEFT JOIN enrollments e 
    ON s.student_id = e.student_id
LEFT JOIN companies cmp
    ON s.company_id = cmp.company_id
GROUP BY 
    s.student_id,
    fullname,
    company
ORDER BY total_courses DESC
LIMIT 5;

-- 14.2 Show courses with the highest total revenue:
-- - Only enrollments with payment_status = 'PAID'
-- - course_name
-- - number of students
-- - total amount paid

SELECT 
    c.name,
    COUNT(DISTINCT s.student_id) AS students_number,
    SUM(c.price) AS total_paid
FROM courses c
JOIN enrollments e
    ON c.course_id = e.course_id
JOIN students s
    ON s.student_id = e.student_id
WHERE e.payment_status = 'PAID'
GROUP BY c.name, c.price;

-- 14.3 Show all teachers with the number of courses they have:
-- If they do not have courses, they must appear with 0

SELECT 
    t.teacher_id,
    CONCAT(t.name, ' ', t.surname) AS teacher_name,
    COUNT(c.course_id) AS total_courses
FROM teachers t
LEFT JOIN courses c
    ON t.teacher_id = c.teacher_id
GROUP BY 
    t.teacher_id,
    teacher_name;

-- 14.4 For each company:
-- - company name
-- - number of associated students
-- - total number of enrollments for those students

SELECT 
    c.name AS company_name,
    COUNT(DISTINCT s.student_id) AS total_students,
    COUNT(e.enroll_date) AS total_enrollments
FROM companies c
LEFT JOIN students s 
    ON c.company_id = s.company_id
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
GROUP BY c.name;

-- 14.5 Classify courses by price using CASE:
-- - "Cheap" if price < 150
-- - "Standard" if price BETWEEN 150 AND 400
-- - "Premium" if price > 400

SELECT 
    price,
    CASE
        WHEN price < 150 THEN 'Cheap'
        WHEN price BETWEEN 150 AND 400 THEN 'Standard'
        WHEN price > 400 THEN 'Premium'
        ELSE 'No price'
    END AS price_category
FROM courses;
