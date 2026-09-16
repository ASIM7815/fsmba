-- =========================================================
-- FAIDS EXAM DATABASE
-- ONE STUDENT = ONE EXAM ATTEMPT
-- =========================================================

-- =========================================================
-- 1. STUDENTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS faids_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_faids_students_roll_number
ON faids_students(roll_number);

-- =========================================================
-- 2. EXAM RESULTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS faids_exam_results (
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
    CONSTRAINT unique_faids_exam_attempt
        UNIQUE (roll_number)
);

CREATE INDEX IF NOT EXISTS idx_faids_exam_results_roll_number
ON faids_exam_results(roll_number);

-- =========================================================
-- 3. ENABLE RLS
-- =========================================================
ALTER TABLE faids_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE faids_exam_results ENABLE ROW LEVEL SECURITY;

-- =========================================================
-- 4. STUDENT LOGIN / VALIDATION
-- =========================================================
DROP POLICY IF EXISTS "Allow public select faids" 
ON faids_students;

CREATE POLICY "Allow public select faids"
ON faids_students
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 5. CHECK WHETHER STUDENT ALREADY TOOK EXAM
-- =========================================================
DROP POLICY IF EXISTS "Allow public select faids results"
ON faids_exam_results;

CREATE POLICY "Allow public select faids results"
ON faids_exam_results
FOR SELECT
TO anon, authenticated
USING (true);

-- =========================================================
-- 6. ALLOW EXAM SUBMISSION
-- =========================================================
DROP POLICY IF EXISTS "Allow public insert faids results"
ON faids_exam_results;

CREATE POLICY "Allow public insert faids results"
ON faids_exam_results
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- =========================================================
-- 7. INSERT STUDENTS (16 students)
-- =========================================================
INSERT INTO faids_students
    (roll_number, unique_code, is_active)
VALUES
    ('160524735007', 'faids', true),
    ('160525747011', 'faids', true),
    ('160525747026', 'faids', true),
    ('160525747027', 'faids', true),
    ('160525747036', 'faids', true),
    ('160525747046', 'faids', true),
    ('160525747055', 'faids', true),
    ('160525747065', 'faids', true),
    ('160525747066', 'faids', true),
    ('160525747067', 'faids', true),
    ('160525747072', 'faids', true),
    ('160525747073', 'faids', true),
    ('160525747078', 'faids', true),
    ('160525747088', 'faids', true),
    ('160525747089', 'faids', true),
    ('160525747094', 'faids', true)
ON CONFLICT (roll_number)
DO NOTHING;

-- =========================================================
-- 8. VERIFY
-- =========================================================
SELECT COUNT(*) AS total_faids_students
FROM faids_students;

SELECT *
FROM faids_students
ORDER BY roll_number;

SELECT *
FROM faids_exam_results
ORDER BY created_at DESC;
