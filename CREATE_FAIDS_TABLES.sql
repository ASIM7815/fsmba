-- SQL to create FAIDS students table and exam results table in Supabase
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE FAIDS STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS faids_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_faids_students_roll_number ON faids_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE faids_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select faids" ON faids_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 2. CREATE FAIDS EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS faids_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_faids_exam_results_roll_number ON faids_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE faids_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert faids results" ON faids_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select faids results" ON faids_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- 3. INSERT FAIDS STUDENTS (16 students)
-- ======================================

-- All students use unique code: faids
INSERT INTO faids_students (roll_number, unique_code, is_active) VALUES
('160524735007', 'faids', true),
('160525747011', 'faids', true),
('160525747026', 'faids', true),
('160525747027', 'faids', true),
('160525747036', 'faids', true),
('160525747046', 'faids', true),
('160525747055', 'faids', true),
('160525747065', 'faids', true),
('160525747066', 'faids', true),
('160525747067', 'faids', true),
('160525747072', 'faids', true),
('160525747073', 'faids', true),
('160525747078', 'faids', true),
('160525747088', 'faids', true),
('160525747089', 'faids', true),
('160525747094', 'faids', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

SELECT COUNT(*) as total_faids_students FROM faids_students;
SELECT 'FAIDS tables created successfully! 16 students added with code faids.' as status;
