-- ============================================
-- FIX CIVIL_EXAM_RESULTS TABLE - ADD MISSING COLUMNS
-- ============================================
-- Add user_answers column that was missing from the original schema

-- Add user_answers column (stores student's selected answers)
ALTER TABLE civil_exam_results 
ADD COLUMN IF NOT EXISTS user_answers JSONB;

-- Add score column if missing
ALTER TABLE civil_exam_results 
ADD COLUMN IF NOT EXISTS score INTEGER;

-- Verify the columns exist
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'civil_exam_results'
ORDER BY ordinal_position;

-- Show sample structure
SELECT 
    'civil_exam_results table updated successfully!' as status,
    COUNT(*) FILTER (WHERE column_name = 'user_answers') as has_user_answers,
    COUNT(*) FILTER (WHERE column_name = 'score') as has_score,
    COUNT(*) FILTER (WHERE column_name = 'additional_data') as has_additional_data
FROM information_schema.columns 
WHERE table_name = 'civil_exam_results';
