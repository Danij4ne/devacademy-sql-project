USE devacademy;

-- 9. INDEXES

-- 9.1 Create an index on students(email)

CREATE INDEX idx_email 
ON students (email);

-- 9.2 Create a UNIQUE composite index on teachers(name, surname)

CREATE UNIQUE INDEX idx_teacher_fullname
ON teachers (name, surname);

-- 9.3 Query filtering by email

SELECT email
FROM students
WHERE email LIKE 'k%';

-- 9.4 Drop one of the indexes

DROP INDEX idx_email ON students;

-- 10. TRIGGER

-- 10.1 Create table "email_history_students" to log email changes

CREATE TABLE email_history_students (
  history_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  old_email VARCHAR(50),
  changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id)
    REFERENCES students(student_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- 10.2 Create TRIGGER on students to log email changes

DELIMITER $$

CREATE TRIGGER tg_email
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
  IF OLD.email <> NEW.email THEN
    INSERT INTO email_history_students (student_id, old_email)
    VALUES (OLD.student_id, OLD.email);
  END IF;
END$$

DELIMITER ;

-- 10.3 Perform several UPDATEs to fire the trigger

UPDATE students 
SET email = 'Rodrigo@DevAcademy.com' 
WHERE student_id = 1;

UPDATE students 
SET email = 'Lucia@DevAcademy.com' 
WHERE student_id = 2;

UPDATE students 
SET email = 'Mateo@DevAcademy.com' 
WHERE student_id = 3;

-- 10.4 Check email_history_students

SELECT * FROM email_history_students;

-- 10.5 Drop the trigger

DROP TRIGGER tg_email;

-- 11. VIEWS

-- 11.1 Create VIEW "v_active_students":
-- Shows only active students with:
-- student_id, full_name, email, company_name (if any)

CREATE VIEW v_active_students AS
SELECT 
    s.student_id,
    CONCAT(s.name, ' ', s.surname) AS FullName,
    s.email,
    c.name AS company_name
FROM students s
LEFT JOIN companies c 
    ON s.company_id = c.company_id
WHERE s.active = 1;

-- 11.2 Create VIEW "v_course_enrollments":
-- Shows:
-- course_id, course_name, total_enrollments, price, level

CREATE VIEW v_course_enrollments AS
SELECT 
    c.course_id,
    c.name,
    COUNT(e.course_id) AS total_enrollments,
    c.price,
    c.level
FROM courses c
LEFT JOIN enrollments e 
    ON c.course_id = e.course_id
GROUP BY 
    c.course_id,
    c.name,
    c.price,
    c.level;

-- 11.3 Select from both views

SELECT * FROM v_active_students;
SELECT * FROM v_course_enrollments;

-- 11.4 Drop one of the views

DROP VIEW v_active_students;

-- 12. STORED PROCEDURES

DELIMITER //

-- 12.1 Procedure "p_all_students":
-- Returns all students

CREATE PROCEDURE p_all_students ()
BEGIN
  SELECT * FROM students;
END//

-- 12.2 Procedure "p_students_by_country":
-- Returns students filtered by a given country

CREATE PROCEDURE p_students_by_country (IN country_param VARCHAR(50))
BEGIN 
  SELECT *
  FROM students 
  WHERE country = country_param;
END//

-- 12.3 Procedure "p_enrollments_by_course":
-- For a given course_id, returns:
-- course_name, student_name, payment_status

CREATE PROCEDURE p_enrollments_by_course(IN course_param INT)
BEGIN 
  SELECT 
    c.name AS course_name,
    s.name AS student_name,
    e.payment_status
  FROM enrollments e
  JOIN students s 
    ON e.student_id = s.student_id
  JOIN courses c 
    ON e.course_id = c.course_id
  WHERE c.course_id = course_param;
END//

DELIMITER ;

-- 12.4 Execute procedures with different values

CALL p_enrollments_by_course(3);
CALL p_students_by_country('Spain');
CALL p_all_students();

-- 12.5 Drop one of the procedures

DROP PROCEDURE p_all_students;
