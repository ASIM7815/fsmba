-- =========================================================
-- FFFIT EXAM DATABASE
-- ONE STUDENT = ONE EXAM ATTEMPT
-- =========================================================

-- =========================================================
-- 1. STUDENTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fffit_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_fffit_students_roll_number
ON fffit_students(roll_number);

-- =========================================================
-- 2. EXAM RESULTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fffit_exam_results (
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
    CONSTRAINT unique_fffit_exam_attempt
        UNIQUE (roll_number)
);

CREATE INDEX IF NOT EXISTS idx_fffit_exam_results_roll_number
ON fffit_exam_results(roll_number);

-- =========================================================
-- 3. ENABLE RLS
-- =========================================================
ALTER TABLE fffit_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE fffit_exam_results ENABLE ROW LEVEL SECURITY;

-- =========================================================
-- 4. STUDENT LOGIN / VALIDATION
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fffit" 
ON fffit_students;

CREATE POLICY "Allow public select fffit"
ON fffit_students
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 5. CHECK WHETHER STUDENT ALREADY TOOK EXAM
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fffit results"
ON fffit_exam_results;

CREATE POLICY "Allow public select fffit results"
ON fffit_exam_results
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 6. ALLOW EXAM SUBMISSION
-- =========================================================
DROP POLICY IF EXISTS "Allow public insert fffit results"
ON fffit_exam_results;

CREATE POLICY "Allow public insert fffit results"
ON fffit_exam_results
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- =========================================================
-- 7. INSERT STUDENTS (28 students)
-- =========================================================
INSERT INTO fffit_students
    (roll_number, unique_code, is_active)
VALUES
    ('160524737005', 'fffit', true),
    ('160524737012', 'fffit', true),
    ('160524737020', 'fffit', true),
    ('160524737022', 'fffit', true),
    ('160524737028', 'fffit', true),
    ('160524737037', 'fffit', true),
    ('160524737038', 'fffit', true),
    ('160524737041', 'fffit', true),
    ('160524737045', 'fffit', true),
    ('160524737050', 'fffit', true),
    ('160524737053', 'fffit', true),
    ('160524737054', 'fffit', true),
    ('160524737056', 'fffit', true),
    ('160524737057', 'fffit', true),
    ('160524737059', 'fffit', true),
    ('160524737060', 'fffit', true),
    ('160524737061', 'fffit', true),
    ('160524737062', 'fffit', true),
    ('160524737063', 'fffit', true),
    ('160524737065', 'fffit', true),
    ('160524737070', 'fffit', true),
    ('160524737079', 'fffit', true),
    ('160524737082', 'fffit', true),
    ('160524737083', 'fffit', true),
    ('160524737084', 'fffit', true),
    ('160524737086', 'fffit', true),
    ('160524737088', 'fffit', true),
    ('160524737090', 'fffit', true)
ON CONFLICT (roll_number)
DO NOTHING;

-- =========================================================
-- 8. VERIFY
-- =========================================================
SELECT COUNT(*) AS total_fffit_students
FROM fffit_students;

SELECT *
FROM fffit_students
ORDER BY roll_number;

SELECT *
FROM fffit_exam_results
ORDER BY created_at DESC;
