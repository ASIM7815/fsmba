-- ============================================
-- FIX CIVIL STUDENTS TABLE - ADD is_active COLUMN
-- ============================================
-- Add missing is_active column to civil_students table

-- Add is_active column with default value TRUE
ALTER TABLE civil_students 
ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;

-- Update all existing records to set is_active = TRUE
UPDATE civil_students 
SET is_active = TRUE 
WHERE is_active IS NULL;

-- Verify the update
SELECT 
    'Column added successfully!' as status,
    COUNT(*) as total_students,
    COUNT(*) FILTER (WHERE is_active = TRUE) as active_students
FROM civil_students;

-- View sample records to confirm
SELECT * FROM civil_students ORDER BY roll_number LIMIT 5;
