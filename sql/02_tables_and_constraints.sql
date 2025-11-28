USE devacademy;

-- 2. MAIN TABLES

-- 2.1 "students" table
-- Columns:
-- - student_id: INT, PRIMARY KEY, AUTO_INCREMENT, NOT NULL
-- - name: VARCHAR(50), NOT NULL
-- - surname: VARCHAR(50), NOT NULL
-- - email: VARCHAR(50), NOT NULL
-- - country: VARCHAR(50), NULL
-- - birth_date: DATE, NULL
-- - register_date: DATETIME, default CURRENT_TIMESTAMP
-- - active: BOOLEAN, default 1

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    country VARCHAR(50),
    birth_date DATE,
    register_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN DEFAULT 1
);

-- 2.2 "teachers" table
-- Columns:
-- - teacher_id: INT, PRIMARY KEY, AUTO_INCREMENT
-- - name: VARCHAR(50), NOT NULL
-- - surname: VARCHAR(50), NOT NULL
-- - email: VARCHAR(50), UNIQUE, NOT NULL
-- - specialty: VARCHAR(50), NULL
-- - hire_date: DATETIME, default CURRENT_TIMESTAMP

CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    specialty VARCHAR(50),
    hire_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2.3 "courses" table
-- Columns:
-- - course_id: INT, PRIMARY KEY, AUTO_INCREMENT
-- - name: VARCHAR(50), UNIQUE, NOT NULL
-- - level: VARCHAR(50), NULL (Beginner, Intermediate, Advanced...)
-- - price: DECIMAL(10,2), NOT NULL, CHECK price > 0
-- - hours: INT, NOT NULL
-- - created_at: DATETIME, default CURRENT_TIMESTAMP

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    level VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    hours INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (price > 0)
);

-- 2.4 Relationship 1:N (teachers -> courses)
-- Add teacher_id as foreign key in courses

ALTER TABLE courses 
ADD teacher_id INT;

ALTER TABLE courses 
ADD CONSTRAINT foreign_teacher_id
FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id)
ON DELETE CASCADE;

-- 2.5 Relationship 1:1 (students -> dni)
-- "dni" table:
-- - dni_id: INT, PRIMARY KEY, AUTO_INCREMENT
-- - dni_number: VARCHAR(50), UNIQUE, NOT NULL
-- - student_id: INT, UNIQUE, FK to students(student_id)

CREATE TABLE dni (
    dni_id INT AUTO_INCREMENT PRIMARY KEY,
    dni_number VARCHAR(50) NOT NULL UNIQUE,
    student_id INT UNIQUE,
    FOREIGN KEY (student_id)
        REFERENCES students (student_id)
        ON DELETE CASCADE
);

-- 2.6 Relationship N:M (students <-> courses) via "enrollments"
-- "enrollments" table:
-- - enrollment_id: INT, PRIMARY KEY, AUTO_INCREMENT
-- - student_id: INT, NOT NULL, FK
-- - course_id: INT, NOT NULL, FK
-- - enroll_date: DATETIME, default CURRENT_TIMESTAMP
-- - payment_status: ENUM('PENDING','PAID','CANCELLED'), default 'PENDING'
-- - UNIQUE(student_id, course_id)

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id    INT NOT NULL,
    course_id     INT NOT NULL,
    enroll_date   DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('PENDING','PAID','CANCELLED') NOT NULL DEFAULT 'PENDING',
    UNIQUE (student_id, course_id),
    CONSTRAINT fk_enroll_student
        FOREIGN KEY (student_id) 
        REFERENCES students (student_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_enroll_course
        FOREIGN KEY (course_id) 
        REFERENCES courses (course_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- 3. EXTRA TABLES AND SELF-REFERENCE

-- 3.1 "companies" table
-- - company_id: INT, PRIMARY KEY, AUTO_INCREMENT
-- - name: VARCHAR(50), UNIQUE, NOT NULL
-- - country: VARCHAR(50), NULL
-- - created_at: DATETIME, default CURRENT_TIMESTAMP

CREATE TABLE companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    country VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 3.2 Relationship 1:N (companies -> students)
-- Add company_id to students as optional FK

ALTER TABLE students 
ADD COLUMN company_id INT;

ALTER TABLE students
ADD CONSTRAINT fk_company_id
FOREIGN KEY (company_id) REFERENCES companies (company_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- 3.3 Self-reference in "teachers" (mentor_id -> teacher_id)

ALTER TABLE teachers 
ADD COLUMN mentor_id INT,
ADD CONSTRAINT fk_mentor
FOREIGN KEY (mentor_id) REFERENCES teachers (teacher_id)
ON DELETE SET NULL
ON UPDATE CASCADE;
