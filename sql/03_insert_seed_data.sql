
USE devacademy;

-- 4. DATA INSERTION

-- 4.1 Insert students

INSERT INTO students (name, surname, email, country, birth_date) 
VALUES 
('Rodrigo', 'Garcia', 'rgarci@gmail.com', 'Spain', '2001-05-17'),
('Lucía', 'Fernandez', 'lfernandez@gmail.com', 'Argentina', '2002-09-23'),
('Mateo', 'Rossi', 'mrossi@gmail.com', 'Italy', '1999-12-04'),
('Sophie', 'Dubois', 'sdubois@gmail.com', 'France', '2003-03-19'),
('Daniel', 'Smith', 'dsmith@gmail.com', 'United Kingdom', '2000-11-10'),
('Nora', 'Müller', 'nmuller@gmail.com', 'Germany', '2004-06-25'),
('Kenji', 'Tanaka', 'ktanaka@gmail.com', 'Japan', '2002-01-08'),
('Isabella', 'Martinez', 'imartinez@gmail.com', 'Mexico', '2005-07-30');

-- Insert teachers

INSERT INTO teachers (name, surname, email, specialty, hire_date) 
VALUES
('Ana', 'Pérez', 'ana.perez@devacademy.com', 'Data Engineering', '2020-03-15'),
('Luis', 'Gómez', 'luis.gomez@devacademy.com', 'Backend Development', '2021-07-22'),
('Marta', 'López', 'marta.lopez@devacademy.com', 'Frontend Development', '2022-02-10'),
('Carlos', 'Ruiz', 'carlos.ruiz@devacademy.com', 'Cybersecurity', '2023-01-05'),
('Elena', 'Torres', 'elena.torres@devacademy.com', 'Cloud Computing', '2024-04-18');

-- Set mentors for some teachers

UPDATE teachers SET mentor_id = 1 WHERE teacher_id IN (2, 3);
UPDATE teachers SET mentor_id = 4 WHERE teacher_id = 5;

-- Insert companies

INSERT INTO companies (name, country)
VALUES
('TechNova Solutions', 'Spain'),
('GlobalSoft Innovations', 'United States'),
('CloudBridge Systems', 'Germany');

-- Insert courses

INSERT INTO courses (name, level, price, hours)
VALUES
('Introduction to Python', 'Beginner', 120.00, 40),
('Advanced SQL for Data Analysis', 'Advanced', 350.00, 60),
('Web Development with JavaScript', 'Intermediate', 280.00, 55),
('Data Engineering with MySQL', 'Intermediate', 300.00, 50),
('Cloud Computing Fundamentals', 'Beginner', 180.00, 35),
('Cybersecurity Essentials', 'Intermediate', 250.00, 45),
('Machine Learning with Python', 'Advanced', 420.00, 70),
('DevOps and CI/CD Pipelines', 'Advanced', 390.00, 65);

-- Insert DNI records

INSERT INTO dni (dni_number, student_id)
VALUES
('X1234567A', 1),
('Y9876543B', 2),
('Z1122334C', 3),
('P5566778D', 5);

-- Insert enrollments (N:M relationships between students and courses)

INSERT INTO enrollments (student_id, course_id, payment_status)
VALUES
(1, 1, 'PAID'),
(1, 2, 'PENDING'),
(2, 3, 'CANCELLED'),
(3, 4, 'PAID'),
(4, 5, 'PAID'),
(5, 6, 'PENDING'),
(6, 7, 'PAID'),
(7, 8, 'CANCELLED'),
(8, 1, 'PAID'),
(2, 5, 'PENDING');

-- 4.2 Adjust data to ensure:
-- - Some students with NULL email
-- - Some students without company_id
-- - Different payment_status values in enrollments

ALTER TABLE students
MODIFY email VARCHAR(50) NULL;

UPDATE students
SET email = NULL
WHERE student_id IN (2, 3);

UPDATE students 
SET company_id = 1
WHERE student_id IN (1, 2, 3);

UPDATE students 
SET company_id = 2
WHERE student_id IN (4, 5);

UPDATE students 
SET company_id = 3
WHERE student_id IN (6);
