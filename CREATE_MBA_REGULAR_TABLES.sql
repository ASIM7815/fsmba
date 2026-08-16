-- SQL to create MBA Regular students table and exam results table in Supabase
-- This is a separate system from the existing FSMBA students
-- Run this in your Supabase SQL Editor

-- ======================================
-- 1. CREATE MBA REGULAR STUDENTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS mba_regular_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on roll_number for faster queries
CREATE INDEX IF NOT EXISTS idx_mba_regular_students_roll_number ON mba_regular_students(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE mba_regular_students ENABLE ROW LEVEL SECURITY;

-- Policy to allow public select (for validation during login)
CREATE POLICY "Allow public select mba regular" ON mba_regular_students
    FOR SELECT
    USING (true);

-- ======================================
-- 2. CREATE MBA REGULAR EXAM RESULTS TABLE
-- ======================================

CREATE TABLE IF NOT EXISTS mba_regular_exam_results (
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
CREATE INDEX IF NOT EXISTS idx_mba_regular_exam_results_roll_number ON mba_regular_exam_results(roll_number);

-- Add Row Level Security (RLS) policies
ALTER TABLE mba_regular_exam_results ENABLE ROW LEVEL SECURITY;

-- Policy to allow public insert (for exam submission)
CREATE POLICY "Allow public insert mba regular results" ON mba_regular_exam_results
    FOR INSERT
    WITH CHECK (true);

-- Policy to allow public select (for checking if exam already taken)
CREATE POLICY "Allow public select mba regular results" ON mba_regular_exam_results
    FOR SELECT
    USING (true);

-- ======================================
-- 3. INSERT ALL 229 MBA REGULAR STUDENTS
-- ======================================

-- All students use unique code: fsmba1708
INSERT INTO mba_regular_students (roll_number, unique_code, is_active) VALUES
('160525672001', 'fsmba1708', true),
('160525672002', 'fsmba1708', true),
('160525672003', 'fsmba1708', true),
('160525672004', 'fsmba1708', true),
('160525672005', 'fsmba1708', true),
('160525672006', 'fsmba1708', true),
('160525672007', 'fsmba1708', true),
('160525672008', 'fsmba1708', true),
('160525672009', 'fsmba1708', true),
('160525672010', 'fsmba1708', true),
('160525672011', 'fsmba1708', true),
('160525672012', 'fsmba1708', true),
('160525672013', 'fsmba1708', true),
('160525672014', 'fsmba1708', true),
('160525672015', 'fsmba1708', true),
('160525672016', 'fsmba1708', true),
('160525672017', 'fsmba1708', true),
('160525672018', 'fsmba1708', true),
('160525672019', 'fsmba1708', true),
('160525672020', 'fsmba1708', true),
('160525672021', 'fsmba1708', true),
('160525672022', 'fsmba1708', true),
('160525672023', 'fsmba1708', true),
('160525672024', 'fsmba1708', true),
('160525672025', 'fsmba1708', true),
('160525672026', 'fsmba1708', true),
('160525672027', 'fsmba1708', true),
('160525672028', 'fsmba1708', true),
('160525672029', 'fsmba1708', true),
('160525672030', 'fsmba1708', true),
('160525672031', 'fsmba1708', true),
('160525672032', 'fsmba1708', true),
('160525672033', 'fsmba1708', true),
('160525672034', 'fsmba1708', true),
('160525672035', 'fsmba1708', true),
('160525672036', 'fsmba1708', true),
('160525672037', 'fsmba1708', true),
('160525672038', 'fsmba1708', true),
('160525672039', 'fsmba1708', true),
('160525672040', 'fsmba1708', true),
('160525672041', 'fsmba1708', true),
('160525672042', 'fsmba1708', true),
('160525672043', 'fsmba1708', true),
('160525672044', 'fsmba1708', true),
('160525672045', 'fsmba1708', true),
('160525672046', 'fsmba1708', true),
('160525672047', 'fsmba1708', true),
('160525672048', 'fsmba1708', true),
('160525672049', 'fsmba1708', true),
('160525672050', 'fsmba1708', true),
('160525672051', 'fsmba1708', true),
('160525672052', 'fsmba1708', true),
('160525672053', 'fsmba1708', true),
('160525672054', 'fsmba1708', true),
('160525672055', 'fsmba1708', true),
('160525672056', 'fsmba1708', true),
('160525672057', 'fsmba1708', true),
('160525672058', 'fsmba1708', true),
('160525672059', 'fsmba1708', true),
('160525672060', 'fsmba1708', true),
('160525672061', 'fsmba1708', true),
('160525672062', 'fsmba1708', true),
('160525672063', 'fsmba1708', true),
('160525672064', 'fsmba1708', true),
('160525672065', 'fsmba1708', true),
('160525672066', 'fsmba1708', true),
('160525672067', 'fsmba1708', true),
('160525672068', 'fsmba1708', true),
('160525672069', 'fsmba1708', true),
('160525672070', 'fsmba1708', true),
('160525672071', 'fsmba1708', true),
('160525672072', 'fsmba1708', true),
('160525672073', 'fsmba1708', true),
('160525672074', 'fsmba1708', true),
('160525672075', 'fsmba1708', true),
('160525672076', 'fsmba1708', true),
('160525672077', 'fsmba1708', true),
('160525672078', 'fsmba1708', true),
('160525672079', 'fsmba1708', true),
('160525672080', 'fsmba1708', true),
('160525672081', 'fsmba1708', true),
('160525672082', 'fsmba1708', true),
('160525672083', 'fsmba1708', true),
('160525672084', 'fsmba1708', true),
('160525672085', 'fsmba1708', true),
('160525672086', 'fsmba1708', true),
('160525672087', 'fsmba1708', true),
('160525672088', 'fsmba1708', true),
('160525672089', 'fsmba1708', true),
('160525672090', 'fsmba1708', true),
('160525672091', 'fsmba1708', true),
('160525672092', 'fsmba1708', true),
('160525672093', 'fsmba1708', true),
('160525672094', 'fsmba1708', true),
('160525672095', 'fsmba1708', true),
('160525672096', 'fsmba1708', true),
('160525672097', 'fsmba1708', true),
('160525672098', 'fsmba1708', true),
('160525672099', 'fsmba1708', true),
('160525672100', 'fsmba1708', true),
('160525672101', 'fsmba1708', true),
('160525672102', 'fsmba1708', true),
('160525672103', 'fsmba1708', true),
('160525672104', 'fsmba1708', true),
('160525672105', 'fsmba1708', true),
('160525672106', 'fsmba1708', true),
('160525672107', 'fsmba1708', true),
('160525672108', 'fsmba1708', true),
('160525672109', 'fsmba1708', true),
('160525672110', 'fsmba1708', true),
('160525672111', 'fsmba1708', true),
('160525672112', 'fsmba1708', true),
('160525672113', 'fsmba1708', true),
('160525672114', 'fsmba1708', true),
('160525672115', 'fsmba1708', true),
('160525672116', 'fsmba1708', true),
('160525672117', 'fsmba1708', true),
('160525672118', 'fsmba1708', true),
('160525672119', 'fsmba1708', true),
('160525672120', 'fsmba1708', true),
('160525672121', 'fsmba1708', true),
('160525672122', 'fsmba1708', true),
('160525672123', 'fsmba1708', true),
('160525672124', 'fsmba1708', true),
('160525672125', 'fsmba1708', true),
('160525672126', 'fsmba1708', true),
('160525672127', 'fsmba1708', true),
('160525672128', 'fsmba1708', true),
('160525672129', 'fsmba1708', true),
('160525672130', 'fsmba1708', true),
('160525672131', 'fsmba1708', true),
('160525672132', 'fsmba1708', true),
('160525672133', 'fsmba1708', true),
('160525672134', 'fsmba1708', true),
('160525672135', 'fsmba1708', true),
('160525672136', 'fsmba1708', true),
('160525672137', 'fsmba1708', true),
('160525672138', 'fsmba1708', true),
('160525672139', 'fsmba1708', true),
('160525672140', 'fsmba1708', true),
('160525672141', 'fsmba1708', true),
('160525672142', 'fsmba1708', true),
('160525672143', 'fsmba1708', true),
('160525672144', 'fsmba1708', true),
('160525672145', 'fsmba1708', true),
('160525672146', 'fsmba1708', true),
('160525672147', 'fsmba1708', true),
('160525672148', 'fsmba1708', true),
('160525672149', 'fsmba1708', true),
('160525672150', 'fsmba1708', true),
('160525672151', 'fsmba1708', true),
('160525672152', 'fsmba1708', true),
('160525672153', 'fsmba1708', true),
('160525672154', 'fsmba1708', true),
('160525672155', 'fsmba1708', true),
('160525672156', 'fsmba1708', true),
('160525672157', 'fsmba1708', true),
('160525672158', 'fsmba1708', true),
('160525672159', 'fsmba1708', true),
('160525672160', 'fsmba1708', true),
('160525672161', 'fsmba1708', true),
('160525672162', 'fsmba1708', true),
('160525672163', 'fsmba1708', true),
('160525672164', 'fsmba1708', true),
('160525672165', 'fsmba1708', true),
('160525672166', 'fsmba1708', true),
('160525672167', 'fsmba1708', true),
('160525672168', 'fsmba1708', true),
('160525672169', 'fsmba1708', true),
('160525672170', 'fsmba1708', true),
('160525672171', 'fsmba1708', true),
('160525672172', 'fsmba1708', true),
('160525672173', 'fsmba1708', true),
('160525672174', 'fsmba1708', true),
('160525672175', 'fsmba1708', true),
('160525672176', 'fsmba1708', true),
('160525672177', 'fsmba1708', true),
('160525672178', 'fsmba1708', true),
('160525672179', 'fsmba1708', true),
('160525672180', 'fsmba1708', true),
('160525672181', 'fsmba1708', true),
('160525672182', 'fsmba1708', true),
('160525672183', 'fsmba1708', true),
('160525672184', 'fsmba1708', true),
('160525672185', 'fsmba1708', true),
('160525672186', 'fsmba1708', true),
('160525672187', 'fsmba1708', true),
('160525672188', 'fsmba1708', true),
('160525672189', 'fsmba1708', true),
('160525672190', 'fsmba1708', true),
('160525672191', 'fsmba1708', true),
('160525672192', 'fsmba1708', true),
('160525672193', 'fsmba1708', true),
('160525672194', 'fsmba1708', true),
('160525672195', 'fsmba1708', true),
('160525672196', 'fsmba1708', true),
('160525672197', 'fsmba1708', true),
('160525672198', 'fsmba1708', true),
('160525672199', 'fsmba1708', true),
('160525672200', 'fsmba1708', true),
('160525672201', 'fsmba1708', true),
('160525672202', 'fsmba1708', true),
('160525672203', 'fsmba1708', true),
('160525672204', 'fsmba1708', true),
('160525672205', 'fsmba1708', true),
('160525672206', 'fsmba1708', true),
('160525672207', 'fsmba1708', true),
('160525672208', 'fsmba1708', true),
('160525672209', 'fsmba1708', true),
('160525672210', 'fsmba1708', true),
('160525672211', 'fsmba1708', true),
('160525672212', 'fsmba1708', true),
('160525672213', 'fsmba1708', true),
('160525672214', 'fsmba1708', true),
('160525672215', 'fsmba1708', true),
('160525672216', 'fsmba1708', true),
('160525672217', 'fsmba1708', true),
('160525672218', 'fsmba1708', true),
('160525672219', 'fsmba1708', true),
('160525672220', 'fsmba1708', true),
('160525672221', 'fsmba1708', true),
('160525672222', 'fsmba1708', true),
('160525672223', 'fsmba1708', true),
('160525672224', 'fsmba1708', true),
('160525672225', 'fsmba1708', true),
('160525672226', 'fsmba1708', true),
('160525672227', 'fsmba1708', true),
('160525672228', 'fsmba1708', true),
('160525672229', 'fsmba1708', true)
ON CONFLICT (roll_number) DO NOTHING;

-- ======================================
-- 4. VERIFY DATA
-- ======================================

-- Check total students added
SELECT COUNT(*) as total_mba_regular_students FROM mba_regular_students;

-- Display first 10 students
SELECT roll_number, unique_code, is_active, created_at 
FROM mba_regular_students 
ORDER BY roll_number 
LIMIT 10;

-- Display last 10 students
SELECT roll_number, unique_code, is_active, created_at 
FROM mba_regular_students 
ORDER BY roll_number DESC 
LIMIT 10;

-- Success message
SELECT 'MBA Regular tables created successfully! 229 students added.' as status;
