-- SQL to create FCSE students table and exam results table in Supabase
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE FCSE STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS fcse_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_fcse_students_roll_number ON fcse_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE fcse_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select fcse" ON fcse_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 2. CREATE FCSE EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS fcse_exam_results (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT NOT NULL,
    correct_answers INTEGER NOT NULL,
    wrong_answers INTEGER NOT NULL,
    total_questions INTEGER NOT NULL,
    percentage NUMERIC(5,2) NOT NULL,
    user_answers JSONB,
    additional_data JSONB,
    violation_type TEXT,
    violation_detected BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_fcse_exam_results_roll_number ON fcse_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE fcse_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert fcse results" ON fcse_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select fcse results" ON fcse_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 3. INSERT FCSE STUDENTS (39 students)
-- ======================================

-- All students use unique code: fcse
INSERT INTO fcse_students (roll_number, unique_code, is_active) VALUES
('160525733004', 'fcse', true),
('160525733013', 'fcse', true),
('160525733021', 'fcse', true),
('160525733022', 'fcse', true),
('160525733025', 'fcse', true),
('160525733037', 'fcse', true),
('160525733040', 'fcse', true),
('160525733053', 'fcse', true),
('160525733054', 'fcse', true),
('160525733055', 'fcse', true),
('160525733063', 'fcse', true),
('160525733070', 'fcse', true),
('160525733072', 'fcse', true),
('160525733084', 'fcse', true),
('160525733089', 'fcse', true),
('160525733090', 'fcse', true),
('160525733093', 'fcse', true),
('160525733095', 'fcse', true),
('160525733096', 'fcse', true),
('160525733100', 'fcse', true),
('160525733101', 'fcse', true),
('160525733108', 'fcse', true),
('160525733110', 'fcse', true),
('160525733131', 'fcse', true),
('160525733133', 'fcse', true),
('160525733136', 'fcse', true),
('160525733138', 'fcse', true),
('160525733142', 'fcse', true),
('160525733143', 'fcse', true),
('160525733148', 'fcse', true),
('160525733149', 'fcse', true),
('160525733158', 'fcse', true),
('160525733163', 'fcse', true),
('160525733167', 'fcse', true),
('160525733170', 'fcse', true),
('160525733172', 'fcse', true),
('160525733186', 'fcse', true),
('160525733213', 'fcse', true),
('160525733214', 'fcse', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

SELECT COUNT(*) as total_fcse_students FROM fcse_students;
SELECT 'FCSE tables created successfully! 39 students added with code fcse.' as status;
