-- SQL to create FFAIDS students table and exam results table in Supabase
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE FFAIDS STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS ffaids_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_ffaids_students_roll_number ON ffaids_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE ffaids_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select ffaids" ON ffaids_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 2. CREATE FFAIDS EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS ffaids_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_ffaids_exam_results_roll_number ON ffaids_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE ffaids_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert ffaids results" ON ffaids_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select ffaids results" ON ffaids_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 3. INSERT FFAIDS STUDENTS (9 students)
-- ======================================

-- All students use unique code: ffaids
INSERT INTO ffaids_students (roll_number, unique_code, is_active) VALUES
('160524747039', 'ffaids', true),
('160524747041', 'ffaids', true),
('160524747072', 'ffaids', true),
('160524747100', 'ffaids', true),
('160524747111', 'ffaids', true),
('160524747112', 'ffaids', true),
('160524747113', 'ffaids', true),
('160524747118', 'ffaids', true),
('160524747119', 'ffaids', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

SELECT COUNT(*) as total_ffaids_students FROM ffaids_students;
SELECT 'FFAIDS tables created successfully! 9 students added with code ffaids.' as status;
