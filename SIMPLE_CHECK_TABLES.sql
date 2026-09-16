-- Simple check for F-prefixed tables
-- Run this in Supabase SQL Editor

-- Check which tables exist
SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'public' 
  AND tablename LIKE '%fcse%' 
   OR tablename LIKE '%faids%' 
   OR tablename LIKE '%fit%' 
   OR tablename LIKE '%fcivil%'
   OR tablename LIKE '%ffcse%'
   OR tablename LIKE '%ffit%'
   OR tablename LIKE '%ffaids%'
   OR tablename LIKE '%ffece%'
ORDER BY tablename;
