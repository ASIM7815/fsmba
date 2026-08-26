-- ============================================
-- CIVIL ENGINEERING STUDENTS TABLE
-- ============================================
-- Create table for Civil Engineering students
CREATE TABLE IF NOT EXISTS civil_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL DEFAULT 'fscivil',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insert 28 Civil Engineering students (160525732001 to 160525732028)
INSERT INTO civil_students (roll_number, unique_code) VALUES
('160525732001', 'fscivil'),
('160525732002', 'fscivil'),
('160525732003', 'fscivil'),
('160525732004', 'fscivil'),
('160525732005', 'fscivil'),
('160525732006', 'fscivil'),
('160525732007', 'fscivil'),
('160525732008', 'fscivil'),
('160525732009', 'fscivil'),
('160525732010', 'fscivil'),
('160525732011', 'fscivil'),
('160525732012', 'fscivil'),
('160525732013', 'fscivil'),
('160525732014', 'fscivil'),
('160525732015', 'fscivil'),
('160525732016', 'fscivil'),
('160525732017', 'fscivil'),
('160525732018', 'fscivil'),
('160525732019', 'fscivil'),
('160525732020', 'fscivil'),
('160525732021', 'fscivil'),
('160525732022', 'fscivil'),
('160525732023', 'fscivil'),
('160525732024', 'fscivil'),
('160525732025', 'fscivil'),
('160525732026', 'fscivil'),
('160525732027', 'fscivil'),
('160525732028', 'fscivil')
ON CONFLICT (roll_number) DO NOTHING;

-- ============================================
-- CIVIL EXAM RESULTS TABLE
-- ============================================
-- Create table for Civil exam results
CREATE TABLE IF NOT EXISTS civil_exam_results (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT NOT NULL,
    score INTEGER NOT NULL,
    total_questions INTEGER DEFAULT 20,
    correct_answers INTEGER NOT NULL,
    wrong_answers INTEGER NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    submitted_at TIMESTAMPTZ DEFAULT NOW(),
    time_taken INTEGER, -- Time taken in seconds
    violation_detected BOOLEAN DEFAULT FALSE,
    violation_type TEXT,
    additional_data JSONB,
    CONSTRAINT fk_civil_student 
        FOREIGN KEY (roll_number) 
        REFERENCES civil_students(roll_number)
        ON DELETE CASCADE
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_civil_exam_results_roll_number 
    ON civil_exam_results(roll_number);

CREATE INDEX IF NOT EXISTS idx_civil_exam_results_submitted_at 
    ON civil_exam_results(submitted_at);

-- ============================================
-- VERIFICATION QUERIES
-- ============================================
-- Check Civil students count
SELECT COUNT(*) as total_civil_students FROM civil_students;

-- View all Civil students
SELECT * FROM civil_students ORDER BY roll_number;

-- Check Civil results table structure
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'civil_exam_results';

-- ============================================
-- SUCCESS MESSAGE
-- ============================================
SELECT 
    '✅ Civil Engineering tables created successfully!' as status,
    '28 students added (160525732001-160525732028)' as students,
    'Unique code: fscivil' as code,
    'Results table: civil_exam_results' as results_table;
