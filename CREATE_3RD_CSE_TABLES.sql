-- SQL to create 3rd Year CSE students table and exam results table in Supabase
-- This is a separate system for 3rd Year CSE students
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE 3RD CSE STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS thirdcse_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_thirdcse_students_roll_number ON thirdcse_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE thirdcse_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select thirdcse" ON thirdcse_students
    FOR SELECT
    USING (true);

-- ======================================
-- 2. CREATE 3RD CSE EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS thirdcse_exam_results (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT NOT NULL,
    correct_answers INTEGER NOT NULL,
    wrong_answers INTEGER NOT NULL,
    total_questions INTEGER NOT NULL,
    percentage NUMERIC(5,2) NOT NULL,
    user_answers JSONB,
    additional_data JSONB,
    violation_type TEXT,
    violation_detected BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_thirdcse_exam_results_roll_number ON thirdcse_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE thirdcse_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert thirdcse results" ON thirdcse_exam_results
    FOR INSERT
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select thirdcse results" ON thirdcse_exam_results
    FOR SELECT
    USING (true);

-- ======================================
-- 3. INSERT ALL 246 3RD YEAR CSE STUDENTS
-- ======================================

-- All students use unique code: fs4cse02
INSERT INTO thirdcse_students (roll_number, unique_code, is_active) VALUES
('160524733001', 'fs4cse02', true),
('160524733002', 'fs4cse02', true),
('160524733003', 'fs4cse02', true),
('160524733004', 'fs4cse02', true),
('160524733005', 'fs4cse02', true),
('160524733006', 'fs4cse02', true),
('160524733007', 'fs4cse02', true),
('160524733008', 'fs4cse02', true),
('160524733009', 'fs4cse02', true),
('160524733010', 'fs4cse02', true),
('160524733011', 'fs4cse02', true),
('160524733012', 'fs4cse02', true),
('160524733013', 'fs4cse02', true),
('160524733014', 'fs4cse02', true),
('160524733015', 'fs4cse02', true),
('160524733016', 'fs4cse02', true),
('160524733017', 'fs4cse02', true),
('160524733018', 'fs4cse02', true),
('160524733019', 'fs4cse02', true),
('160524733020', 'fs4cse02', true),
('160524733021', 'fs4cse02', true),
('160524733022', 'fs4cse02', true),
('160524733023', 'fs4cse02', true),
('160524733024', 'fs4cse02', true),
('160524733025', 'fs4cse02', true),
('160524733026', 'fs4cse02', true),
('160524733027', 'fs4cse02', true),
('160524733028', 'fs4cse02', true),
('160524733029', 'fs4cse02', true),
('160524733030', 'fs4cse02', true),
('160524733031', 'fs4cse02', true),
('160524733032', 'fs4cse02', true),
('160524733033', 'fs4cse02', true),
('160524733034', 'fs4cse02', true),
('160524733035', 'fs4cse02', true),
('160524733036', 'fs4cse02', true),
('160524733037', 'fs4cse02', true),
('160524733038', 'fs4cse02', true),
('160524733039', 'fs4cse02', true),
('160524733040', 'fs4cse02', true),
('160524733041', 'fs4cse02', true),
('160524733042', 'fs4cse02', true),
('160524733043', 'fs4cse02', true),
('160524733044', 'fs4cse02', true),
('160524733045', 'fs4cse02', true),
('160524733046', 'fs4cse02', true),
('160524733047', 'fs4cse02', true),
('160524733048', 'fs4cse02', true),
('160524733049', 'fs4cse02', true),
('160524733050', 'fs4cse02', true),
('160524733051', 'fs4cse02', true),
('160524733052', 'fs4cse02', true),
('160524733053', 'fs4cse02', true),
('160524733054', 'fs4cse02', true),
('160524733055', 'fs4cse02', true),
('160524733056', 'fs4cse02', true),
('160524733057', 'fs4cse02', true),
('160524733058', 'fs4cse02', true),
('160524733059', 'fs4cse02', true),
('160524733060', 'fs4cse02', true),
('160524733061', 'fs4cse02', true),
('160524733062', 'fs4cse02', true),
('160524733063', 'fs4cse02', true),
('160524733064', 'fs4cse02', true),
('160524733065', 'fs4cse02', true),
('160524733066', 'fs4cse02', true),
('160524733067', 'fs4cse02', true),
('160524733068', 'fs4cse02', true),
('160524733069', 'fs4cse02', true),
('160524733070', 'fs4cse02', true),
('160524733071', 'fs4cse02', true),
('160524733072', 'fs4cse02', true),
('160524733073', 'fs4cse02', true),
('160524733074', 'fs4cse02', true),
('160524733075', 'fs4cse02', true),
('160524733076', 'fs4cse02', true),
('160524733077', 'fs4cse02', true),
('160524733078', 'fs4cse02', true),
('160524733079', 'fs4cse02', true),
('160524733080', 'fs4cse02', true),
('160524733081', 'fs4cse02', true),
('160524733082', 'fs4cse02', true),
('160524733083', 'fs4cse02', true),
('160524733084', 'fs4cse02', true),
('160524733085', 'fs4cse02', true),
('160524733086', 'fs4cse02', true),
('160524733087', 'fs4cse02', true),
('160524733088', 'fs4cse02', true),
('160524733089', 'fs4cse02', true),
('160524733090', 'fs4cse02', true),
('160524733091', 'fs4cse02', true),
('160524733092', 'fs4cse02', true),
('160524733093', 'fs4cse02', true),
('160524733094', 'fs4cse02', true),
('160524733095', 'fs4cse02', true),
('160524733096', 'fs4cse02', true),
('160524733097', 'fs4cse02', true),
('160524733098', 'fs4cse02', true),
('160524733099', 'fs4cse02', true),
('160524733100', 'fs4cse02', true),
('160524733101', 'fs4cse02', true),
('160524733102', 'fs4cse02', true),
('160524733103', 'fs4cse02', true),
('160524733104', 'fs4cse02', true),
('160524733105', 'fs4cse02', true),
('160524733106', 'fs4cse02', true),
('160524733107', 'fs4cse02', true),
('160524733108', 'fs4cse02', true),
('160524733109', 'fs4cse02', true),
('160524733110', 'fs4cse02', true),
('160524733111', 'fs4cse02', true),
('160524733112', 'fs4cse02', true),
('160524733113', 'fs4cse02', true),
('160524733114', 'fs4cse02', true),
('160524733115', 'fs4cse02', true),
('160524733116', 'fs4cse02', true),
('160524733117', 'fs4cse02', true),
('160524733118', 'fs4cse02', true),
('160524733119', 'fs4cse02', true),
('160524733120', 'fs4cse02', true),
('160524733121', 'fs4cse02', true),
('160524733122', 'fs4cse02', true),
('160524733123', 'fs4cse02', true),
('160524733124', 'fs4cse02', true),
('160524733125', 'fs4cse02', true),
('160524733126', 'fs4cse02', true),
('160524733127', 'fs4cse02', true),
('160524733128', 'fs4cse02', true),
('160524733129', 'fs4cse02', true),
('160524733130', 'fs4cse02', true),
('160524733131', 'fs4cse02', true),
('160524733132', 'fs4cse02', true),
('160524733133', 'fs4cse02', true),
('160524733134', 'fs4cse02', true),
('160524733135', 'fs4cse02', true),
('160524733136', 'fs4cse02', true),
('160524733137', 'fs4cse02', true),
('160524733138', 'fs4cse02', true),
('160524733139', 'fs4cse02', true),
('160524733140', 'fs4cse02', true),
('160524733141', 'fs4cse02', true),
('160524733142', 'fs4cse02', true),
('160524733143', 'fs4cse02', true),
('160524733144', 'fs4cse02', true),
('160524733145', 'fs4cse02', true),
('160524733146', 'fs4cse02', true),
('160524733147', 'fs4cse02', true),
('160524733148', 'fs4cse02', true),
('160524733149', 'fs4cse02', true),
('160524733150', 'fs4cse02', true),
('160524733151', 'fs4cse02', true),
('160524733152', 'fs4cse02', true),
('160524733153', 'fs4cse02', true),
('160524733154', 'fs4cse02', true),
('160524733155', 'fs4cse02', true),
('160524733156', 'fs4cse02', true),
('160524733157', 'fs4cse02', true),
('160524733158', 'fs4cse02', true),
('160524733159', 'fs4cse02', true),
('160524733160', 'fs4cse02', true),
('160524733161', 'fs4cse02', true),
('160524733162', 'fs4cse02', true),
('160524733163', 'fs4cse02', true),
('160524733164', 'fs4cse02', true),
('160524733165', 'fs4cse02', true),
('160524733166', 'fs4cse02', true),
('160524733167', 'fs4cse02', true),
('160524733168', 'fs4cse02', true),
('160524733169', 'fs4cse02', true),
('160524733170', 'fs4cse02', true),
('160524733171', 'fs4cse02', true),
('160524733172', 'fs4cse02', true),
('160524733173', 'fs4cse02', true),
('160524733174', 'fs4cse02', true),
('160524733175', 'fs4cse02', true),
('160524733176', 'fs4cse02', true),
('160524733177', 'fs4cse02', true),
('160524733178', 'fs4cse02', true),
('160524733179', 'fs4cse02', true),
('160524733180', 'fs4cse02', true),
('160524733181', 'fs4cse02', true),
('160524733182', 'fs4cse02', true),
('160524733183', 'fs4cse02', true),
('160524733184', 'fs4cse02', true),
('160524733185', 'fs4cse02', true),
('160524733186', 'fs4cse02', true),
('160524733187', 'fs4cse02', true),
('160524733188', 'fs4cse02', true),
('160524733189', 'fs4cse02', true),
('160524733190', 'fs4cse02', true),
('160524733191', 'fs4cse02', true),
('160524733192', 'fs4cse02', true),
('160524733193', 'fs4cse02', true),
('160524733194', 'fs4cse02', true),
('160524733195', 'fs4cse02', true),
('160524733196', 'fs4cse02', true),
('160524733197', 'fs4cse02', true),
('160524733198', 'fs4cse02', true),
('160524733199', 'fs4cse02', true),
('160524733200', 'fs4cse02', true),
('160524733201', 'fs4cse02', true),
('160524733202', 'fs4cse02', true),
('160524733203', 'fs4cse02', true),
('160524733204', 'fs4cse02', true),
('160524733205', 'fs4cse02', true),
('160524733206', 'fs4cse02', true),
('160524733207', 'fs4cse02', true),
('160524733208', 'fs4cse02', true),
('160524733209', 'fs4cse02', true),
('160524733210', 'fs4cse02', true),
('160524733211', 'fs4cse02', true),
('160524733212', 'fs4cse02', true),
('160524733213', 'fs4cse02', true),
('160524733214', 'fs4cse02', true),
('160524733215', 'fs4cse02', true),
('160524733216', 'fs4cse02', true),
('160524733217', 'fs4cse02', true),
('160524733218', 'fs4cse02', true),
('160524733219', 'fs4cse02', true),
('160524733220', 'fs4cse02', true),
('160524733221', 'fs4cse02', true),
('160524733222', 'fs4cse02', true),
('160524733223', 'fs4cse02', true),
('160524733224', 'fs4cse02', true),
('160524733225', 'fs4cse02', true),
('160524733226', 'fs4cse02', true),
('160524733227', 'fs4cse02', true),
('160524733228', 'fs4cse02', true),
('160524733229', 'fs4cse02', true),
('160524733230', 'fs4cse02', true),
('160524733231', 'fs4cse02', true),
('160524733232', 'fs4cse02', true),
('160524733233', 'fs4cse02', true),
('160524733234', 'fs4cse02', true),
('160524733235', 'fs4cse02', true),
('160524733236', 'fs4cse02', true),
('160524733237', 'fs4cse02', true),
('160524733238', 'fs4cse02', true),
('160524733239', 'fs4cse02', true),
('160524733240', 'fs4cse02', true),
('160524733301', 'fs4cse02', true),
('160524733302', 'fs4cse02', true),
('160524733303', 'fs4cse02', true),
('160524733304', 'fs4cse02', true),
('160524733305', 'fs4cse02', true),
('160524733306', 'fs4cse02', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

-- Check total students added
SELECT COUNT(*) as total_thirdcse_students FROM thirdcse_students;

-- Display first 10 students
SELECT roll_number, unique_code, is_active, created_at 
FROM thirdcse_students 
ORDER BY roll_number 
LIMIT 10;

-- Display last 10 students
SELECT roll_number, unique_code, is_active, created_at 
FROM thirdcse_students 
ORDER BY roll_number DESC 
LIMIT 10;

-- Success message
SELECT '3rd Year CSE tables created successfully! 246 students added with code fs4cse02.' as status;
