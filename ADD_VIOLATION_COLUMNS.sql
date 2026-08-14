-- SQL to add violation tracking columns to existing exam_results table
-- Run this in your Supabase SQL Editor if you already created the table

-- Add violation tracking columns
ALTER TABLE exam_results ADD COLUMN IF NOT EXISTS violation_type TEXT;
ALTER TABLE exam_results ADD COLUMN IF NOT EXISTS violation_detected BOOLEAN DEFAULT FALSE;

-- Create index on violations for monitoring
CREATE INDEX IF NOT EXISTS idx_exam_results_violations ON exam_results(violation_detected);

-- Query to view violations
-- SELECT roll_number, score, percentage, violation_type, exam_date 
-- FROM exam_results 
-- WHERE violation_detected = TRUE 
-- ORDER BY exam_date DESC;
