-- =========================================================
-- FFIT EXAM DATABASE
-- ONE STUDENT = ONE EXAM ATTEMPT
-- =========================================================

-- =========================================================
-- 1. STUDENTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS ffit_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_ffit_students_roll_number
ON ffit_students(roll_number);

-- =========================================================
-- 2. EXAM RESULTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS ffit_exam_results (
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
    CONSTRAINT unique_ffit_exam_attempt
        UNIQUE (roll_number)
);

CREATE INDEX IF NOT EXISTS idx_ffit_exam_results_roll_number
ON ffit_exam_results(roll_number);

-- =========================================================
-- 3. ENABLE RLS
-- =========================================================
ALTER TABLE ffit_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE ffit_exam_results ENABLE ROW LEVEL SECURITY;

-- =========================================================
-- 4. STUDENT LOGIN / VALIDATION
-- =========================================================
DROP POLICY IF EXISTS "Allow public select ffit" 
ON ffit_students;

CREATE POLICY "Allow public select ffit"
ON ffit_students
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 5. CHECK WHETHER STUDENT ALREADY TOOK EXAM
-- =========================================================
DROP POLICY IF EXISTS "Allow public select ffit results"
ON ffit_exam_results;

CREATE POLICY "Allow public select ffit results"
ON ffit_exam_results
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 6. ALLOW EXAM SUBMISSION
-- =========================================================
DROP POLICY IF EXISTS "Allow public insert ffit results"
ON ffit_exam_results;

CREATE POLICY "Allow public insert ffit results"
ON ffit_exam_results
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- =========================================================
-- 7. INSERT STUDENTS (12 students)
-- =========================================================
INSERT INTO ffit_students
    (roll_number, unique_code, is_active)
VALUES
    ('160524737013', 'ffit', true),
    ('160524737028', 'ffit', true),
    ('160524737032', 'ffit', true),
    ('160524737035', 'ffit', true),
    ('160524737053', 'ffit', true),
    ('160524737060', 'ffit', true),
    ('160524737071', 'ffit', true),
    ('160524737072', 'ffit', true),
    ('160524737082', 'ffit', true),
    ('160524737086', 'ffit', true),
    ('160524737089', 'ffit', true),
    ('160524737090', 'ffit', true)
ON CONFLICT (roll_number)
DO NOTHING;

-- =========================================================
-- 8. VERIFY
-- =========================================================
SELECT COUNT(*) AS total_ffit_students
FROM ffit_students;

SELECT *
FROM ffit_students
ORDER BY roll_number;

SELECT *
FROM ffit_exam_results
ORDER BY created_at DESC;
