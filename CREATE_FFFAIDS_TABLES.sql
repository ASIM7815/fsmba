-- =========================================================
-- FFFAIDS EXAM DATABASE
-- ONE STUDENT = ONE EXAM ATTEMPT
-- =========================================================

-- =========================================================
-- 1. STUDENTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fffaids_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_fffaids_students_roll_number
ON fffaids_students(roll_number);

-- =========================================================
-- 2. EXAM RESULTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fffaids_exam_results (
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
    CONSTRAINT unique_fffaids_exam_attempt
        UNIQUE (roll_number)
);

CREATE INDEX IF NOT EXISTS idx_fffaids_exam_results_roll_number
ON fffaids_exam_results(roll_number);

-- =========================================================
-- 3. ENABLE RLS
-- =========================================================
ALTER TABLE fffaids_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE fffaids_exam_results ENABLE ROW LEVEL SECURITY;

-- =========================================================
-- 4. STUDENT LOGIN / VALIDATION
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fffaids" 
ON fffaids_students;

CREATE POLICY "Allow public select fffaids"
ON fffaids_students
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 5. CHECK WHETHER STUDENT ALREADY TOOK EXAM
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fffaids results"
ON fffaids_exam_results;

CREATE POLICY "Allow public select fffaids results"
ON fffaids_exam_results
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 6. ALLOW EXAM SUBMISSION
-- =========================================================
DROP POLICY IF EXISTS "Allow public insert fffaids results"
ON fffaids_exam_results;

CREATE POLICY "Allow public insert fffaids results"
ON fffaids_exam_results
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- =========================================================
-- 7. INSERT STUDENTS (43 students)
-- =========================================================
INSERT INTO fffaids_students
    (roll_number, unique_code, is_active)
VALUES
    ('160523747100', 'fffaids', true),
    ('160524747016', 'fffaids', true),
    ('160524747018', 'fffaids', true),
    ('160524747025', 'fffaids', true),
    ('160524747026', 'fffaids', true),
    ('160524747029', 'fffaids', true),
    ('160524747033', 'fffaids', true),
    ('160524747034', 'fffaids', true),
    ('160524747035', 'fffaids', true),
    ('160524747039', 'fffaids', true),
    ('160524747040', 'fffaids', true),
    ('160524747042', 'fffaids', true),
    ('160524747043', 'fffaids', true),
    ('160524747047', 'fffaids', true),
    ('160524747050', 'fffaids', true),
    ('160524747052', 'fffaids', true),
    ('160524747053', 'fffaids', true),
    ('160524747054', 'fffaids', true),
    ('160524747055', 'fffaids', true),
    ('160524747057', 'fffaids', true),
    ('160524747060', 'fffaids', true),
    ('160524747061', 'fffaids', true),
    ('160524747063', 'fffaids', true),
    ('160524747071', 'fffaids', true),
    ('160524747077', 'fffaids', true),
    ('160524747087', 'fffaids', true),
    ('160524747089', 'fffaids', true),
    ('160524747092', 'fffaids', true),
    ('160524747097', 'fffaids', true),
    ('160524747099', 'fffaids', true),
    ('160524747101', 'fffaids', true),
    ('160524747107', 'fffaids', true),
    ('160524747110', 'fffaids', true),
    ('160524747111', 'fffaids', true),
    ('160524747112', 'fffaids', true),
    ('160524747113', 'fffaids', true),
    ('160524747114', 'fffaids', true),
    ('160524747115', 'fffaids', true),
    ('160524747116', 'fffaids', true),
    ('160524747301', 'fffaids', true),
    ('160524747303', 'fffaids', true),
    ('160524747304', 'fffaids', true),
    ('160524747305', 'fffaids', true)
ON CONFLICT (roll_number)
DO NOTHING;

-- =========================================================
-- 8. VERIFY
-- =========================================================
SELECT COUNT(*) AS total_fffaids_students
FROM fffaids_students;

SELECT *
FROM fffaids_students
ORDER BY roll_number;

SELECT *
FROM fffaids_exam_results
ORDER BY created_at DESC;
