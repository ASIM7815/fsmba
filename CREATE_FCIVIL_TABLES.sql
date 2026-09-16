-- SQL to create FCIVIL students table and exam results table in Supabase
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE FCIVIL STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS fcivil_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_fcivil_students_roll_number ON fcivil_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE fcivil_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select fcivil" ON fcivil_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 2. CREATE FCIVIL EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS fcivil_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_fcivil_exam_results_roll_number ON fcivil_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE fcivil_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert fcivil results" ON fcivil_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select fcivil results" ON fcivil_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 3. INSERT FCIVIL STUDENTS (5 students)
-- ======================================

-- All students use unique code: fcivil
INSERT INTO fcivil_students (roll_number, unique_code, is_active) VALUES
('160525732010', 'fcivil', true),
('160525732025', 'fcivil', true),
('160525732026', 'fcivil', true),
('160525732027', 'fcivil', true),
('160525732028', 'fcivil', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

SELECT COUNT(*) as total_fcivil_students FROM fcivil_students;
SELECT 'FCIVIL tables created successfully! 5 students added with code fcivil.' as status;
