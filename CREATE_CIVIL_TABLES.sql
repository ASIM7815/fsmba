-- SQL to create Civil Engineering students table and exam results table in Supabase
-- This is a separate system for Civil Engineering students
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE CIVIL STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS civil_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_civil_students_roll_number ON civil_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE civil_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select civil" ON civil_students
    FOR SELECT
    USING (true);

-- ======================================
-- 2. CREATE CIVIL EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS civil_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_civil_exam_results_roll_number ON civil_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE civil_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert civil results" ON civil_exam_results
    FOR INSERT
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select civil results" ON civil_exam_results
    FOR SELECT
    USING (true);

-- ======================================
-- 3. INSERT ALL 28 CIVIL STUDENTS
-- ======================================

-- All students use unique code: fscivil
INSERT INTO civil_students (roll_number, unique_code, is_active) VALUES
('160525732001', 'fscivil', true),
('160525732002', 'fscivil', true),
('160525732003', 'fscivil', true),
('160525732004', 'fscivil', true),
('160525732005', 'fscivil', true),
('160525732006', 'fscivil', true),
('160525732007', 'fscivil', true),
('160525732008', 'fscivil', true),
('160525732009', 'fscivil', true),
('160525732010', 'fscivil', true),
('160525732011', 'fscivil', true),
('160525732012', 'fscivil', true),
('160525732013', 'fscivil', true),
('160525732014', 'fscivil', true),
('160525732015', 'fscivil', true),
('160525732016', 'fscivil', true),
('160525732017', 'fscivil', true),
('160525732018', 'fscivil', true),
('160525732019', 'fscivil', true),
('160525732020', 'fscivil', true),
('160525732021', 'fscivil', true),
('160525732022', 'fscivil', true),
('160525732023', 'fscivil', true),
('160525732024', 'fscivil', true),
('160525732025', 'fscivil', true),
('160525732026', 'fscivil', true),
('160525732027', 'fscivil', true),
('160525732028', 'fscivil', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

-- Check total students added
SELECT COUNT(*) as total_civil_students FROM civil_students;

-- Display all civil students
SELECT roll_number, unique_code, is_active, created_at 
FROM civil_students 
ORDER BY roll_number;

-- Success message
SELECT 'Civil Engineering tables created successfully! 28 students added with code fscivil.' as status;
