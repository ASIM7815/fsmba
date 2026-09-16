-- Fix RLS Policies for F-prefixed tables
-- Run this in Supabase SQL Editor to ensure all policies are correct

-- ======================================
-- FCSE TABLES - Fix RLS Policies
-- ======================================

-- Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Allow public select fcse" ON fcse_students;
DROP POLICY IF EXISTS "Allow public insert fcse results" ON fcse_exam_results;
DROP POLICY IF EXISTS "Allow public select fcse results" ON fcse_exam_results;

-- Recreate policies with correct syntax
CREATE POLICY "Allow public select fcse" ON fcse_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

CREATE POLICY "Allow public insert fcse results" ON fcse_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

CREATE POLICY "Allow public select fcse results" ON fcse_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- FAIDS TABLES - Fix RLS Policies
-- ======================================

DROP POLICY IF EXISTS "Allow public select faids" ON faids_students;
DROP POLICY IF EXISTS "Allow public insert faids results" ON faids_exam_results;
DROP POLICY IF EXISTS "Allow public select faids results" ON faids_exam_results;

CREATE POLICY "Allow public select faids" ON faids_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

CREATE POLICY "Allow public insert faids results" ON faids_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

CREATE POLICY "Allow public select faids results" ON faids_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- FIT TABLES - Fix RLS Policies
-- ======================================

DROP POLICY IF EXISTS "Allow public select fit" ON fit_students;
DROP POLICY IF EXISTS "Allow public insert fit results" ON fit_exam_results;
DROP POLICY IF EXISTS "Allow public select fit results" ON fit_exam_results;

CREATE POLICY "Allow public select fit" ON fit_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

CREATE POLICY "Allow public insert fit results" ON fit_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

CREATE POLICY "Allow public select fit results" ON fit_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- FCIVIL TABLES - Fix RLS Policies
-- ======================================

DROP POLICY IF EXISTS "Allow public select fcivil" ON fcivil_students;
DROP POLICY IF EXISTS "Allow public insert fcivil results" ON fcivil_exam_results;
DROP POLICY IF EXISTS "Allow public select fcivil results" ON fcivil_exam_results;

CREATE POLICY "Allow public select fcivil" ON fcivil_students
    FOR SELECT
    TO anon, authenticated
    USING (true);

CREATE POLICY "Allow public insert fcivil results" ON fcivil_exam_results
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

CREATE POLICY "Allow public select fcivil results" ON fcivil_exam_results
    FOR SELECT
    TO anon, authenticated
    USING (true);

-- ======================================
-- VERIFY POLICIES
-- ======================================

SELECT 'All RLS policies fixed successfully!' as status;

-- Show all policies for verification
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies
WHERE tablename IN ('fcse_students', 'fcse_exam_results', 'faids_students', 'faids_exam_results', 
                    'fit_students', 'fit_exam_results', 'fcivil_students', 'fcivil_exam_results')
ORDER BY tablename, policyname;
