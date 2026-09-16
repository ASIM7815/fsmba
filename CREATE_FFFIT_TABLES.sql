-- =========================================================
-- FFFIT EXAM DATABASE
-- ONE STUDENT = ONE EXAM ATTEMPT - DATABASE ENFORCED
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
    CONSTRAINT unique_fffit_exam_attempt UNIQUE (roll_number),
    CONSTRAINT fk_fffit_student FOREIGN KEY (roll_number) 
        REFERENCES fffit_students(roll_number) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_fffit_exam_results_roll_number
ON fffit_exam_results(roll_number);

CREATE INDEX IF NOT EXISTS idx_fffit_exam_results_created_at
ON fffit_exam_results(created_at DESC);

-- =========================================================
-- 3. ENABLE RLS
-- =========================================================
ALTER TABLE fffit_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE fffit_exam_results ENABLE ROW LEVEL SECURITY;

-- =========================================================
-- 4. RLS POLICIES
-- =========================================================
DROP POLICY IF EXISTS "Allow public select fffit students" ON fffit_students;
CREATE POLICY "Allow public select fffit students" ON fffit_students
FOR SELECT TO anon, authenticated USING (is_active = true);

DROP POLICY IF EXISTS "Students can view own result" ON fffit_exam_results;
CREATE POLICY "Students can view own result" ON fffit_exam_results
FOR SELECT TO anon, authenticated
USING (roll_number IN (SELECT roll_number FROM fffit_students WHERE is_active = true));

DROP POLICY IF EXISTS "Allow insert if no prior attempt" ON fffit_exam_results;
CREATE POLICY "Allow insert if no prior attempt" ON fffit_exam_results
FOR INSERT TO anon, authenticated
WITH CHECK (roll_number IN (SELECT roll_number FROM fffit_students WHERE is_active = true));

-- =========================================================
-- 5. SECURE RPC FUNCTIONS
-- =========================================================
DROP FUNCTION IF EXISTS check_fffit_exam_eligibility(TEXT, TEXT);
CREATE OR REPLACE FUNCTION check_fffit_exam_eligibility(p_roll_number TEXT, p_unique_code TEXT)
RETURNS TABLE(eligible BOOLEAN, message TEXT, student_exists BOOLEAN, already_taken BOOLEAN) 
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
AS $$
DECLARE v_student_exists BOOLEAN; v_already_taken BOOLEAN;
BEGIN
    SELECT EXISTS(SELECT 1 FROM fffit_students WHERE roll_number = p_roll_number AND unique_code = p_unique_code AND is_active = true) INTO v_student_exists;
    SELECT EXISTS(SELECT 1 FROM fffit_exam_results WHERE roll_number = p_roll_number) INTO v_already_taken;
    IF NOT v_student_exists THEN RETURN QUERY SELECT false, 'Invalid roll number or unique code'::TEXT, false, false;
    ELSIF v_already_taken THEN RETURN QUERY SELECT false, 'You have already completed this exam'::TEXT, true, true;
    ELSE RETURN QUERY SELECT true, 'Eligible to take exam'::TEXT, true, false;
    END IF;
END;
$$;

DROP FUNCTION IF EXISTS submit_fffit_exam_result(TEXT, INTEGER, INTEGER, INTEGER, NUMERIC, JSONB, JSONB, TEXT, BOOLEAN);
CREATE OR REPLACE FUNCTION submit_fffit_exam_result(
    p_roll_number TEXT, p_correct_answers INTEGER, p_wrong_answers INTEGER, p_total_questions INTEGER,
    p_percentage NUMERIC, p_user_answers JSONB, p_additional_data JSONB, p_violation_type TEXT, p_violation_detected BOOLEAN
)
RETURNS TABLE(success BOOLEAN, message TEXT, result_id BIGINT)
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
AS $$
DECLARE v_student_exists BOOLEAN; v_already_taken BOOLEAN; v_new_id BIGINT;
BEGIN
    SELECT EXISTS(SELECT 1 FROM fffit_students WHERE roll_number = p_roll_number AND is_active = true) INTO v_student_exists;
    IF NOT v_student_exists THEN RETURN QUERY SELECT false, 'Invalid student'::TEXT, NULL::BIGINT; RETURN; END IF;
    SELECT EXISTS(SELECT 1 FROM fffit_exam_results WHERE roll_number = p_roll_number) INTO v_already_taken;
    IF v_already_taken THEN RETURN QUERY SELECT false, 'Exam already submitted'::TEXT, NULL::BIGINT; RETURN; END IF;
    BEGIN
        INSERT INTO fffit_exam_results (roll_number, correct_answers, wrong_answers, total_questions, percentage, user_answers, additional_data, violation_type, violation_detected)
        VALUES (p_roll_number, p_correct_answers, p_wrong_answers, p_total_questions, p_percentage, p_user_answers, p_additional_data, p_violation_type, p_violation_detected)
        RETURNING id INTO v_new_id;
        RETURN QUERY SELECT true, 'Exam submitted successfully'::TEXT, v_new_id;
    EXCEPTION
        WHEN unique_violation THEN RETURN QUERY SELECT false, 'Exam already submitted'::TEXT, NULL::BIGINT;
        WHEN foreign_key_violation THEN RETURN QUERY SELECT false, 'Invalid student reference'::TEXT, NULL::BIGINT;
        WHEN OTHERS THEN RETURN QUERY SELECT false, 'Submission failed: ' || SQLERRM, NULL::BIGINT;
    END;
END;
$$;

-- =========================================================
-- 6. INSERT STUDENTS (28 students)
-- =========================================================
INSERT INTO fffit_students (roll_number, unique_code, is_active) VALUES
('160524737005', 'fffit', true), ('160524737012', 'fffit', true), ('160524737020', 'fffit', true),
('160524737022', 'fffit', true), ('160524737028', 'fffit', true), ('160524737037', 'fffit', true),
('160524737038', 'fffit', true), ('160524737041', 'fffit', true), ('160524737045', 'fffit', true),
('160524737050', 'fffit', true), ('160524737053', 'fffit', true), ('160524737054', 'fffit', true),
('160524737056', 'fffit', true), ('160524737057', 'fffit', true), ('160524737059', 'fffit', true),
('160524737060', 'fffit', true), ('160524737061', 'fffit', true), ('160524737062', 'fffit', true),
('160524737063', 'fffit', true), ('160524737065', 'fffit', true), ('160524737070', 'fffit', true),
('160524737079', 'fffit', true), ('160524737082', 'fffit', true), ('160524737083', 'fffit', true),
('160524737084', 'fffit', true), ('160524737086', 'fffit', true), ('160524737088', 'fffit', true),
('160524737090', 'fffit', true)
ON CONFLICT (roll_number) DO UPDATE SET unique_code = EXCLUDED.unique_code, is_active = EXCLUDED.is_active;

-- =========================================================
-- 7. GRANT PERMISSIONS
-- =========================================================
GRANT EXECUTE ON FUNCTION check_fffit_exam_eligibility(TEXT, TEXT) TO anon, authenticated;
GRANT EXECUTE ON FUNCTION submit_fffit_exam_result(TEXT, INTEGER, INTEGER, INTEGER, NUMERIC, JSONB, JSONB, TEXT, BOOLEAN) TO anon, authenticated;

-- =========================================================
-- 8. VERIFICATION
-- =========================================================
SELECT COUNT(*) AS total_fffit_students FROM fffit_students;
SELECT * FROM check_fffit_exam_eligibility('160524737005', 'fffit');
