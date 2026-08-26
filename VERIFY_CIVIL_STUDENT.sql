-- ============================================
-- VERIFY CIVIL STUDENT EXISTS
-- ============================================

-- Check if student 160525732001 exists with correct code
SELECT * FROM civil_students 
WHERE roll_number = '160525732001' 
AND unique_code = 'fscivil';

-- Check if is_active column exists and is TRUE
SELECT 
    roll_number,
    unique_code,
    is_active,
    created_at
FROM civil_students 
WHERE roll_number = '160525732001';

-- Count all civil students
SELECT 
    COUNT(*) as total_students,
    COUNT(*) FILTER (WHERE is_active = TRUE) as active_students,
    COUNT(*) FILTER (WHERE unique_code = 'fscivil') as correct_code
FROM civil_students;

-- Show first 5 students to verify structure
SELECT * FROM civil_students ORDER BY roll_number LIMIT 5;
