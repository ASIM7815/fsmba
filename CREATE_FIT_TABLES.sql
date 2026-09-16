-- SQL to create FIT students table and exam results table in Supabase
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE FIT STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS fit_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_fit_students_roll_number ON fit_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE fit_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select fit" ON fit_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 2. CREATE FIT EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS fit_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_fit_exam_results_roll_number ON fit_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE fit_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert fit results" ON fit_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select fit results" ON fit_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 3. INSERT FIT STUDENTS (7 students)
-- ======================================

-- All students use unique code: fit
INSERT INTO fit_students (roll_number, unique_code, is_active) VALUES
('160525737019', 'fit', true),
('160525737033', 'fit', true),
('160525737037', 'fit', true),
('160525737039', 'fit', true),
('160525737041', 'fit', true),
('160525737042', 'fit', true),
('160525737045', 'fit', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

SELECT COUNT(*) as total_fit_students FROM fit_students;
SELECT 'FIT tables created successfully! 7 students added with code fit.' as status;
