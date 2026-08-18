-- SQL Script to Update MBA Regular Student Unique Code
-- Changes code from fsmba1708 to fsmba1808
-- Run this in Supabase SQL Editor

-- Update all MBA Regular students to new unique code
UPDATE mba_regular_students 
SET unique_code = 'fsmba1808'
WHERE unique_code = 'fsmba1708';

-- Verify the update
SELECT 
    COUNT(*) as total_students,
    unique_code
FROM mba_regular_students
GROUP BY unique_code;

-- Display sample of updated students
SELECT 
    roll_number, 
    unique_code, 
    is_active, 
    created_at 
FROM mba_regular_students 
ORDER BY roll_number 
LIMIT 10;

-- Success message
SELECT 'MBA Regular student codes updated from fsmba1708 to fsmba1808 successfully!' as status;
