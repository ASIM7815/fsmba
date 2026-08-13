-- SQL to create the students table in Supabase
-- This table stores authorized students who can take the exam
-- Run this in your Supabase SQL Editor

CREATE TABLE IF NOT EXISTS students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_students_roll_number ON students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select" ON students
    FOR SELECT
    USING (true);

-- Insert the authorized students
INSERT INTO students (roll_number, unique_code, is_active) VALUES
('160525672063', 'fsmba2026', true),
('160525672066', 'fsmba2026', true),
('160525672080', 'fsmba2026', true),
('160525672104', 'fsmba2026', true),
('160525672116', 'fsmba2026', true),
('160525672125', 'fsmba2026', true),
('160525672133', 'fsmba2026', true),
('160525672143', 'fsmba2026', true),
('160525672154', 'fsmba2026', true),
('160525672174', 'fsmba2026', true),
('160525672176', 'fsmba2026', true),
('160525672178', 'fsmba2026', true),
('160525672179', 'fsmba2026', true),
('160525672181', 'fsmba2026', true),
('160525672184', 'fsmba2026', true),
('160525672186', 'fsmba2026', true),
('160525672191', 'fsmba2026', true),
('160525672218', 'fsmba2026', true),
('160525672227', 'fsmba2026', true)
ON CONFLICT (roll_number) DO NOTHING;

-- Verify the data was inserted
SELECT * FROM students ORDER BY roll_number;
