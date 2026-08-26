-- =====================================================
-- FIX: Add is_active column to civil_students table
-- =====================================================
-- This file adds the missing is_active column
-- and sets all existing students to active (true)
-- =====================================================

-- Add is_active column if it doesn't exist
ALTER TABLE civil_students 
ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT true;

-- Set all existing students to active
UPDATE civil_students 
SET is_active = true 
WHERE is_active IS NULL;

-- Verify the update
SELECT roll_number, unique_code, student_name, is_active, created_at 
FROM civil_students 
ORDER BY roll_number;

-- =====================================================
-- SUCCESS MESSAGE
-- =====================================================
-- If you see this, the is_active column was added!
-- 
-- All 28 civil students now have is_active = true
-- 
-- Next: Test login with roll 160525732001, code fscivil
-- =====================================================
