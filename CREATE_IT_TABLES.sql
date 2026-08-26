-- SQL to create IT (Information Technology) students table and exam results table in Supabase
-- This is a separate system for IT students
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE IT STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS it_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_it_students_roll_number ON it_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE it_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select it" ON it_students
    FOR SELECT
    USING (true);

-- ======================================
-- 2. CREATE IT EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS it_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_it_exam_results_roll_number ON it_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE it_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert it results" ON it_exam_results
    FOR INSERT
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select it results" ON it_exam_results
    FOR SELECT
    USING (true);

-- ======================================
-- 3. INSERT ALL 46 IT STUDENTS
-- ======================================

-- All students use unique code: fsit
INSERT INTO it_students (roll_number, unique_code, is_active) VALUES
('160525737001', 'fsit', true),
('160525737002', 'fsit', true),
('160525737003', 'fsit', true),
('160525737004', 'fsit', true),
('160525737005', 'fsit', true),
('160525737006', 'fsit', true),
('160525737007', 'fsit', true),
('160525737008', 'fsit', true),
('160525737009', 'fsit', true),
('160525737010', 'fsit', true),
('160525737011', 'fsit', true),
('160525737012', 'fsit', true),
('160525737013', 'fsit', true),
('160525737014', 'fsit', true),
('160525737015', 'fsit', true),
('160525737016', 'fsit', true),
('160525737017', 'fsit', true),
('160525737018', 'fsit', true),
('160525737019', 'fsit', true),
('160525737020', 'fsit', true),
('160525737021', 'fsit', true),
('160525737022', 'fsit', true),
('160525737023', 'fsit', true),
('160525737024', 'fsit', true),
('160525737025', 'fsit', true),
('160525737026', 'fsit', true),
('160525737027', 'fsit', true),
('160525737028', 'fsit', true),
('160525737029', 'fsit', true),
('160525737030', 'fsit', true),
('160525737031', 'fsit', true),
('160525737032', 'fsit', true),
('160525737033', 'fsit', true),
('160525737034', 'fsit', true),
('160525737035', 'fsit', true),
('160525737036', 'fsit', true),
('160525737037', 'fsit', true),
('160525737038', 'fsit', true),
('160525737039', 'fsit', true),
('160525737040', 'fsit', true),
('160525737041', 'fsit', true),
('160525737042', 'fsit', true),
('160525737043', 'fsit', true),
('160525737044', 'fsit', true),
('160525737045', 'fsit', true),
('160525737046', 'fsit', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

-- Check total students added
SELECT COUNT(*) as total_it_students FROM it_students;

-- Display first 10 IT students
SELECT roll_number, unique_code, is_active, created_at 
FROM it_students 
ORDER BY roll_number
LIMIT 10;

-- Display last 10 IT students
SELECT roll_number, unique_code, is_active, created_at 
FROM it_students 
ORDER BY roll_number DESC
LIMIT 10;

-- Success message
SELECT 'IT (Information Technology) tables created successfully! 46 students added with code fsit.' as status;
