-- =============================================
-- CREATE CIVIL ENGINEERING STUDENTS TABLE
-- =============================================
-- 28 students with roll numbers 160525732001 to 160525732028
-- Unique code: fscivil
-- Same Git/Linux questions as CSE (60 questions, 20 random)
-- =============================================

-- Create civil_students table
CREATE TABLE IF NOT EXISTS civil_students (
    id SERIAL PRIMARY KEY,
    roll_number VARCHAR(20) UNIQUE NOT NULL,
    unique_code VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create civil_exam_results table
CREATE TABLE IF NOT EXISTS civil_exam_results (
    id SERIAL PRIMARY KEY,
    roll_number VARCHAR(20) NOT NULL,
    unique_code VARCHAR(20) NOT NULL,
    score INTEGER NOT NULL,
    total_questions INTEGER NOT NULL DEFAULT 20,
    correct_answers INTEGER NOT NULL,
    wrong_answers INTEGER NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    exam_completed BOOLEAN DEFAULT TRUE,
    violation_detected BOOLEAN DEFAULT FALSE,
    violation_type VARCHAR(50),
    exam_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    additional_data JSONB,
    FOREIGN KEY (roll_number) REFERENCES civil_students(roll_number)
);

-- Insert 28 Civil Engineering students
INSERT INTO civil_students (roll_number, unique_code) VALUES
('160525732001', 'fscivil'),
('160525732002', 'fscivil'),
('160525732003', 'fscivil'),
('160525732004', 'fscivil'),
('160525732005', 'fscivil'),
('160525732006', 'fscivil'),
('160525732007', 'fscivil'),
('160525732008', 'fscivil'),
('160525732009', 'fscivil'),
('160525732010', 'fscivil'),
('160525732011', 'fscivil'),
('160525732012', 'fscivil'),
('160525732013', 'fscivil'),
('160525732014', 'fscivil'),
('160525732015', 'fscivil'),
('160525732016', 'fscivil'),
('160525732017', 'fscivil'),
('160525732018', 'fscivil'),
('160525732019', 'fscivil'),
('160525732020', 'fscivil'),
('160525732021', 'fscivil'),
('160525732022', 'fscivil'),
('160525732023', 'fscivil'),
('160525732024', 'fscivil'),
('160525732025', 'fscivil'),
('160525732026', 'fscivil'),
('160525732027', 'fscivil'),
('160525732028', 'fscivil');

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_civil_students_roll_code ON civil_students(roll_number, unique_code);
CREATE INDEX IF NOT EXISTS idx_civil_results_roll ON civil_exam_results(roll_number);
CREATE INDEX IF NOT EXISTS idx_civil_results_date ON civil_exam_results(exam_date);

-- Verify insertion
SELECT COUNT(*) as total_civil_students FROM civil_students;

-- Display all civil students
SELECT * FROM civil_students ORDER BY roll_number;
