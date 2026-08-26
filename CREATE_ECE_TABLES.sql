-- SQL to create ECE (Electronics and Communication Engineering) students table and exam results table in Supabase
-- This is a separate system for ECE students
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE ECE STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS ece_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_ece_students_roll_number ON ece_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE ece_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select ece" ON ece_students
    FOR SELECT
    USING (true);

-- ======================================
-- 2. CREATE ECE EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS ece_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_ece_exam_results_roll_number ON ece_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE ece_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert ece results" ON ece_exam_results
    FOR INSERT
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select ece results" ON ece_exam_results
    FOR SELECT
    USING (true);

-- ======================================
-- 3. INSERT ALL 9 ECE STUDENTS
-- ======================================

-- All students use unique code: fsece
INSERT INTO ece_students (roll_number, unique_code, is_active) VALUES
('160525735001', 'fsece', true),
('160525735002', 'fsece', true),
('160525735003', 'fsece', true),
('160525735004', 'fsece', true),
('160525735005', 'fsece', true),
('160525735006', 'fsece', true),
('160525735007', 'fsece', true),
('160525735008', 'fsece', true),
('160525735009', 'fsece', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

-- Check total students added
SELECT COUNT(*) as total_ece_students FROM ece_students;

-- Display all ECE students
SELECT roll_number, unique_code, is_active, created_at 
FROM ece_students 
ORDER BY roll_number;

-- Success message
SELECT 'ECE (Electronics and Communication Engineering) tables created successfully! 9 students added with code fsece.' as status;
