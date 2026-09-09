-- =========================================
-- School Management Database
-- Author: [Your Name]
-- Description: Database for managing students,
-- teachers, courses, and enrollments
-- =========================================

-- Create the database
CREATE DATABASE school_management;
USE school_management;

-- -----------------------------------------
-- Table: students
-- Stores student personal and enrollment info
-- -----------------------------------------
CREATE TABLE students (
  student_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  date_of_birth DATE,
  enrollment_date DATE DEFAULT (CURRENT_DATE)
);

-- -----------------------------------------
-- Table: teachers
-- Stores teacher personal and employment info
-- -----------------------------------------
CREATE TABLE teachers (
  teacher_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  hire_date DATE DEFAULT (CURRENT_DATE)
);

-- -----------------------------------------
-- Table: courses
-- Stores course info, linked to the teacher
-- who teaches it (many courses -> one teacher)
-- -----------------------------------------
CREATE TABLE courses (
  course_id INT AUTO_INCREMENT PRIMARY KEY,
  course_name VARCHAR(100) NOT NULL,
  teacher_id INT,
  credits INT DEFAULT 3,
  FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

-- -----------------------------------------
-- Table: enrollments
-- Links students to courses (many-to-many),
-- and records the grade earned
-- -----------------------------------------
CREATE TABLE enrollments (
  enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  enrollment_date DATE DEFAULT (CURRENT_DATE),
  grade VARCHAR(2),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- -----------------------------------------
-- Sample Data
-- -----------------------------------------
INSERT INTO students (first_name, last_name, email, date_of_birth)
VALUES
('Najma', 'Adan', 'najma.adan@email.com', '2005-03-15'),
('Feysal', 'Omar', 'feysal.omar@email.com', '2004-11-02');

INSERT INTO teachers (first_name, last_name, email)
VALUES
('Grace', 'Njoroge', 'grace.njoroge@email.com'),
('Siyat', 'Yussuf', 'siyat.yussuf@email.com');

INSERT INTO courses (course_name, teacher_id, credits)
VALUES
('Mathematics', 1, 4),
('English', 2, 3);

INSERT INTO enrollments (student_id, course_id, grade)
VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'B+');

-- -----------------------------------------
-- Sample Queries
-- -----------------------------------------

-- View all records in each table
SELECT * FROM students;
SELECT * FROM teachers;
SELECT * FROM courses;
SELECT * FROM enrollments;

-- Join query: each student's enrolled courses and grades
SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

-- Join query: each course with its teacher
SELECT c.course_name, t.first_name, t.last_name
FROM courses c
JOIN teachers t ON c.teacher_id = t.teacher_id;
