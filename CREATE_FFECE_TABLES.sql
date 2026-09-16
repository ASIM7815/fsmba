-- SQL to create FFECE students table and exam results table in Supabase
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE FFECE STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS ffece_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_ffece_students_roll_number ON ffece_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE ffece_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select ffece" ON ffece_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 2. CREATE FFECE EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS ffece_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_ffece_exam_results_roll_number ON ffece_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE ffece_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert ffece results" ON ffece_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select ffece results" ON ffece_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 3. INSERT FFECE STUDENTS (5 students)
-- ======================================

-- All students use unique code: ffece
INSERT INTO ffece_students (roll_number, unique_code, is_active) VALUES
('160524735001', 'ffece', true),
('160524735002', 'ffece', true),
('160524735003', 'ffece', true),
('160524735008', 'ffece', true),
('160524735009', 'ffece', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

SELECT COUNT(*) as total_ffece_students FROM ffece_students;
SELECT 'FFECE tables created successfully! 5 students added with code ffece.' as status;
