-- SQL to create FFCSE students table and exam results table in Supabase
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE FFCSE STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS ffcse_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_ffcse_students_roll_number ON ffcse_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE ffcse_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select ffcse" ON ffcse_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 2. CREATE FFCSE EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS ffcse_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_ffcse_exam_results_roll_number ON ffcse_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE ffcse_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert ffcse results" ON ffcse_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select ffcse results" ON ffcse_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 3. INSERT FFCSE STUDENTS (10 students)
-- ======================================

-- All students use unique code: ffcse
INSERT INTO ffcse_students (roll_number, unique_code, is_active) VALUES
('160524733047', 'ffcse', true),
('160524733048', 'ffcse', true),
('160524733059', 'ffcse', true),
('160524733061', 'ffcse', true),
('160524733069', 'ffcse', true),
('160524733087', 'ffcse', true),
('160524733141', 'ffcse', true),
('160524733147', 'ffcse', true),
('160524733204', 'ffcse', true),
('160524733238', 'ffcse', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

SELECT COUNT(*) as total_ffcse_students FROM ffcse_students;
SELECT 'FFCSE tables created successfully! 10 students added with code ffcse.' as status;
