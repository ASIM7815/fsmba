-- Fix RLS Policies for All New Tables
-- Run this in Supabase SQL Editor to allow anonymous access
-- This ensures all tables can be accessed without authentication errors

-- ======================================
-- 3RD IT TABLES - RLS POLICIES
-- ======================================

-- thirditrollno table
ALTER TABLE thirditrollno ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public select thirdit" ON thirditrollno;
CREATE POLICY "Allow public select thirdit" ON thirditrollno
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- thirdit_exam_results table
ALTER TABLE thirdit_exam_results ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public insert thirdit results" ON thirdit_exam_results;
CREATE POLICY "Allow public insert thirdit results" ON thirdit_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public select thirdit results" ON thirdit_exam_results;
CREATE POLICY "Allow public select thirdit results" ON thirdit_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- thirdit_active_sessions table
ALTER TABLE thirdit_active_sessions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public insert thirdit sessions" ON thirdit_active_sessions;
CREATE POLICY "Allow public insert thirdit sessions" ON thirdit_active_sessions
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public select thirdit sessions" ON thirdit_active_sessions;
CREATE POLICY "Allow public select thirdit sessions" ON thirdit_active_sessions
    FOR SELECT
    TO anon, authenticated
    USING (true);

DROP POLICY IF EXISTS "Allow public update thirdit sessions" ON thirdit_active_sessions;
CREATE POLICY "Allow public update thirdit sessions" ON thirdit_active_sessions
    FOR UPDATE
    TO anon, authenticated
    USING (true);

DROP POLICY IF EXISTS "Allow public delete thirdit sessions" ON thirdit_active_sessions;
CREATE POLICY "Allow public delete thirdit sessions" ON thirdit_active_sessions
    FOR DELETE
    TO anon, authenticated
    USING (true);

-- ======================================
-- FS1 CSE TABLES - RLS POLICIES
-- ======================================

-- fs1cse_students table
ALTER TABLE fs1cse_students ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public select fs1cse" ON fs1cse_students;
CREATE POLICY "Allow public select fs1cse" ON fs1cse_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- fs1cse_exam_results table
ALTER TABLE fs1cse_exam_results ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public insert fs1cse results" ON fs1cse_exam_results;
CREATE POLICY "Allow public insert fs1cse results" ON fs1cse_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public select fs1cse results" ON fs1cse_exam_results;
CREATE POLICY "Allow public select fs1cse results" ON fs1cse_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- fs1cse_active_sessions table
ALTER TABLE fs1cse_active_sessions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public insert fs1cse sessions" ON fs1cse_active_sessions;
CREATE POLICY "Allow public insert fs1cse sessions" ON fs1cse_active_sessions
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public select fs1cse sessions" ON fs1cse_active_sessions;
CREATE POLICY "Allow public select fs1cse sessions" ON fs1cse_active_sessions
    FOR SELECT
    TO anon, authenticated
    USING (true);

DROP POLICY IF EXISTS "Allow public update fs1cse sessions" ON fs1cse_active_sessions;
CREATE POLICY "Allow public update fs1cse sessions" ON fs1cse_active_sessions
    FOR UPDATE
    TO anon, authenticated
    USING (true);

DROP POLICY IF EXISTS "Allow public delete fs1cse sessions" ON fs1cse_active_sessions;
CREATE POLICY "Allow public delete fs1cse sessions" ON fs1cse_active_sessions
    FOR DELETE
    TO anon, authenticated
    USING (true);

-- ======================================
-- FS1 AIDS TABLES - RLS POLICIES
-- ======================================

-- fs1aids_students table
ALTER TABLE fs1aids_students ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public select fs1aids" ON fs1aids_students;
CREATE POLICY "Allow public select fs1aids" ON fs1aids_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- fs1aids_exam_results table
ALTER TABLE fs1aids_exam_results ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public insert fs1aids results" ON fs1aids_exam_results;
CREATE POLICY "Allow public insert fs1aids results" ON fs1aids_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public select fs1aids results" ON fs1aids_exam_results;
CREATE POLICY "Allow public select fs1aids results" ON fs1aids_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- fs1aids_active_sessions table
ALTER TABLE fs1aids_active_sessions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public insert fs1aids sessions" ON fs1aids_active_sessions;
CREATE POLICY "Allow public insert fs1aids sessions" ON fs1aids_active_sessions
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public select fs1aids sessions" ON fs1aids_active_sessions;
CREATE POLICY "Allow public select fs1aids sessions" ON fs1aids_active_sessions
    FOR SELECT
    TO anon, authenticated
    USING (true);

DROP POLICY IF EXISTS "Allow public update fs1aids sessions" ON fs1aids_active_sessions;
CREATE POLICY "Allow public update fs1aids sessions" ON fs1aids_active_sessions
    FOR UPDATE
    TO anon, authenticated
    USING (true);

DROP POLICY IF EXISTS "Allow public delete fs1aids sessions" ON fs1aids_active_sessions;
CREATE POLICY "Allow public delete fs1aids sessions" ON fs1aids_active_sessions
    FOR DELETE
    TO anon, authenticated
    USING (true);

-- ======================================
-- FS1 IT TABLES - RLS POLICIES
-- ======================================

-- fs1it_students table
ALTER TABLE fs1it_students ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public select fs1it" ON fs1it_students;
CREATE POLICY "Allow public select fs1it" ON fs1it_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- fs1it_exam_results table
ALTER TABLE fs1it_exam_results ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public insert fs1it results" ON fs1it_exam_results;
CREATE POLICY "Allow public insert fs1it results" ON fs1it_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public select fs1it results" ON fs1it_exam_results;
CREATE POLICY "Allow public select fs1it results" ON fs1it_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- fs1it_active_sessions table
ALTER TABLE fs1it_active_sessions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public insert fs1it sessions" ON fs1it_active_sessions;
CREATE POLICY "Allow public insert fs1it sessions" ON fs1it_active_sessions
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public select fs1it sessions" ON fs1it_active_sessions;
CREATE POLICY "Allow public select fs1it sessions" ON fs1it_active_sessions
    FOR SELECT
    TO anon, authenticated
    USING (true);

DROP POLICY IF EXISTS "Allow public update fs1it sessions" ON fs1it_active_sessions;
CREATE POLICY "Allow public update fs1it sessions" ON fs1it_active_sessions
    FOR UPDATE
    TO anon, authenticated
    USING (true);

DROP POLICY IF EXISTS "Allow public delete fs1it sessions" ON fs1it_active_sessions;
CREATE POLICY "Allow public delete fs1it sessions" ON fs1it_active_sessions
    FOR DELETE
    TO anon, authenticated
    USING (true);

-- ======================================
-- FS1 CIVIL TABLES - RLS POLICIES
-- ======================================

-- fs1civil_students table
ALTER TABLE fs1civil_students ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public select fs1civil" ON fs1civil_students;
CREATE POLICY "Allow public select fs1civil" ON fs1civil_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- fs1civil_exam_results table
ALTER TABLE fs1civil_exam_results ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public insert fs1civil results" ON fs1civil_exam_results;
CREATE POLICY "Allow public insert fs1civil results" ON fs1civil_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public select fs1civil results" ON fs1civil_exam_results;
CREATE POLICY "Allow public select fs1civil results" ON fs1civil_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- fs1civil_active_sessions table
ALTER TABLE fs1civil_active_sessions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public insert fs1civil sessions" ON fs1civil_active_sessions;
CREATE POLICY "Allow public insert fs1civil sessions" ON fs1civil_active_sessions
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public select fs1civil sessions" ON fs1civil_active_sessions;
CREATE POLICY "Allow public select fs1civil sessions" ON fs1civil_active_sessions
    FOR SELECT
    TO anon, authenticated
    USING (true);

DROP POLICY IF EXISTS "Allow public update fs1civil sessions" ON fs1civil_active_sessions;
CREATE POLICY "Allow public update fs1civil sessions" ON fs1civil_active_sessions
    FOR UPDATE
    TO anon, authenticated
    USING (true);

DROP POLICY IF EXISTS "Allow public delete fs1civil sessions" ON fs1civil_active_sessions;
CREATE POLICY "Allow public delete fs1civil sessions" ON fs1civil_active_sessions
    FOR DELETE
    TO anon, authenticated
    USING (true);

-- ======================================
-- VERIFICATION
-- ======================================

SELECT 'All RLS policies updated successfully! All tables now allow anonymous access.' as status;

-- Verify policies exist
SELECT schemaname, tablename, policyname, roles, cmd
FROM pg_policies
WHERE tablename IN (
    'thirditrollno', 'thirdit_exam_results', 'thirdit_active_sessions',
    'fs1cse_students', 'fs1cse_exam_results', 'fs1cse_active_sessions',
    'fs1aids_students', 'fs1aids_exam_results', 'fs1aids_active_sessions',
    'fs1it_students', 'fs1it_exam_results', 'fs1it_active_sessions',
    'fs1civil_students', 'fs1civil_exam_results', 'fs1civil_active_sessions'
)
ORDER BY tablename, policyname;
