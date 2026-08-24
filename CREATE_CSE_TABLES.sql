-- SQL to create CSE students table and exam results table in Supabase
-- This is a separate system for CSE students
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE CSE STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS cse_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_cse_students_roll_number ON cse_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE cse_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select cse" ON cse_students
    FOR SELECT
    USING (true);

-- ======================================
-- 2. CREATE CSE EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS cse_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_cse_exam_results_roll_number ON cse_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE cse_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert cse results" ON cse_exam_results
    FOR INSERT
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select cse results" ON cse_exam_results
    FOR SELECT
    USING (true);

-- ======================================
-- 3. INSERT ALL 240 CSE STUDENTS
-- ======================================

-- All students use unique code: fscse01
INSERT INTO cse_students (roll_number, unique_code, is_active) VALUES
('160525733001', 'fscse01', true),
('160525733002', 'fscse01', true),
('160525733003', 'fscse01', true),
('160525733004', 'fscse01', true),
('160525733005', 'fscse01', true),
('160525733006', 'fscse01', true),
('160525733007', 'fscse01', true),
('160525733008', 'fscse01', true),
('160525733009', 'fscse01', true),
('160525733010', 'fscse01', true),
('160525733011', 'fscse01', true),
('160525733012', 'fscse01', true),
('160525733013', 'fscse01', true),
('160525733014', 'fscse01', true),
('160525733015', 'fscse01', true),
('160525733016', 'fscse01', true),
('160525733017', 'fscse01', true),
('160525733018', 'fscse01', true),
('160525733019', 'fscse01', true),
('160525733020', 'fscse01', true),
('160525733021', 'fscse01', true),
('160525733022', 'fscse01', true),
('160525733023', 'fscse01', true),
('160525733024', 'fscse01', true),
('160525733025', 'fscse01', true),
('160525733026', 'fscse01', true),
('160525733027', 'fscse01', true),
('160525733028', 'fscse01', true),
('160525733029', 'fscse01', true),
('160525733030', 'fscse01', true),
('160525733031', 'fscse01', true),
('160525733032', 'fscse01', true),
('160525733033', 'fscse01', true),
('160525733034', 'fscse01', true),
('160525733035', 'fscse01', true),
('160525733036', 'fscse01', true),
('160525733037', 'fscse01', true),
('160525733038', 'fscse01', true),
('160525733039', 'fscse01', true),
('160525733040', 'fscse01', true),
('160525733041', 'fscse01', true),
('160525733042', 'fscse01', true),
('160525733043', 'fscse01', true),
('160525733044', 'fscse01', true),
('160525733045', 'fscse01', true),
('160525733046', 'fscse01', true),
('160525733047', 'fscse01', true),
('160525733048', 'fscse01', true),
('160525733049', 'fscse01', true),
('160525733050', 'fscse01', true),
('160525733051', 'fscse01', true),
('160525733052', 'fscse01', true),
('160525733053', 'fscse01', true),
('160525733054', 'fscse01', true),
('160525733055', 'fscse01', true),
('160525733056', 'fscse01', true),
('160525733057', 'fscse01', true),
('160525733058', 'fscse01', true),
('160525733059', 'fscse01', true),
('160525733060', 'fscse01', true),
('160525733061', 'fscse01', true),
('160525733062', 'fscse01', true),
('160525733063', 'fscse01', true),
('160525733064', 'fscse01', true),
('160525733065', 'fscse01', true),
('160525733066', 'fscse01', true),
('160525733067', 'fscse01', true),
('160525733068', 'fscse01', true),
('160525733069', 'fscse01', true),
('160525733070', 'fscse01', true),
('160525733071', 'fscse01', true),
('160525733072', 'fscse01', true),
('160525733073', 'fscse01', true),
('160525733074', 'fscse01', true),
('160525733075', 'fscse01', true),
('160525733076', 'fscse01', true),
('160525733077', 'fscse01', true),
('160525733078', 'fscse01', true),
('160525733079', 'fscse01', true),
('160525733080', 'fscse01', true),
('160525733081', 'fscse01', true),
('160525733082', 'fscse01', true),
('160525733083', 'fscse01', true),
('160525733084', 'fscse01', true),
('160525733085', 'fscse01', true),
('160525733086', 'fscse01', true),
('160525733087', 'fscse01', true),
('160525733088', 'fscse01', true),
('160525733089', 'fscse01', true),
('160525733090', 'fscse01', true),
('160525733091', 'fscse01', true),
('160525733092', 'fscse01', true),
('160525733093', 'fscse01', true),
('160525733094', 'fscse01', true),
('160525733095', 'fscse01', true),
('160525733096', 'fscse01', true),
('160525733097', 'fscse01', true),
('160525733098', 'fscse01', true),
('160525733099', 'fscse01', true),
('160525733100', 'fscse01', true),
('160525733101', 'fscse01', true),
('160525733102', 'fscse01', true),
('160525733103', 'fscse01', true),
('160525733104', 'fscse01', true),
('160525733105', 'fscse01', true),
('160525733106', 'fscse01', true),
('160525733107', 'fscse01', true),
('160525733108', 'fscse01', true),
('160525733109', 'fscse01', true),
('160525733110', 'fscse01', true),
('160525733111', 'fscse01', true),
('160525733112', 'fscse01', true),
('160525733113', 'fscse01', true),
('160525733114', 'fscse01', true),
('160525733115', 'fscse01', true),
('160525733116', 'fscse01', true),
('160525733117', 'fscse01', true),
('160525733118', 'fscse01', true),
('160525733119', 'fscse01', true),
('160525733120', 'fscse01', true),
('160525733121', 'fscse01', true),
('160525733122', 'fscse01', true),
('160525733123', 'fscse01', true),
('160525733124', 'fscse01', true),
('160525733125', 'fscse01', true),
('160525733126', 'fscse01', true),
('160525733127', 'fscse01', true),
('160525733128', 'fscse01', true),
('160525733129', 'fscse01', true),
('160525733130', 'fscse01', true),
('160525733131', 'fscse01', true),
('160525733132', 'fscse01', true),
('160525733133', 'fscse01', true),
('160525733134', 'fscse01', true),
('160525733135', 'fscse01', true),
('160525733136', 'fscse01', true),
('160525733137', 'fscse01', true),
('160525733138', 'fscse01', true),
('160525733139', 'fscse01', true),
('160525733140', 'fscse01', true),
('160525733141', 'fscse01', true),
('160525733142', 'fscse01', true),
('160525733143', 'fscse01', true),
('160525733144', 'fscse01', true),
('160525733145', 'fscse01', true),
('160525733146', 'fscse01', true),
('160525733147', 'fscse01', true),
('160525733148', 'fscse01', true),
('160525733149', 'fscse01', true),
('160525733150', 'fscse01', true),
('160525733151', 'fscse01', true),
('160525733152', 'fscse01', true),
('160525733153', 'fscse01', true),
('160525733154', 'fscse01', true),
('160525733155', 'fscse01', true),
('160525733156', 'fscse01', true),
('160525733157', 'fscse01', true),
('160525733158', 'fscse01', true),
('160525733159', 'fscse01', true),
('160525733160', 'fscse01', true),
('160525733161', 'fscse01', true),
('160525733162', 'fscse01', true),
('160525733163', 'fscse01', true),
('160525733164', 'fscse01', true),
('160525733165', 'fscse01', true),
('160525733166', 'fscse01', true),
('160525733167', 'fscse01', true),
('160525733168', 'fscse01', true),
('160525733169', 'fscse01', true),
('160525733170', 'fscse01', true),
('160525733171', 'fscse01', true),
('160525733172', 'fscse01', true),
('160525733173', 'fscse01', true),
('160525733174', 'fscse01', true),
('160525733175', 'fscse01', true),
('160525733176', 'fscse01', true),
('160525733177', 'fscse01', true),
('160525733178', 'fscse01', true),
('160525733179', 'fscse01', true),
('160525733180', 'fscse01', true),
('160525733181', 'fscse01', true),
('160525733182', 'fscse01', true),
('160525733183', 'fscse01', true),
('160525733184', 'fscse01', true),
('160525733185', 'fscse01', true),
('160525733186', 'fscse01', true),
('160525733187', 'fscse01', true),
('160525733188', 'fscse01', true),
('160525733189', 'fscse01', true),
('160525733190', 'fscse01', true),
('160525733191', 'fscse01', true),
('160525733192', 'fscse01', true),
('160525733193', 'fscse01', true),
('160525733194', 'fscse01', true),
('160525733195', 'fscse01', true),
('160525733196', 'fscse01', true),
('160525733197', 'fscse01', true),
('160525733198', 'fscse01', true),
('160525733199', 'fscse01', true),
('160525733200', 'fscse01', true),
('160525733201', 'fscse01', true),
('160525733202', 'fscse01', true),
('160525733203', 'fscse01', true),
('160525733204', 'fscse01', true),
('160525733205', 'fscse01', true),
('160525733206', 'fscse01', true),
('160525733207', 'fscse01', true),
('160525733208', 'fscse01', true),
('160525733209', 'fscse01', true),
('160525733210', 'fscse01', true),
('160525733211', 'fscse01', true),
('160525733212', 'fscse01', true),
('160525733213', 'fscse01', true),
('160525733214', 'fscse01', true),
('160525733215', 'fscse01', true),
('160525733216', 'fscse01', true),
('160525733217', 'fscse01', true),
('160525733218', 'fscse01', true),
('160525733219', 'fscse01', true),
('160525733220', 'fscse01', true),
('160525733221', 'fscse01', true),
('160525733222', 'fscse01', true),
('160525733223', 'fscse01', true),
('160525733224', 'fscse01', true),
('160525733225', 'fscse01', true),
('160525733226', 'fscse01', true),
('160525733227', 'fscse01', true),
('160525733228', 'fscse01', true),
('160525733229', 'fscse01', true),
('160525733230', 'fscse01', true),
('160525733231', 'fscse01', true),
('160525733232', 'fscse01', true),
('160525733233', 'fscse01', true),
('160525733234', 'fscse01', true),
('160525733235', 'fscse01', true),
('160525733236', 'fscse01', true),
('160525733237', 'fscse01', true),
('160525733238', 'fscse01', true),
('160525733239', 'fscse01', true),
('160525733240', 'fscse01', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

-- Check total students added
SELECT COUNT(*) as total_cse_students FROM cse_students;

-- Display first 10 students
SELECT roll_number, unique_code, is_active, created_at 
FROM cse_students 
ORDER BY roll_number 
LIMIT 10;

-- Display last 10 students
SELECT roll_number, unique_code, is_active, created_at 
FROM cse_students 
ORDER BY roll_number DESC 
LIMIT 10;

-- Success message
SELECT 'CSE tables created successfully! 240 students added with code fscse01.' as status;
