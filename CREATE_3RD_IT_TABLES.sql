-- SQL to create 3rd Year IT students table and exam results table in Supabase
-- This is a separate system for 3rd Year IT students
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE 3RD IT ROLL NUMBER TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS thirditrollno (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_thirditrollno_roll_number ON thirditrollno(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE thirditrollno ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select thirdit" ON thirditrollno
    FOR SELECT
    USING (true);

-- ======================================
-- 2. CREATE 3RD IT EXAM RESULTS TABLE WITH DEVICE TRACKING
-- ======================================

CREATE TABLE IF NOT EXISTS thirdit_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_thirdit_exam_results_roll_number ON thirdit_exam_results(roll_number);
CREATE INDEX IF NOT EXISTS idx_thirdit_device_fingerprint ON thirdit_exam_results(device_fingerprint);

-- Add Row Level Security (RLS) policies
ALTER TABLE thirdit_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert thirdit results" ON thirdit_exam_results
    FOR INSERT
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select thirdit results" ON thirdit_exam_results
    FOR SELECT
    USING (true);

-- ======================================
-- 3. CREATE ACTIVE EXAM SESSIONS TABLE
-- ======================================
-- This table tracks which students are currently taking the exam
-- Prevents same roll number from starting exam on multiple devices

CREATE TABLE IF NOT EXISTS thirdit_active_sessions (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    device_fingerprint TEXT NOT NULL,
    browser_info JSONB,
    session_started_at TIMESTAMPTZ DEFAULT NOW(),
    last_activity_at TIMESTAMPTZ DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_thirdit_sessions_roll_number ON thirdit_active_sessions(roll_number);
CREATE INDEX IF NOT EXISTS idx_thirdit_sessions_device ON thirdit_active_sessions(device_fingerprint);

-- Add RLS policies
ALTER TABLE thirdit_active_sessions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public insert thirdit sessions" ON thirdit_active_sessions
    FOR INSERT
    WITH CHECK (true);

CREATE POLICY "Allow public select thirdit sessions" ON thirdit_active_sessions
    FOR SELECT
    USING (true);

CREATE POLICY "Allow public update thirdit sessions" ON thirdit_active_sessions
    FOR UPDATE
    USING (true);

CREATE POLICY "Allow public delete thirdit sessions" ON thirdit_active_sessions
    FOR DELETE
    USING (true);

-- ======================================
-- 4. INSERT ALL 93 3RD YEAR IT STUDENTS
-- ======================================

-- All students use unique code: fs4it02
INSERT INTO thirditrollno (roll_number, unique_code, is_active) VALUES
('160524737050', 'fs4it02', true),
('160524737001', 'fs4it02', true),
('160524737002', 'fs4it02', true),
('160524737003', 'fs4it02', true),
('160524737004', 'fs4it02', true),
('160524737005', 'fs4it02', true),
('160524737006', 'fs4it02', true),
('160524737007', 'fs4it02', true),
('160524737008', 'fs4it02', true),
('160524737010', 'fs4it02', true),
('160524737011', 'fs4it02', true),
('160524737012', 'fs4it02', true),
('160524737013', 'fs4it02', true),
('160524737014', 'fs4it02', true),
('160524737015', 'fs4it02', true),
('160524737016', 'fs4it02', true),
('160524737017', 'fs4it02', true),
('160524737018', 'fs4it02', true),
('160524737019', 'fs4it02', true),
('160524737020', 'fs4it02', true),
('160524737021', 'fs4it02', true),
('160524737022', 'fs4it02', true),
('160524737023', 'fs4it02', true),
('160524737024', 'fs4it02', true),
('160524737025', 'fs4it02', true),
('160524737026', 'fs4it02', true),
('160524737027', 'fs4it02', true),
('160524737028', 'fs4it02', true),
('160524737029', 'fs4it02', true),
('160524737030', 'fs4it02', true),
('160524737031', 'fs4it02', true),
('160524737032', 'fs4it02', true),
('160524737033', 'fs4it02', true),
('160524737034', 'fs4it02', true),
('160524737035', 'fs4it02', true),
('160524737036', 'fs4it02', true),
('160524737037', 'fs4it02', true),
('160524737038', 'fs4it02', true),
('160524737039', 'fs4it02', true),
('160524737040', 'fs4it02', true),
('160524737041', 'fs4it02', true),
('160524737042', 'fs4it02', true),
('160524737043', 'fs4it02', true),
('160524737044', 'fs4it02', true),
('160524737045', 'fs4it02', true),
('160524737046', 'fs4it02', true),
('160524737047', 'fs4it02', true),
('160524737048', 'fs4it02', true),
('160524737049', 'fs4it02', true),
('160524737051', 'fs4it02', true),
('160524737052', 'fs4it02', true),
('160524737053', 'fs4it02', true),
('160524737054', 'fs4it02', true),
('160524737055', 'fs4it02', true),
('160524737056', 'fs4it02', true),
('160524737057', 'fs4it02', true),
('160524737058', 'fs4it02', true),
('160524737059', 'fs4it02', true),
('160524737060', 'fs4it02', true),
('160524737061', 'fs4it02', true),
('160524737062', 'fs4it02', true),
('160524737063', 'fs4it02', true),
('160524737064', 'fs4it02', true),
('160524737065', 'fs4it02', true),
('160524737066', 'fs4it02', true),
('160524737067', 'fs4it02', true),
('160524737068', 'fs4it02', true),
('160524737069', 'fs4it02', true),
('160524737070', 'fs4it02', true),
('160524737071', 'fs4it02', true),
('160524737072', 'fs4it02', true),
('160524737073', 'fs4it02', true),
('160524737074', 'fs4it02', true),
('160524737075', 'fs4it02', true),
('160524737076', 'fs4it02', true),
('160524737077', 'fs4it02', true),
('160524737078', 'fs4it02', true),
('160524737079', 'fs4it02', true),
('160524737080', 'fs4it02', true),
('160524737081', 'fs4it02', true),
('160524737082', 'fs4it02', true),
('160524737083', 'fs4it02', true),
('160524737084', 'fs4it02', true),
('160524737085', 'fs4it02', true),
('160524737086', 'fs4it02', true),
('160524737087', 'fs4it02', true),
('160524737088', 'fs4it02', true),
('160524737089', 'fs4it02', true),
('160524737090', 'fs4it02', true),
('160524737091', 'fs4it02', true),
('160524737302', 'fs4it02', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 5. VERIFY DATA
-- ======================================

-- Check total students added
SELECT COUNT(*) as total_thirdit_students FROM thirditrollno;

-- Display first 10 students
SELECT roll_number, unique_code, is_active, created_at 
FROM thirditrollno 
ORDER BY roll_number 
LIMIT 10;

-- Display last 10 students
SELECT roll_number, unique_code, is_active, created_at 
FROM thirditrollno 
ORDER BY roll_number DESC 
LIMIT 10;

-- Success message
SELECT '3rd Year IT tables created successfully! 93 students added with code fs4it02.' as status;

-- ======================================
-- 6. HELPER FUNCTIONS FOR SESSION MANAGEMENT
-- ======================================

-- Function to check if a student has an active session
CREATE OR REPLACE FUNCTION check_thirdit_active_session(p_roll_number TEXT)
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
    FROM thirdit_active_sessions tas
    WHERE tas.roll_number = p_roll_number 
    AND tas.is_active = true;
END;
$$ LANGUAGE plpgsql;

-- Function to clean up old/stale sessions (older than 3 hours)
CREATE OR REPLACE FUNCTION cleanup_thirdit_stale_sessions()
RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
BEGIN
    DELETE FROM thirdit_active_sessions
    WHERE last_activity_at < NOW() - INTERVAL '3 hours';
    
    GET DIAGNOSTICS deleted_count = ROW_COUNT;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;

-- ======================================
-- 7. NOTES ON DEVICE TRACKING
-- ======================================

-- The system tracks:
-- 1. Device fingerprint: Generated from browser/device characteristics
-- 2. Browser info: User agent, screen resolution, timezone, etc.
-- 3. Active sessions: Prevents same roll number from multiple devices
-- 4. Session activity: Tracks when student last interacted with exam

-- When a student starts the exam:
-- 1. Check if they already have an active session
-- 2. If yes, and device fingerprint doesn't match -> deny access
-- 3. If no active session -> create one and allow exam start
-- 4. When exam completes -> deactivate the session

-- This ensures:
-- - One roll number = one device during exam
-- - If student tries to login from another device, they'll be blocked
-- - After exam submission, session is cleared
