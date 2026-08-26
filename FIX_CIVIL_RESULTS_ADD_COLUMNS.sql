-- =====================================================
-- FIX: Add missing columns to civil_exam_results table
-- =====================================================
-- This adds the required columns that the code expects:
-- - user_answers (JSONB) - stores student's answer choices
-- - violation_detected (BOOLEAN) - tracks if violations occurred
-- - violation_type (TEXT) - type of violation if any
-- =====================================================

-- Add user_answers column (JSONB to store answer data)
ALTER TABLE civil_exam_results 
ADD COLUMN IF NOT EXISTS user_answers JSONB;

-- Add violation_detected column (BOOLEAN)
ALTER TABLE civil_exam_results 
ADD COLUMN IF NOT EXISTS violation_detected BOOLEAN DEFAULT false;

-- Add violation_type column (TEXT)
ALTER TABLE civil_exam_results 
ADD COLUMN IF NOT EXISTS violation_type TEXT;

-- Verify the columns were added
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'civil_exam_results'
ORDER BY ordinal_position;

-- =====================================================
-- SUCCESS MESSAGE
-- =====================================================
-- If you see this, all required columns were added!
-- 
-- civil_exam_results now has:
-- - id, roll_number, unique_code
-- - score, total_questions, correct_answers, wrong_answers
-- - percentage, time_taken
-- - user_answers (JSONB)
-- - violation_detected (BOOLEAN)
-- - violation_type (TEXT)
-- - additional_data (JSONB)
-- - submitted_at (TIMESTAMP)
-- 
-- Next: Test exam submission with roll 160525732001
-- Results should now save successfully!
-- =====================================================
