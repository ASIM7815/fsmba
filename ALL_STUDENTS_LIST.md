# Complete Student List for Exam Portal

## Total Authorized Students: 31

All students use the same unique code: **fsmba2026**

---

## Original 19 Students
1. 160525672063
2. 160525672066
3. 160525672080
4. 160525672104
5. 160525672116 ⭐ (Also in new list)
6. 160525672125
7. 160525672133
8. 160525672143
9. 160525672154
10. 160525672174
11. 160525672176
12. 160525672178
13. 160525672179
14. 160525672181
15. 160525672184
16. 160525672186
17. 160525672191
18. 160525672218
19. 160525672227

---

## Newly Added 12 Students
20. 160525672002
21. 160525672018
22. 160525672026
23. 160525672033
24. 160525672041
25. 160525672055
26. 160525672068
27. 160525672110
28. 160525672140
29. 160525672163
30. 160525672207
31. 160525672219

---

## Notes
- ⭐ Roll number **160525672116** was in both lists (already existed)
- All students are marked as `is_active = true`
- All students share the unique code: `fsmba2026`
- Each student can take the exam only once
- Results are stored with their roll number in Supabase

---

## How to Add More Students Later

### Method 1: Using SQL Editor
```sql
INSERT INTO students (roll_number, unique_code, is_active) VALUES
('NEW_ROLL_NUMBER', 'fsmba2026', true)
ON CONFLICT (roll_number) DO NOTHING;
```

### Method 2: Using Supabase Table Editor
1. Go to Supabase Dashboard
2. Navigate to Table Editor → students
3. Click "Insert row"
4. Fill in:
   - roll_number: Student's roll number
   - unique_code: fsmba2026
   - is_active: true
5. Click "Save"

---

## How to Remove/Disable a Student

### Disable (Recommended - keeps history)
```sql
UPDATE students 
SET is_active = false 
WHERE roll_number = 'ROLL_NUMBER_HERE';
```

### Delete (Permanent - loses history)
```sql
DELETE FROM students 
WHERE roll_number = 'ROLL_NUMBER_HERE';
```

---

## Verification Queries

### Count total students
```sql
SELECT COUNT(*) FROM students;
```

### Count active students only
```sql
SELECT COUNT(*) FROM students WHERE is_active = true;
```

### Find students who haven't taken exam yet
```sql
SELECT s.roll_number 
FROM students s
LEFT JOIN exam_results e ON s.roll_number = e.roll_number
WHERE e.id IS NULL AND s.is_active = true
ORDER BY s.roll_number;
```

### Find students who have taken exam
```sql
SELECT s.roll_number, e.percentage, e.violation_detected, e.created_at
FROM students s
INNER JOIN exam_results e ON s.roll_number = e.roll_number
WHERE s.is_active = true
ORDER BY e.created_at DESC;
```

---

Last Updated: August 13, 2026
Total Students: 31 (19 original + 12 new)
