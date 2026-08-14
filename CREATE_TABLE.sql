-- SQL to create the exam_results table in Supabase
-- Run this in your Supabase SQL Editor

CREATE TABLE IF NOT EXISTS exam_results (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT NOT NULL,
    correct_answers INTEGER NOT NULL,
    wrong_answers INTEGER NOT NULL,
    total_questions INTEGER NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    score TEXT NOT NULL,
    user_answers JSONB,
    shuffled_questions JSONB,
    exam_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    exam_completed BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add violation tracking columns (run this if table already exists)
ALTER TABLE exam_results ADD COLUMN IF NOT EXISTS violation_type TEXT;
ALTER TABLE exam_results ADD COLUMN IF NOT EXISTS violation_detected BOOLEAN DEFAULT FALSE;

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_exam_results_roll_number ON exam_results(roll_number);

-- Create index on exam_date for faster date queries
CREATE INDEX IF NOT EXISTS idx_exam_results_exam_date ON exam_results(exam_date);

-- Create index on violations for monitoring
CREATE INDEX IF NOT EXISTS idx_exam_results_violations ON exam_results(violation_detected);

-- Add Row Level Security (RLS) policies
ALTER TABLE exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow anyone to insert (for exam submission)
CREATE POLICY "Allow public insert" ON exam_results
    FOR INSERT
    WITH CHECK (true);

-- Policy to allow anyone to select (for checking if exam was taken)
CREATE POLICY "Allow public select" ON exam_results
    FOR SELECT
    USING (true);

-- Optional: Add unique constraint to prevent duplicate submissions
-- Uncomment if you want to prevent the same roll number from submitting multiple times
-- ALTER TABLE exam_results ADD CONSTRAINT unique_roll_number UNIQUE (roll_number);
