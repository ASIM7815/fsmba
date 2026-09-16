-- SQL to create FFIT students table and exam results table in Supabase
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE FFIT STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS ffit_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_ffit_students_roll_number ON ffit_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE ffit_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select ffit" ON ffit_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 2. CREATE FFIT EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS ffit_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_ffit_exam_results_roll_number ON ffit_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE ffit_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert ffit results" ON ffit_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select ffit results" ON ffit_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 3. INSERT FFIT STUDENTS (12 students)
-- ======================================

-- All students use unique code: ffit
INSERT INTO ffit_students (roll_number, unique_code, is_active) VALUES
('160524737013', 'ffit', true),
('160524737028', 'ffit', true),
('160524737032', 'ffit', true),
('160524737035', 'ffit', true),
('160524737053', 'ffit', true),
('160524737060', 'ffit', true),
('160524737071', 'ffit', true),
('160524737072', 'ffit', true),
('160524737082', 'ffit', true),
('160524737086', 'ffit', true),
('160524737089', 'ffit', true),
('160524737090', 'ffit', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

SELECT COUNT(*) as total_ffit_students FROM ffit_students;
SELECT 'FFIT tables created successfully! 12 students added with code ffit.' as status;
