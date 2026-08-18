-- SQL to add Stock Market exam student to the students table
-- Roll Number: 160525672093
-- Unique Code: fsmba100
-- Run this in Supabase SQL Editor

-- Insert the stock market student into students table
INSERT INTO students (roll_number, unique_code, is_active) 
VALUES ('160525672093', 'fsmba100', true)
ON CONFLICT (roll_number) 
DO UPDATE SET 
    unique_code = EXCLUDED.unique_code,
    is_active = EXCLUDED.is_active;

-- Verify the student was added
SELECT 
    roll_number, 
    unique_code, 
    is_active, 
    created_at 
FROM students 
WHERE roll_number = '160525672093';

-- Success message
SELECT 'Stock market student 160525672093 added successfully with code fsmba100!' as status;
