-- =========================================================
-- FFCSE EXAM DATABASE
-- ONE STUDENT = ONE EXAM ATTEMPT
-- =========================================================

-- =========================================================
-- 1. STUDENTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS ffcse_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_ffcse_students_roll_number
ON ffcse_students(roll_number);

-- =========================================================
-- 2. EXAM RESULTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS ffcse_exam_results (
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
    CONSTRAINT unique_ffcse_exam_attempt
        UNIQUE (roll_number)
);

CREATE INDEX IF NOT EXISTS idx_ffcse_exam_results_roll_number
ON ffcse_exam_results(roll_number);

-- =========================================================
-- 3. ENABLE RLS
-- =========================================================
ALTER TABLE ffcse_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE ffcse_exam_results ENABLE ROW LEVEL SECURITY;

-- =========================================================
-- 4. STUDENT LOGIN / VALIDATION
-- =========================================================
DROP POLICY IF EXISTS "Allow public select ffcse" 
ON ffcse_students;

CREATE POLICY "Allow public select ffcse"
ON ffcse_students
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 5. CHECK WHETHER STUDENT ALREADY TOOK EXAM
-- =========================================================
DROP POLICY IF EXISTS "Allow public select ffcse results"
ON ffcse_exam_results;

CREATE POLICY "Allow public select ffcse results"
ON ffcse_exam_results
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 6. ALLOW EXAM SUBMISSION
-- =========================================================
DROP POLICY IF EXISTS "Allow public insert ffcse results"
ON ffcse_exam_results;

CREATE POLICY "Allow public insert ffcse results"
ON ffcse_exam_results
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- =========================================================
-- 7. INSERT STUDENTS (10 students)
-- =========================================================
INSERT INTO ffcse_students
    (roll_number, unique_code, is_active)
VALUES
    ('160524733047', 'ffcse', true),
    ('160524733048', 'ffcse', true),
    ('160524733059', 'ffcse', true),
    ('160524733061', 'ffcse', true),
    ('160524733069', 'ffcse', true),
    ('160524733087', 'ffcse', true),
    ('160524733141', 'ffcse', true),
    ('160524733147', 'ffcse', true),
    ('160524733204', 'ffcse', true),
    ('160524733238', 'ffcse', true)
ON CONFLICT (roll_number)
DO NOTHING;

-- =========================================================
-- 8. VERIFY
-- =========================================================
SELECT COUNT(*) AS total_ffcse_students
FROM ffcse_students;

SELECT *
FROM ffcse_students
ORDER BY roll_number;

SELECT *
FROM ffcse_exam_results
ORDER BY created_at DESC;
