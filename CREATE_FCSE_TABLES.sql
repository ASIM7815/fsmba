-- =========================================================
-- FCSE EXAM DATABASE
-- ONE STUDENT = ONE EXAM ATTEMPT
-- =========================================================

-- =========================================================
-- 1. STUDENTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fcse_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_fcse_students_roll_number
ON fcse_students(roll_number);

-- =========================================================
-- 2. EXAM RESULTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fcse_exam_results (
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
    CONSTRAINT unique_fcse_exam_attempt
        UNIQUE (roll_number)
);

CREATE INDEX IF NOT EXISTS idx_fcse_exam_results_roll_number
ON fcse_exam_results(roll_number);

-- =========================================================
-- 3. ENABLE RLS
-- =========================================================
ALTER TABLE fcse_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE fcse_exam_results ENABLE ROW LEVEL SECURITY;

-- =========================================================
-- 4. STUDENT LOGIN / VALIDATION
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fcse" 
ON fcse_students;

CREATE POLICY "Allow public select fcse"
ON fcse_students
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 5. CHECK WHETHER STUDENT ALREADY TOOK EXAM
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fcse results"
ON fcse_exam_results;

CREATE POLICY "Allow public select fcse results"
ON fcse_exam_results
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 6. ALLOW EXAM SUBMISSION
-- =========================================================
DROP POLICY IF EXISTS "Allow public insert fcse results"
ON fcse_exam_results;

CREATE POLICY "Allow public insert fcse results"
ON fcse_exam_results
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- =========================================================
-- 7. INSERT STUDENTS (39 students)
-- =========================================================
INSERT INTO fcse_students
    (roll_number, unique_code, is_active)
VALUES
    ('160525733004', 'fcse', true),
    ('160525733013', 'fcse', true),
    ('160525733021', 'fcse', true),
    ('160525733022', 'fcse', true),
    ('160525733025', 'fcse', true),
    ('160525733037', 'fcse', true),
    ('160525733040', 'fcse', true),
    ('160525733053', 'fcse', true),
    ('160525733054', 'fcse', true),
    ('160525733055', 'fcse', true),
    ('160525733063', 'fcse', true),
    ('160525733070', 'fcse', true),
    ('160525733072', 'fcse', true),
    ('160525733084', 'fcse', true),
    ('160525733089', 'fcse', true),
    ('160525733090', 'fcse', true),
    ('160525733093', 'fcse', true),
    ('160525733095', 'fcse', true),
    ('160525733096', 'fcse', true),
    ('160525733100', 'fcse', true),
    ('160525733101', 'fcse', true),
    ('160525733108', 'fcse', true),
    ('160525733110', 'fcse', true),
    ('160525733131', 'fcse', true),
    ('160525733133', 'fcse', true),
    ('160525733136', 'fcse', true),
    ('160525733138', 'fcse', true),
    ('160525733142', 'fcse', true),
    ('160525733143', 'fcse', true),
    ('160525733148', 'fcse', true),
    ('160525733149', 'fcse', true),
    ('160525733158', 'fcse', true),
    ('160525733163', 'fcse', true),
    ('160525733167', 'fcse', true),
    ('160525733170', 'fcse', true),
    ('160525733172', 'fcse', true),
    ('160525733186', 'fcse', true),
    ('160525733213', 'fcse', true),
    ('160525733214', 'fcse', true)
ON CONFLICT (roll_number)
DO NOTHING;

-- =========================================================
-- 8. VERIFY
-- =========================================================
SELECT COUNT(*) AS total_fcse_students
FROM fcse_students;

SELECT *
FROM fcse_students
ORDER BY roll_number;

SELECT *
FROM fcse_exam_results
ORDER BY created_at DESC;
