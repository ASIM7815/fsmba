-- SQL to add new students to the existing students table
-- Run this in your Supabase SQL Editor
-- This will add 13 additional students (some may already exist)

-- Insert new authorized students
-- Using ON CONFLICT to avoid duplicate entry errors if roll number already exists
INSERT INTO students (roll_number, unique_code, is_active) VALUES
('160525672116', 'fsmba2026', true), -- May already exist
('160525672033', 'fsmba2026', true),
('160525672018', 'fsmba2026', true),
('160525672068', 'fsmba2026', true),
('160525672055', 'fsmba2026', true),
('160525672002', 'fsmba2026', true),
('160525672026', 'fsmba2026', true),
('160525672041', 'fsmba2026', true),
('160525672163', 'fsmba2026', true),
('160525672219', 'fsmba2026', true),
('160525672140', 'fsmba2026', true),
('160525672110', 'fsmba2026', true),
('160525672207', 'fsmba2026', true)
ON CONFLICT (roll_number) DO UPDATE 
SET 
    unique_code = EXCLUDED.unique_code,
    is_active = EXCLUDED.is_active;

-- Verify all students are now in the table
-- You should see 31 total students (19 original + 12 new, as one is duplicate)
SELECT 
    COUNT(*) as total_students,
    COUNT(CASE WHEN is_active = true THEN 1 END) as active_students
FROM students;

-- Display all students sorted by roll number
SELECT roll_number, unique_code, is_active, created_at 
FROM students 
ORDER BY roll_number;
