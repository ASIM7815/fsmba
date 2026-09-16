-- =========================================================
-- FFFCIVIL EXAM DATABASE
-- ONE STUDENT = ONE EXAM ATTEMPT
-- =========================================================

-- =========================================================
-- 1. STUDENTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fffcivil_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_fffcivil_students_roll_number
ON fffcivil_students(roll_number);

-- =========================================================
-- 2. EXAM RESULTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fffcivil_exam_results (
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
    CONSTRAINT unique_fffcivil_exam_attempt
        UNIQUE (roll_number)
);

CREATE INDEX IF NOT EXISTS idx_fffcivil_exam_results_roll_number
ON fffcivil_exam_results(roll_number);

-- =========================================================
-- 3. ENABLE RLS
-- =========================================================
ALTER TABLE fffcivil_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE fffcivil_exam_results ENABLE ROW LEVEL SECURITY;

-- =========================================================
-- 4. STUDENT LOGIN / VALIDATION
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fffcivil" 
ON fffcivil_students;

CREATE POLICY "Allow public select fffcivil"
ON fffcivil_students
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 5. CHECK WHETHER STUDENT ALREADY TOOK EXAM
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fffcivil results"
ON fffcivil_exam_results;

CREATE POLICY "Allow public select fffcivil results"
ON fffcivil_exam_results
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 6. ALLOW EXAM SUBMISSION
-- =========================================================
DROP POLICY IF EXISTS "Allow public insert fffcivil results"
ON fffcivil_exam_results;

CREATE POLICY "Allow public insert fffcivil results"
ON fffcivil_exam_results
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- =========================================================
-- 7. INSERT STUDENTS (3 students)
-- =========================================================
INSERT INTO fffcivil_students
    (roll_number, unique_code, is_active)
VALUES
    ('160524732002', 'fffcivil', true),
    ('160524732010', 'fffcivil', true),
    ('160524732301', 'fffcivil', true)
ON CONFLICT (roll_number)
DO NOTHING;

-- =========================================================
-- 8. VERIFY
-- =========================================================
SELECT COUNT(*) AS total_fffcivil_students
FROM fffcivil_students;

SELECT *
FROM fffcivil_students
ORDER BY roll_number;

SELECT *
FROM fffcivil_exam_results
ORDER BY created_at DESC;
