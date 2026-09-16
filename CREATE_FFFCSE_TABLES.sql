-- =========================================================
-- FFFCSE EXAM DATABASE
-- ONE STUDENT = ONE EXAM ATTEMPT
-- =========================================================

-- =========================================================
-- 1. STUDENTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fffcse_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_fffcse_students_roll_number
ON fffcse_students(roll_number);

-- =========================================================
-- 2. EXAM RESULTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fffcse_exam_results (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT NOT NULL,
    correct_answers INTEGER NOT NULL,
    wrong_answers INTEGER NOT NULL,
    total_questions INTEGER NOT NULL,
    percentage NUMERIC(5,2) NOT NULL,
    user_answers JSONB,
    additional_data JSONB,
    violation_type TEXT,
    violation_detected BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    -- VERY IMPORTANT:
    -- One roll number can have ONLY ONE result.
    CONSTRAINT unique_fffcse_exam_attempt
        UNIQUE (roll_number)
);

CREATE INDEX IF NOT EXISTS idx_fffcse_exam_results_roll_number
ON fffcse_exam_results(roll_number);

-- =========================================================
-- 3. ENABLE RLS
-- =========================================================
ALTER TABLE fffcse_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE fffcse_exam_results ENABLE ROW LEVEL SECURITY;

-- =========================================================
-- 4. STUDENT LOGIN / VALIDATION
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fffcse" 
ON fffcse_students;

CREATE POLICY "Allow public select fffcse"
ON fffcse_students
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 5. CHECK WHETHER STUDENT ALREADY TOOK EXAM
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fffcse results"
ON fffcse_exam_results;

CREATE POLICY "Allow public select fffcse results"
ON fffcse_exam_results
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 6. ALLOW EXAM SUBMISSION
-- =========================================================
DROP POLICY IF EXISTS "Allow public insert fffcse results"
ON fffcse_exam_results;

CREATE POLICY "Allow public insert fffcse results"
ON fffcse_exam_results
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- =========================================================
-- 7. INSERT STUDENTS (75 students)
-- =========================================================
INSERT INTO fffcse_students
    (roll_number, unique_code, is_active)
VALUES
    ('160524733005', 'fffcse', true),
    ('160524733006', 'fffcse', true),
    ('160524733012', 'fffcse', true),
    ('160524733018', 'fffcse', true),
    ('160524733037', 'fffcse', true),
    ('160524733041', 'fffcse', true),
    ('160524733043', 'fffcse', true),
    ('160524733046', 'fffcse', true),
    ('160524733047', 'fffcse', true),
    ('160524733051', 'fffcse', true),
    ('160524733055', 'fffcse', true),
    ('160524733059', 'fffcse', true),
    ('160524733061', 'fffcse', true),
    ('160524733063', 'fffcse', true),
    ('160524733067', 'fffcse', true),
    ('160524733068', 'fffcse', true),
    ('160524733069', 'fffcse', true),
    ('160524733071', 'fffcse', true),
    ('160524733075', 'fffcse', true),
    ('160524733076', 'fffcse', true),
    ('160524733090', 'fffcse', true),
    ('160524733093', 'fffcse', true),
    ('160524733095', 'fffcse', true),
    ('160524733098', 'fffcse', true),
    ('160524733101', 'fffcse', true),
    ('160524733102', 'fffcse', true),
    ('160524733104', 'fffcse', true),
    ('160524733107', 'fffcse', true),
    ('160524733114', 'fffcse', true),
    ('160524733122', 'fffcse', true),
    ('160524733128', 'fffcse', true),
    ('160524733135', 'fffcse', true),
    ('160524733140', 'fffcse', true),
    ('160524733145', 'fffcse', true),
    ('160524733150', 'fffcse', true),
    ('160524733152', 'fffcse', true),
    ('160524733155', 'fffcse', true),
    ('160524733156', 'fffcse', true),
    ('160524733157', 'fffcse', true),
    ('160524733158', 'fffcse', true),
    ('160524733162', 'fffcse', true),
    ('160524733163', 'fffcse', true),
    ('160524733170', 'fffcse', true),
    ('160524733172', 'fffcse', true),
    ('160524733173', 'fffcse', true),
    ('160524733174', 'fffcse', true),
    ('160524733175', 'fffcse', true),
    ('160524733177', 'fffcse', true),
    ('160524733179', 'fffcse', true),
    ('160524733186', 'fffcse', true),
    ('160524733188', 'fffcse', true),
    ('160524733192', 'fffcse', true),
    ('160524733195', 'fffcse', true),
    ('160524733199', 'fffcse', true),
    ('160524733201', 'fffcse', true),
    ('160524733202', 'fffcse', true),
    ('160524733206', 'fffcse', true),
    ('160524733207', 'fffcse', true),
    ('160524733210', 'fffcse', true),
    ('160524733211', 'fffcse', true),
    ('160524733212', 'fffcse', true),
    ('160524733213', 'fffcse', true),
    ('160524733214', 'fffcse', true),
    ('160524733217', 'fffcse', true),
    ('160524733219', 'fffcse', true),
    ('160524733222', 'fffcse', true),
    ('160524733223', 'fffcse', true),
    ('160524733224', 'fffcse', true),
    ('160524733226', 'fffcse', true),
    ('160524733229', 'fffcse', true),
    ('160524733231', 'fffcse', true),
    ('160524733301', 'fffcse', true),
    ('160524733302', 'fffcse', true),
    ('160524733303', 'fffcse', true),
    ('160524733304', 'fffcse', true)
ON CONFLICT (roll_number)
DO NOTHING;

-- =========================================================
-- 8. VERIFY
-- =========================================================
SELECT COUNT(*) AS total_fffcse_students
FROM fffcse_students;

SELECT *
FROM fffcse_students
ORDER BY roll_number;

SELECT *
FROM fffcse_exam_results
ORDER BY created_at DESC;
