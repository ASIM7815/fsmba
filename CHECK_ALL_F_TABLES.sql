-- Check if all F-prefixed and FF-prefixed tables exist with proper RLS policies
-- Run this in Supabase SQL Editor to diagnose issues

-- ======================================
-- CHECK IF TABLES EXIST
-- ======================================

SELECT 'Checking if tables exist...' as status;

SELECT 
    schemaname,
    tablename,
    CASE 
        WHEN tablename IN ('fcse_students', 'fcse_exam_results', 
                          'faids_students', 'faids_exam_results',
                          'fit_students', 'fit_exam_results',
                          'fcivil_students', 'fcivil_exam_results',
                          'ffcse_students', 'ffcse_exam_results',
                          'ffit_students', 'ffit_exam_results',
                          'ffaids_students', 'ffaids_exam_results',
                          'ffece_students', 'ffece_exam_results') 
        THEN '✅ EXISTS'
        ELSE '❌ MISSING'
    END as status
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename IN (
    'fcse_students', 'fcse_exam_results',
    'faids_students', 'faids_exam_results',
    'fit_students', 'fit_exam_results',
    'fcivil_students', 'fcivil_exam_results',
    'ffcse_students', 'ffcse_exam_results',
    'ffit_students', 'ffit_exam_results',
    'ffaids_students', 'ffaids_exam_results',
    'ffece_students', 'ffece_exam_results'
)
ORDER BY tablename;

-- ======================================
-- CHECK RLS POLICIES
-- ======================================

SELECT 'Checking RLS policies...' as status;

SELECT 
    tablename,
    policyname,
    cmd,
    roles,
    CASE 
        WHEN 'anon' = ANY(roles) OR 'authenticated' = ANY(roles) 
        THEN '✅ HAS anon/authenticated'
        ELSE '❌ MISSING anon/authenticated'
    END as policy_status
FROM pg_policies
WHERE tablename IN (
    'fcse_students', 'fcse_exam_results',
    'faids_students', 'faids_exam_results',
    'fit_students', 'fit_exam_results',
    'fcivil_students', 'fcivil_exam_results',
    'ffcse_students', 'ffcse_exam_results',
    'ffit_students', 'ffit_exam_results',
    'ffaids_students', 'ffaids_exam_results',
    'ffece_students', 'ffece_exam_results'
)
ORDER BY tablename, cmd, policyname;

-- ======================================
-- CHECK STUDENT COUNTS
-- ======================================

SELECT 'Checking student counts...' as status;

DO $$
DECLARE
    fcse_count INT;
    faids_count INT;
    fit_count INT;
    fcivil_count INT;
    ffcse_count INT;
    ffit_count INT;
    ffaids_count INT;
    ffece_count INT;
BEGIN
    -- F-prefixed tables
    SELECT COUNT(*) INTO fcse_count FROM fcse_students;
    SELECT COUNT(*) INTO faids_count FROM faids_students;
    SELECT COUNT(*) INTO fit_count FROM fit_students;
    SELECT COUNT(*) INTO fcivil_count FROM fcivil_students;
    
    -- FF-prefixed tables
    SELECT COUNT(*) INTO ffcse_count FROM ffcse_students;
    SELECT COUNT(*) INTO ffit_count FROM ffit_students;
    SELECT COUNT(*) INTO ffaids_count FROM ffaids_students;
    SELECT COUNT(*) INTO ffece_count FROM ffece_students;
    
    RAISE NOTICE '✅ FCSE students: %', fcse_count;
    RAISE NOTICE '✅ FAIDS students: %', faids_count;
    RAISE NOTICE '✅ FIT students: %', fit_count;
    RAISE NOTICE '✅ FCIVIL students: %', fcivil_count;
    RAISE NOTICE '✅ FFCSE students: %', ffcse_count;
    RAISE NOTICE '✅ FFIT students: %', ffit_count;
    RAISE NOTICE '✅ FFAIDS students: %', ffaids_count;
    RAISE NOTICE '✅ FFECE students: %', ffece_count;
END $$;

-- ======================================
-- TEST SAMPLE QUERIES (what the app does)
-- ======================================

SELECT 'Testing sample queries...' as status;

-- Test FCSE login
SELECT 'Testing FCSE (code: fcse, roll: 160525733004)' as test;
SELECT * FROM fcse_students 
WHERE roll_number = '160525733004' 
  AND unique_code = 'fcse' 
  AND is_active = true;

-- Test FAIDS login
SELECT 'Testing FAIDS (code: faids, roll: 160525747011)' as test;
SELECT * FROM faids_students 
WHERE roll_number = '160525747011' 
  AND unique_code = 'faids' 
  AND is_active = true;

-- Test FIT login
SELECT 'Testing FIT (code: fit, roll: 160525737019)' as test;
SELECT * FROM fit_students 
WHERE roll_number = '160525737019' 
  AND unique_code = 'fit' 
  AND is_active = true;

-- Test FCIVIL login
SELECT 'Testing FCIVIL (code: fcivil, roll: 160525732010)' as test;
SELECT * FROM fcivil_students 
WHERE roll_number = '160525732010' 
  AND unique_code = 'fcivil' 
  AND is_active = true;

-- Test FFCSE login
SELECT 'Testing FFCSE (code: ffcse, roll: 160524733047)' as test;
SELECT * FROM ffcse_students 
WHERE roll_number = '160524733047' 
  AND unique_code = 'ffcse' 
  AND is_active = true;

-- Test FFIT login
SELECT 'Testing FFIT (code: ffit, roll: 160524737013)' as test;
SELECT * FROM ffit_students 
WHERE roll_number = '160524737013' 
  AND unique_code = 'ffit' 
  AND is_active = true;

-- Test FFAIDS login
SELECT 'Testing FFAIDS (code: ffaids, roll: 160524747039)' as test;
SELECT * FROM ffaids_students 
WHERE roll_number = '160524747039' 
  AND unique_code = 'ffaids' 
  AND is_active = true;

-- Test FFECE login
SELECT 'Testing FFECE (code: ffece, roll: 160524735001)' as test;
SELECT * FROM ffece_students 
WHERE roll_number = '160524735001' 
  AND unique_code = 'ffece' 
  AND is_active = true;

SELECT '✅ Diagnostic check complete!' as status;
