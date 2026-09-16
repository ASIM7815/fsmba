-- SQL to create FS1 AIDS students table and exam results table in Supabase
-- This is a separate system for FS1 AIDS students
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE FS1 AIDS STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS fs1aids_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_fs1aids_students_roll_number ON fs1aids_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE fs1aids_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select fs1aids" ON fs1aids_students
    FOR SELECT
    USING (true);

-- ======================================
-- 2. CREATE FS1 AIDS EXAM RESULTS TABLE WITH DEVICE TRACKING
-- ======================================

CREATE TABLE IF NOT EXISTS fs1aids_exam_results (
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
    device_fingerprint TEXT,
    browser_info JSONB,
    exam_started_at TIMESTAMPTZ DEFAULT NOW(),
    exam_completed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_fs1aids_exam_results_roll_number ON fs1aids_exam_results(roll_number);
CREATE INDEX IF NOT EXISTS idx_fs1aids_device_fingerprint ON fs1aids_exam_results(device_fingerprint);

-- Add Row Level Security (RLS) policies
ALTER TABLE fs1aids_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert fs1aids results" ON fs1aids_exam_results
    FOR INSERT
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select fs1aids results" ON fs1aids_exam_results
    FOR SELECT
    USING (true);

-- ======================================
-- 3. CREATE ACTIVE EXAM SESSIONS TABLE
-- ======================================
-- This table tracks which students are currently taking the exam
-- Prevents same roll number from starting exam on multiple devices

CREATE TABLE IF NOT EXISTS fs1aids_active_sessions (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    device_fingerprint TEXT NOT NULL,
    browser_info JSONB,
    session_started_at TIMESTAMPTZ DEFAULT NOW(),
    last_activity_at TIMESTAMPTZ DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_fs1aids_sessions_roll_number ON fs1aids_active_sessions(roll_number);
CREATE INDEX IF NOT EXISTS idx_fs1aids_sessions_device ON fs1aids_active_sessions(device_fingerprint);

-- Add RLS policies
ALTER TABLE fs1aids_active_sessions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public insert fs1aids sessions" ON fs1aids_active_sessions
    FOR INSERT
    WITH CHECK (true);

CREATE POLICY "Allow public select fs1aids sessions" ON fs1aids_active_sessions
    FOR SELECT
    USING (true);

CREATE POLICY "Allow public update fs1aids sessions" ON fs1aids_active_sessions
    FOR UPDATE
    USING (true);

CREATE POLICY "Allow public delete fs1aids sessions" ON fs1aids_active_sessions
    FOR DELETE
    USING (true);

-- ======================================
-- 4. INSERT ALL 16 FS1 AIDS STUDENTS
-- ======================================

-- All students use unique code: fs1aids
INSERT INTO fs1aids_students (roll_number, unique_code, is_active) VALUES
('160524735007', 'fs1aids', true),
('160525747011', 'fs1aids', true),
('160525747026', 'fs1aids', true),
('160525747027', 'fs1aids', true),
('160525747036', 'fs1aids', true),
('160525747046', 'fs1aids', true),
('160525747055', 'fs1aids', true),
('160525747065', 'fs1aids', true),
('160525747066', 'fs1aids', true),
('160525747067', 'fs1aids', true),
('160525747072', 'fs1aids', true),
('160525747073', 'fs1aids', true),
('160525747078', 'fs1aids', true),
('160525747088', 'fs1aids', true),
('160525747089', 'fs1aids', true),
('160525747094', 'fs1aids', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 5. VERIFY DATA
-- ======================================

-- Check total students added
SELECT COUNT(*) as total_fs1aids_students FROM fs1aids_students;

-- Display all students
SELECT roll_number, unique_code, is_active, created_at 
FROM fs1aids_students 
ORDER BY roll_number;

-- Success message
SELECT '✅ FS1 AIDS tables created successfully! 16 students added with code fs1aids.' as status;

-- ======================================
-- 6. HELPER FUNCTIONS FOR SESSION MANAGEMENT
-- ======================================

-- Function to check if a student has an active session
CREATE OR REPLACE FUNCTION check_fs1aids_active_session(p_roll_number TEXT)
RETURNS TABLE (
    has_active_session BOOLEAN,
    device_fingerprint TEXT,
    session_started_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COALESCE(COUNT(*) > 0, false) as has_active_session,
        MAX(tas.device_fingerprint) as device_fingerprint,
        MAX(tas.session_started_at) as session_started_at
    FROM fs1aids_active_sessions tas
    WHERE tas.roll_number = p_roll_number 
    AND tas.is_active = true;
END;
$$ LANGUAGE plpgsql;

-- Function to clean up old/stale sessions (older than 3 hours)
CREATE OR REPLACE FUNCTION cleanup_fs1aids_stale_sessions()
RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
BEGIN
    DELETE FROM fs1aids_active_sessions
    WHERE last_activity_at < NOW() - INTERVAL '3 hours';
    
    GET DIAGNOSTICS deleted_count = ROW_COUNT;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;
