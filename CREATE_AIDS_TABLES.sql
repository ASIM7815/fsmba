-- SQL to create AIDS (Artificial Intelligence and Data Science) students table and exam results table in Supabase
-- This is a separate system for AIDS students
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE AIDS STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS aids_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_aids_students_roll_number ON aids_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE aids_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select aids" ON aids_students
    FOR SELECT
    USING (true);

-- ======================================
-- 2. CREATE AIDS EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS aids_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_aids_exam_results_roll_number ON aids_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE aids_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert aids results" ON aids_exam_results
    FOR INSERT
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select aids results" ON aids_exam_results
    FOR SELECT
    USING (true);

-- ======================================
-- 3. INSERT ALL 96 AIDS STUDENTS
-- ======================================

-- All students use unique code: fsaids
INSERT INTO aids_students (roll_number, unique_code, is_active) VALUES
('160525747001', 'fsaids', true),
('160525747002', 'fsaids', true),
('160525747003', 'fsaids', true),
('160525747004', 'fsaids', true),
('160525747005', 'fsaids', true),
('160525747006', 'fsaids', true),
('160525747007', 'fsaids', true),
('160525747008', 'fsaids', true),
('160525747009', 'fsaids', true),
('160525747010', 'fsaids', true),
('160525747011', 'fsaids', true),
('160525747012', 'fsaids', true),
('160525747013', 'fsaids', true),
('160525747014', 'fsaids', true),
('160525747015', 'fsaids', true),
('160525747016', 'fsaids', true),
('160525747017', 'fsaids', true),
('160525747018', 'fsaids', true),
('160525747019', 'fsaids', true),
('160525747020', 'fsaids', true),
('160525747021', 'fsaids', true),
('160525747022', 'fsaids', true),
('160525747023', 'fsaids', true),
('160525747024', 'fsaids', true),
('160525747025', 'fsaids', true),
('160525747026', 'fsaids', true),
('160525747027', 'fsaids', true),
('160525747028', 'fsaids', true),
('160525747029', 'fsaids', true),
('160525747030', 'fsaids', true),
('160525747031', 'fsaids', true),
('160525747032', 'fsaids', true),
('160525747033', 'fsaids', true),
('160525747034', 'fsaids', true),
('160525747035', 'fsaids', true),
('160525747036', 'fsaids', true),
('160525747037', 'fsaids', true),
('160525747038', 'fsaids', true),
('160525747039', 'fsaids', true),
('160525747040', 'fsaids', true),
('160525747041', 'fsaids', true),
('160525747042', 'fsaids', true),
('160525747043', 'fsaids', true),
('160525747044', 'fsaids', true),
('160525747045', 'fsaids', true),
('160525747046', 'fsaids', true),
('160525747047', 'fsaids', true),
('160525747048', 'fsaids', true),
('160525747049', 'fsaids', true),
('160525747050', 'fsaids', true),
('160525747051', 'fsaids', true),
('160525747052', 'fsaids', true),
('160525747053', 'fsaids', true),
('160525747054', 'fsaids', true),
('160525747055', 'fsaids', true),
('160525747056', 'fsaids', true),
('160525747057', 'fsaids', true),
('160525747058', 'fsaids', true),
('160525747059', 'fsaids', true),
('160525747060', 'fsaids', true),
('160525747061', 'fsaids', true),
('160525747062', 'fsaids', true),
('160525747063', 'fsaids', true),
('160525747064', 'fsaids', true),
('160525747065', 'fsaids', true),
('160525747066', 'fsaids', true),
('160525747067', 'fsaids', true),
('160525747068', 'fsaids', true),
('160525747069', 'fsaids', true),
('160525747070', 'fsaids', true),
('160525747071', 'fsaids', true),
('160525747072', 'fsaids', true),
('160525747073', 'fsaids', true),
('160525747074', 'fsaids', true),
('160525747075', 'fsaids', true),
('160525747076', 'fsaids', true),
('160525747077', 'fsaids', true),
('160525747078', 'fsaids', true),
('160525747079', 'fsaids', true),
('160525747080', 'fsaids', true),
('160525747081', 'fsaids', true),
('160525747082', 'fsaids', true),
('160525747083', 'fsaids', true),
('160525747084', 'fsaids', true),
('160525747085', 'fsaids', true),
('160525747086', 'fsaids', true),
('160525747087', 'fsaids', true),
('160525747088', 'fsaids', true),
('160525747089', 'fsaids', true),
('160525747090', 'fsaids', true),
('160525747091', 'fsaids', true),
('160525747092', 'fsaids', true),
('160525747093', 'fsaids', true),
('160525747094', 'fsaids', true),
('160525747095', 'fsaids', true),
('160525747096', 'fsaids', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

-- Check total students added
SELECT COUNT(*) as total_aids_students FROM aids_students;

-- Display first 10 AIDS students
SELECT roll_number, unique_code, is_active, created_at 
FROM aids_students 
ORDER BY roll_number
LIMIT 10;

-- Display last 10 AIDS students
SELECT roll_number, unique_code, is_active, created_at 
FROM aids_students 
ORDER BY roll_number DESC
LIMIT 10;

-- Success message
SELECT 'AIDS (Artificial Intelligence and Data Science) tables created successfully! 96 students added with code fsaids.' as status;
