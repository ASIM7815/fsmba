-- ============================================
-- FIX CIVIL TABLES - ENABLE RLS POLICIES
-- ============================================
-- The 400 error means Row Level Security is blocking reads
-- We need to enable RLS and create policies to allow public access

-- Enable RLS on civil_students table
ALTER TABLE civil_students ENABLE ROW LEVEL SECURITY;

-- Create policy to allow SELECT (read) for everyone
CREATE POLICY "Allow public read access to civil students"
ON civil_students
FOR SELECT
TO public
USING (true);

-- Enable RLS on civil_exam_results table
ALTER TABLE civil_exam_results ENABLE ROW LEVEL SECURITY;

-- Create policy to allow INSERT (write) for everyone
CREATE POLICY "Allow public insert to civil exam results"
ON civil_exam_results
FOR INSERT
TO public
WITH CHECK (true);

-- Create policy to allow SELECT (read) for everyone
CREATE POLICY "Allow public read access to civil exam results"
ON civil_exam_results
FOR SELECT
TO public
USING (true);

-- Verify policies are created
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd
FROM pg_policies
WHERE tablename IN ('civil_students', 'civil_exam_results');

-- Test query that was failing
SELECT * FROM civil_students 
WHERE roll_number = '160525732001' 
AND unique_code = 'fscivil';
