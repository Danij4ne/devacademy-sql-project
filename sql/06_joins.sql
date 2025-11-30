
USE devacademy;

-- 8. JOINS

-- 8.1 INNER JOIN:
-- Students with their company name (only those with a company)

SELECT 
    s.name AS student_name, 
    c.name AS company_name
FROM students s
INNER JOIN companies c
    ON s.company_id = c.company_id;

-- 8.2 LEFT JOIN:
-- All students with their dni_number if it exists (NULL otherwise)

SELECT 
    s.name, 
    d.dni_number 
FROM students s
LEFT JOIN dni d
    ON s.student_id = d.student_id;

-- 8.2 (second) LEFT JOIN:
-- All teachers with their mentor (NULL if no mentor)

SELECT 
    t.name AS teacher_name,
    m.name AS mentor_name
FROM teachers t
LEFT JOIN teachers m
    ON t.mentor_id = m.teacher_id;

-- 8.3 RIGHT JOIN:
-- All DNI entries with the associated student name (if any)

SELECT 
    d.dni_number,
    s.name AS student_name
FROM students s
RIGHT JOIN dni d
    ON s.student_id = d.student_id;

-- 8.4 N:M:
-- Join students, enrollments and courses to show:
-- student_name, course_name, payment_status

SELECT 
    s.name  AS student_name,
    c.name  AS course_name,
    e.payment_status
FROM enrollments e
INNER JOIN students s
    ON e.student_id = s.student_id
INNER JOIN courses c
    ON e.course_id = c.course_id;

-- 8.5 Simulated FULL JOIN using UNION ALL:
-- Combine LEFT JOIN and RIGHT JOIN between students and dni
-- to see students without dni and dni without students

-- LEFT JOIN: all students (with their dni or NULL)
SELECT 
    s.name AS student_name,
    d.dni_number AS dni_number
FROM students s
LEFT JOIN dni d
    ON s.student_id = d.student_id

UNION ALL

-- RIGHT JOIN: all dni (with their student or NULL)
SELECT
    s.name AS student_name,
    d.dni_number AS dni_number
FROM students s
RIGHT JOIN dni d
    ON s.student_id = d.student_id;
