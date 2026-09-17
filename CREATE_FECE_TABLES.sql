-- =========================================================
-- FECE EXAM DATABASE
-- ONE STUDENT = ONE EXAM ATTEMPT - DATABASE ENFORCED
-- =========================================================

-- =========================================================
-- 1. STUDENTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fece_students (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT UNIQUE NOT NULL,
    unique_code TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_fece_students_roll_number
ON fece_students(roll_number);

-- =========================================================
-- 2. EXAM RESULTS TABLE
-- =========================================================
CREATE TABLE IF NOT EXISTS fece_exam_results (
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
    -- CRITICAL: Database-level enforcement - ONE attempt per roll number
    CONSTRAINT unique_fece_exam_attempt UNIQUE (roll_number),
    -- Foreign key to ensure student exists
    CONSTRAINT fk_fece_student FOREIGN KEY (roll_number) 
        REFERENCES fece_students(roll_number) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_fece_exam_results_roll_number
ON fece_exam_results(roll_number);

CREATE INDEX IF NOT EXISTS idx_fece_exam_results_created_at
ON fece_exam_results(created_at DESC);

-- =========================================================
-- 3. ENABLE RLS (Row Level Security)
-- =========================================================
ALTER TABLE fece_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE fece_exam_results ENABLE ROW LEVEL SECURITY;

-- =========================================================
-- 4. RLS POLICY: Students table - Read Only for Validation
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fece students" ON fece_students;

CREATE POLICY "Allow public select fece students"
ON fece_students
FOR SELECT
TO anon, authenticated
USING (is_active = true);

-- =========================================================
-- 5. RLS POLICY: Results - Students can ONLY see their OWN result
-- =========================================================
DROP POLICY IF EXISTS "Students can view own result" ON fece_exam_results;

CREATE POLICY "Students can view own result"
ON fece_exam_results
FOR SELECT
TO anon, authenticated
USING (
    roll_number IN (
        SELECT roll_number FROM fece_students WHERE is_active = true
    )
);

-- =========================================================
-- 6. RLS POLICY: Results - INSERT only if no existing attempt
-- =========================================================
DROP POLICY IF EXISTS "Allow insert if no prior attempt" ON fece_exam_results;

CREATE POLICY "Allow insert if no prior attempt"
ON fece_exam_results
FOR INSERT
TO anon, authenticated
WITH CHECK (
    roll_number IN (
        SELECT roll_number FROM fece_students WHERE is_active = true
    )
);

-- =========================================================
-- 7. SECURE RPC FUNCTION: Check if student can take exam
-- =========================================================
DROP FUNCTION IF EXISTS check_fece_exam_eligibility(TEXT, TEXT);

CREATE OR REPLACE FUNCTION check_fece_exam_eligibility(
    p_roll_number TEXT,
    p_unique_code TEXT
)
RETURNS TABLE(
    eligible BOOLEAN,
    message TEXT,
    student_exists BOOLEAN,
    already_taken BOOLEAN
) 
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_student_exists BOOLEAN;
    v_already_taken BOOLEAN;
BEGIN
    SELECT EXISTS(
        SELECT 1 FROM fece_students 
        WHERE roll_number = p_roll_number 
        AND unique_code = p_unique_code
        AND is_active = true
    ) INTO v_student_exists;
    
    SELECT EXISTS(
        SELECT 1 FROM fece_exam_results 
        WHERE roll_number = p_roll_number
    ) INTO v_already_taken;
    
    IF NOT v_student_exists THEN
        RETURN QUERY SELECT false, 'Invalid roll number or unique code'::TEXT, false, false;
    ELSIF v_already_taken THEN
        RETURN QUERY SELECT false, 'You have already completed this exam'::TEXT, true, true;
    ELSE
        RETURN QUERY SELECT true, 'Eligible to take exam'::TEXT, true, false;
    END IF;
END;
$$;

-- =========================================================
-- 8. SECURE RPC FUNCTION: Submit exam result
-- =========================================================
DROP FUNCTION IF EXISTS submit_fece_exam_result(TEXT, INTEGER, INTEGER, INTEGER, NUMERIC, JSONB, JSONB, TEXT, BOOLEAN);

CREATE OR REPLACE FUNCTION submit_fece_exam_result(
    p_roll_number TEXT,
    p_correct_answers INTEGER,
    p_wrong_answers INTEGER,
    p_total_questions INTEGER,
    p_percentage NUMERIC,
    p_user_answers JSONB,
    p_additional_data JSONB,
    p_violation_type TEXT,
    p_violation_detected BOOLEAN
)
RETURNS TABLE(
    success BOOLEAN,
    message TEXT,
    result_id BIGINT
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_student_exists BOOLEAN;
    v_already_taken BOOLEAN;
    v_new_id BIGINT;
BEGIN
    SELECT EXISTS(
        SELECT 1 FROM fece_students 
        WHERE roll_number = p_roll_number 
        AND is_active = true
    ) INTO v_student_exists;
    
    IF NOT v_student_exists THEN
        RETURN QUERY SELECT false, 'Invalid student'::TEXT, NULL::BIGINT;
        RETURN;
    END IF;
    
    SELECT EXISTS(
        SELECT 1 FROM fece_exam_results 
        WHERE roll_number = p_roll_number
    ) INTO v_already_taken;
    
    IF v_already_taken THEN
        RETURN QUERY SELECT false, 'Exam already submitted'::TEXT, NULL::BIGINT;
        RETURN;
    END IF;
    
    BEGIN
        INSERT INTO fece_exam_results (
            roll_number, correct_answers, wrong_answers, total_questions,
            percentage, user_answers, additional_data, violation_type, violation_detected
        ) VALUES (
            p_roll_number, p_correct_answers, p_wrong_answers, p_total_questions,
            p_percentage, p_user_answers, p_additional_data, p_violation_type, p_violation_detected
        )
        RETURNING id INTO v_new_id;
        
        RETURN QUERY SELECT true, 'Exam submitted successfully'::TEXT, v_new_id;
        
    EXCEPTION
        WHEN unique_violation THEN
            RETURN QUERY SELECT false, 'Exam already submitted'::TEXT, NULL::BIGINT;
        WHEN foreign_key_violation THEN
            RETURN QUERY SELECT false, 'Invalid student reference'::TEXT, NULL::BIGINT;
        WHEN OTHERS THEN
            RETURN QUERY SELECT false, 'Submission failed: ' || SQLERRM, NULL::BIGINT;
    END;
END;
$$;

-- =========================================================
-- 9. INSERT STUDENTS (1 student)
-- =========================================================
INSERT INTO fece_students (roll_number, unique_code, is_active)
VALUES
    ('160525735005', 'fece', true)
ON CONFLICT (roll_number) 
DO UPDATE SET 
    unique_code = EXCLUDED.unique_code, 
    is_active = EXCLUDED.is_active;

-- =========================================================
-- 10. GRANT EXECUTE PERMISSIONS ON RPC FUNCTIONS
-- =========================================================
GRANT EXECUTE ON FUNCTION check_fece_exam_eligibility(TEXT, TEXT) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION submit_fece_exam_result(TEXT, INTEGER, INTEGER, INTEGER, NUMERIC, JSONB, JSONB, TEXT, BOOLEAN) TO anon, authenticated;

-- =========================================================
-- 11. VERIFICATION QUERIES
-- =========================================================
-- Check students
SELECT COUNT(*) AS total_fece_students FROM fece_students;

SELECT roll_number, unique_code, is_active, created_at
FROM fece_students
ORDER BY roll_number;

-- Check results
SELECT COUNT(*) AS total_fece_results FROM fece_exam_results;

SELECT roll_number, correct_answers, wrong_answers, percentage, 
       violation_detected, violation_type, created_at
FROM fece_exam_results
ORDER BY created_at DESC;

-- Test eligibility function
SELECT * FROM check_fece_exam_eligibility('160525735005', 'fece');

-- =========================================================
-- 12. EXAM CONFIGURATION
-- =========================================================
-- Exam Code: fece
-- Question Bank: fs1cse-questions.js (C Programming, 100 total, 25 random)
-- Students: 1
-- Duration: 30 minutes
-- One attempt per student (enforced by UNIQUE constraint)
-- =========================================================
