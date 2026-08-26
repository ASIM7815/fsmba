-- =====================================================
-- CIVIL ENGINEERING EXAM SYSTEM - TABLE CREATION
-- =====================================================
-- Creates tables for Civil Engineering students
-- 28 students (160525732001-160525732028)
-- Unique code: fscivil
-- Uses same questions as CSE (60 Git/Linux questions, 20 random)
-- =====================================================

-- 1. Create civil_students table
CREATE TABLE IF NOT EXISTS civil_students (
    id SERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    student_name TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Create civil_exam_results table
CREATE TABLE IF NOT EXISTS civil_exam_results (
    id SERIAL PRIMARY KEY,
    roll_number TEXT NOT NULL,
    unique_code TEXT NOT NULL,
    score INTEGER NOT NULL,
    total_questions INTEGER NOT NULL DEFAULT 20,
    correct_answers INTEGER NOT NULL,
    wrong_answers INTEGER NOT NULL,
    percentage NUMERIC(5,2) NOT NULL,
    time_taken INTEGER, -- in seconds
    user_answers JSONB, -- Student's answer selections
    violation_detected BOOLEAN DEFAULT false, -- Track if violations occurred
    violation_type TEXT, -- Type of violation (tab_switch, fullscreen_exit, etc.)
    additional_data JSONB, -- For storing exam metadata, etc.
    submitted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    FOREIGN KEY (roll_number) REFERENCES civil_students(roll_number)
);

-- 3. Insert 28 Civil Engineering students
INSERT INTO civil_students (roll_number, unique_code, student_name) VALUES
('160525732001', 'fscivil', 'Civil Student 1'),
('160525732002', 'fscivil', 'Civil Student 2'),
('160525732003', 'fscivil', 'Civil Student 3'),
('160525732004', 'fscivil', 'Civil Student 4'),
('160525732005', 'fscivil', 'Civil Student 5'),
('160525732006', 'fscivil', 'Civil Student 6'),
('160525732007', 'fscivil', 'Civil Student 7'),
('160525732008', 'fscivil', 'Civil Student 8'),
('160525732009', 'fscivil', 'Civil Student 9'),
('160525732010', 'fscivil', 'Civil Student 10'),
('160525732011', 'fscivil', 'Civil Student 11'),
('160525732012', 'fscivil', 'Civil Student 12'),
('160525732013', 'fscivil', 'Civil Student 13'),
('160525732014', 'fscivil', 'Civil Student 14'),
('160525732015', 'fscivil', 'Civil Student 15'),
('160525732016', 'fscivil', 'Civil Student 16'),
('160525732017', 'fscivil', 'Civil Student 17'),
('160525732018', 'fscivil', 'Civil Student 18'),
('160525732019', 'fscivil', 'Civil Student 19'),
('160525732020', 'fscivil', 'Civil Student 20'),
('160525732021', 'fscivil', 'Civil Student 21'),
('160525732022', 'fscivil', 'Civil Student 22'),
('160525732023', 'fscivil', 'Civil Student 23'),
('160525732024', 'fscivil', 'Civil Student 24'),
('160525732025', 'fscivil', 'Civil Student 25'),
('160525732026', 'fscivil', 'Civil Student 26'),
('160525732027', 'fscivil', 'Civil Student 27'),
('160525732028', 'fscivil', 'Civil Student 28')
ON CONFLICT (roll_number) DO NOTHING;

-- 4. Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_civil_students_roll_code 
    ON civil_students(roll_number, unique_code);

CREATE INDEX IF NOT EXISTS idx_civil_results_roll_number 
    ON civil_exam_results(roll_number);

CREATE INDEX IF NOT EXISTS idx_civil_results_submitted_at 
    ON civil_exam_results(submitted_at);

-- 5. Enable Row Level Security (RLS) - Optional
ALTER TABLE civil_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE civil_exam_results ENABLE ROW LEVEL SECURITY;

-- 6. Create RLS policies for public access (adjust as needed)
CREATE POLICY "Allow public read access to civil_students"
    ON civil_students FOR SELECT
    TO public
    USING (true);

CREATE POLICY "Allow public insert/update to civil_students"
    ON civil_students FOR ALL
    TO public
    USING (true)
    WITH CHECK (true);

CREATE POLICY "Allow public read access to civil_exam_results"
    ON civil_exam_results FOR SELECT
    TO public
    USING (true);

CREATE POLICY "Allow public insert to civil_exam_results"
    ON civil_exam_results FOR INSERT
    TO public
    WITH CHECK (true);

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================

-- Check if students were inserted
SELECT COUNT(*) as total_civil_students FROM civil_students;

-- View all civil students
SELECT roll_number, unique_code, student_name, created_at 
FROM civil_students 
ORDER BY roll_number;

-- =====================================================
-- SUCCESS MESSAGE
-- =====================================================
-- If you see this, the tables were created successfully!
-- 
-- Tables created:
-- 1. civil_students (28 students)
-- 2. civil_exam_results (empty, will store results)
--
-- Next steps:
-- 1. Update supabase-config.js to detect 'fscivil' code
-- 2. Update script.js to load Civil exam questions
-- 3. Test with roll: 160525732001, code: fscivil
-- =====================================================
