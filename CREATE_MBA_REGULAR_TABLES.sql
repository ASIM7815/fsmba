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

-- All students use unique code: fsmba1808
INSERT INTO mba_regular_students (roll_number, unique_code, is_active) VALUES
('160525672001', 'fsmba03', true),
('160525672002', 'fsmba03', true),
('160525672003', 'fsmba03', true),
('160525672004', 'fsmba03', true),
('160525672005', 'fsmba03', true),
('160525672006', 'fsmba03', true),
('160525672007', 'fsmba03', true),
('160525672008', 'fsmba03', true),
('160525672009', 'fsmba03', true),
('160525672010', 'fsmba03', true),
('160525672011', 'fsmba03', true),
('160525672012', 'fsmba03', true),
('160525672013', 'fsmba03', true),
('160525672014', 'fsmba03', true),
('160525672015', 'fsmba03', true),
('160525672016', 'fsmba03', true),
('160525672017', 'fsmba03', true),
('160525672018', 'fsmba03', true),
('160525672019', 'fsmba03', true),
('160525672020', 'fsmba03', true),
('160525672021', 'fsmba03', true),
('160525672022', 'fsmba03', true),
('160525672023', 'fsmba03', true),
('160525672024', 'fsmba03', true),
('160525672025', 'fsmba03', true),
('160525672026', 'fsmba03', true),
('160525672027', 'fsmba03', true),
('160525672028', 'fsmba03', true),
('160525672029', 'fsmba03', true),
('160525672030', 'fsmba03', true),
('160525672031', 'fsmba03', true),
('160525672032', 'fsmba03', true),
('160525672033', 'fsmba03', true),
('160525672034', 'fsmba03', true),
('160525672035', 'fsmba03', true),
('160525672036', 'fsmba03', true),
('160525672037', 'fsmba03', true),
('160525672038', 'fsmba03', true),
('160525672039', 'fsmba03', true),
('160525672040', 'fsmba03', true),
('160525672041', 'fsmba03', true),
('160525672042', 'fsmba03', true),
('160525672043', 'fsmba03', true),
('160525672044', 'fsmba03', true),
('160525672045', 'fsmba03', true),
('160525672046', 'fsmba03', true),
('160525672047', 'fsmba03', true),
('160525672048', 'fsmba03', true),
('160525672049', 'fsmba03', true),
('160525672050', 'fsmba03', true),
('160525672051', 'fsmba03', true),
('160525672052', 'fsmba03', true),
('160525672053', 'fsmba03', true),
('160525672054', 'fsmba03', true),
('160525672055', 'fsmba03', true),
('160525672056', 'fsmba03', true),
('160525672057', 'fsmba03', true),
('160525672058', 'fsmba03', true),
('160525672059', 'fsmba03', true),
('160525672060', 'fsmba03', true),
('160525672061', 'fsmba03', true),
('160525672062', 'fsmba03', true),
('160525672063', 'fsmba03', true),
('160525672064', 'fsmba03', true),
('160525672065', 'fsmba03', true),
('160525672066', 'fsmba03', true),
('160525672067', 'fsmba03', true),
('160525672068', 'fsmba03', true),
('160525672069', 'fsmba03', true),
('160525672070', 'fsmba03', true),
('160525672071', 'fsmba03', true),
('160525672072', 'fsmba03', true),
('160525672073', 'fsmba03', true),
('160525672074', 'fsmba03', true),
('160525672075', 'fsmba03', true),
('160525672076', 'fsmba03', true),
('160525672077', 'fsmba03', true),
('160525672078', 'fsmba03', true),
('160525672079', 'fsmba03', true),
('160525672080', 'fsmba03', true),
('160525672081', 'fsmba03', true),
('160525672082', 'fsmba03', true),
('160525672083', 'fsmba03', true),
('160525672084', 'fsmba03', true),
('160525672085', 'fsmba03', true),
('160525672086', 'fsmba03', true),
('160525672087', 'fsmba03', true),
('160525672088', 'fsmba03', true),
('160525672089', 'fsmba03', true),
('160525672090', 'fsmba03', true),
('160525672091', 'fsmba03', true),
('160525672092', 'fsmba03', true),
('160525672093', 'fsmba03', true),
('160525672094', 'fsmba03', true),
('160525672095', 'fsmba03', true),
('160525672096', 'fsmba03', true),
('160525672097', 'fsmba03', true),
('160525672098', 'fsmba03', true),
('160525672099', 'fsmba03', true),
('160525672100', 'fsmba03', true),
('160525672101', 'fsmba03', true),
('160525672102', 'fsmba03', true),
('160525672103', 'fsmba03', true),
('160525672104', 'fsmba03', true),
('160525672105', 'fsmba03', true),
('160525672106', 'fsmba03', true),
('160525672107', 'fsmba03', true),
('160525672108', 'fsmba03', true),
('160525672109', 'fsmba03', true),
('160525672110', 'fsmba03', true),
('160525672111', 'fsmba03', true),
('160525672112', 'fsmba03', true),
('160525672113', 'fsmba03', true),
('160525672114', 'fsmba03', true),
('160525672115', 'fsmba03', true),
('160525672116', 'fsmba03', true),
('160525672117', 'fsmba03', true),
('160525672118', 'fsmba03', true),
('160525672119', 'fsmba03', true),
('160525672120', 'fsmba03', true),
('160525672121', 'fsmba03', true),
('160525672122', 'fsmba03', true),
('160525672123', 'fsmba03', true),
('160525672124', 'fsmba03', true),
('160525672125', 'fsmba03', true),
('160525672126', 'fsmba03', true),
('160525672127', 'fsmba03', true),
('160525672128', 'fsmba03', true),
('160525672129', 'fsmba03', true),
('160525672130', 'fsmba03', true),
('160525672131', 'fsmba03', true),
('160525672132', 'fsmba03', true),
('160525672133', 'fsmba03', true),
('160525672134', 'fsmba03', true),
('160525672135', 'fsmba03', true),
('160525672136', 'fsmba03', true),
('160525672137', 'fsmba03', true),
('160525672138', 'fsmba03', true),
('160525672139', 'fsmba03', true),
('160525672140', 'fsmba03', true),
('160525672141', 'fsmba03', true),
('160525672142', 'fsmba03', true),
('160525672143', 'fsmba03', true),
('160525672144', 'fsmba03', true),
('160525672145', 'fsmba03', true),
('160525672146', 'fsmba03', true),
('160525672147', 'fsmba03', true),
('160525672148', 'fsmba03', true),
('160525672149', 'fsmba03', true),
('160525672150', 'fsmba03', true),
('160525672151', 'fsmba03', true),
('160525672152', 'fsmba03', true),
('160525672153', 'fsmba03', true),
('160525672154', 'fsmba03', true),
('160525672155', 'fsmba03', true),
('160525672156', 'fsmba03', true),
('160525672157', 'fsmba03', true),
('160525672158', 'fsmba03', true),
('160525672159', 'fsmba03', true),
('160525672160', 'fsmba03', true),
('160525672161', 'fsmba03', true),
('160525672162', 'fsmba03', true),
('160525672163', 'fsmba03', true),
('160525672164', 'fsmba03', true),
('160525672165', 'fsmba03', true),
('160525672166', 'fsmba03', true),
('160525672167', 'fsmba03', true),
('160525672168', 'fsmba03', true),
('160525672169', 'fsmba03', true),
('160525672170', 'fsmba03', true),
('160525672171', 'fsmba03', true),
('160525672172', 'fsmba03', true),
('160525672173', 'fsmba03', true),
('160525672174', 'fsmba03', true),
('160525672175', 'fsmba03', true),
('160525672176', 'fsmba03', true),
('160525672177', 'fsmba03', true),
('160525672178', 'fsmba03', true),
('160525672179', 'fsmba03', true),
('160525672180', 'fsmba03', true),
('160525672181', 'fsmba03', true),
('160525672182', 'fsmba03', true),
('160525672183', 'fsmba03', true),
('160525672184', 'fsmba03', true),
('160525672185', 'fsmba03', true),
('160525672186', 'fsmba03', true),
('160525672187', 'fsmba03', true),
('160525672188', 'fsmba03', true),
('160525672189', 'fsmba03', true),
('160525672190', 'fsmba03', true),
('160525672191', 'fsmba03', true),
('160525672192', 'fsmba03', true),
('160525672193', 'fsmba03', true),
('160525672194', 'fsmba03', true),
('160525672195', 'fsmba03', true),
('160525672196', 'fsmba03', true),
('160525672197', 'fsmba03', true),
('160525672198', 'fsmba03', true),
('160525672199', 'fsmba03', true),
('160525672200', 'fsmba03', true),
('160525672201', 'fsmba03', true),
('160525672202', 'fsmba03', true),
('160525672203', 'fsmba03', true),
('160525672204', 'fsmba03', true),
('160525672205', 'fsmba03', true),
('160525672206', 'fsmba03', true),
('160525672207', 'fsmba03', true),
('160525672208', 'fsmba03', true),
('160525672209', 'fsmba03', true),
('160525672210', 'fsmba03', true),
('160525672211', 'fsmba03', true),
('160525672212', 'fsmba03', true),
('160525672213', 'fsmba03', true),
('160525672214', 'fsmba03', true),
('160525672215', 'fsmba03', true),
('160525672216', 'fsmba03', true),
('160525672217', 'fsmba03', true),
('160525672218', 'fsmba03', true),
('160525672219', 'fsmba03', true),
('160525672220', 'fsmba03', true),
('160525672221', 'fsmba03', true),
('160525672222', 'fsmba03', true),
('160525672223', 'fsmba03', true),
('160525672224', 'fsmba03', true),
('160525672225', 'fsmba03', true),
('160525672226', 'fsmba03', true),
('160525672227', 'fsmba03', true),
('160525672228', 'fsmba03', true),
('160525672229', 'fsmba03', true)
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
