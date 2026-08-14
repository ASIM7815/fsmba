# Quick Start Guide - Adding New Students

## 🎯 I Just Added 12 New Students

### What You Need to Do NOW:

**1. Run the SQL Script in Supabase** ⚡
   - Open: https://ncwugityxjyfpreccvsp.supabase.co
   - Go to: **SQL Editor** (left sidebar)
   - Click: **New Query**
   - Copy and paste the content from: `ADD_NEW_STUDENTS.sql`
   - Click: **Run** (or press Ctrl+Enter)
   - ✅ You should see: "Success. No rows returned"

**2. Verify Students Were Added** ✔️
   ```sql
   SELECT COUNT(*) FROM students;
   ```
   - Expected result: **31 total students**

**3. View All Students** 👥
   ```sql
   SELECT roll_number, unique_code, is_active 
   FROM students 
   ORDER BY roll_number;
   ```

---

## 📋 New Students Added (12 total)

| Roll Number     | Unique Code | Status |
|----------------|-------------|---------|
| 160525672002   | fsmba2026   | Active  |
| 160525672018   | fsmba2026   | Active  |
| 160525672026   | fsmba2026   | Active  |
| 160525672033   | fsmba2026   | Active  |
| 160525672041   | fsmba2026   | Active  |
| 160525672055   | fsmba2026   | Active  |
| 160525672068   | fsmba2026   | Active  |
| 160525672110   | fsmba2026   | Active  |
| 160525672140   | fsmba2026   | Active  |
| 160525672163   | fsmba2026   | Active  |
| 160525672207   | fsmba2026   | Active  |
| 160525672219   | fsmba2026   | Active  |

**Note:** Roll number `160525672116` was already in the system, so you'll have 31 students total (not 32).

---

## 🚀 Students Can Now Take Exam

After running the SQL script:
1. ✅ All 31 students can login to exam portal
2. ✅ They use their roll number + unique code "fsmba2026"
3. ✅ Each student can take exam only once
4. ✅ Results automatically save to Supabase

---

## 🔍 Common Tasks

### Check who hasn't taken exam yet
```sql
SELECT s.roll_number 
FROM students s
LEFT JOIN exam_results e ON s.roll_number = e.roll_number
WHERE e.id IS NULL AND s.is_active = true
ORDER BY s.roll_number;
```

### Check who has taken exam
```sql
SELECT 
    e.roll_number, 
    e.correct_answers,
    e.wrong_answers,
    e.percentage,
    e.violation_detected,
    e.violation_type,
    e.created_at
FROM exam_results e
INNER JOIN students s ON e.roll_number = s.roll_number
ORDER BY e.created_at DESC;
```

### Disable a student (if needed)
```sql
UPDATE students 
SET is_active = false 
WHERE roll_number = 'ROLL_NUMBER_HERE';
```

### Re-enable a student
```sql
UPDATE students 
SET is_active = true 
WHERE roll_number = 'ROLL_NUMBER_HERE';
```

---

## 📁 Files Reference

| File | Purpose |
|------|---------|
| `ADD_NEW_STUDENTS.sql` | SQL script to add 12 new students |
| `ALL_STUDENTS_LIST.md` | Complete list of all 31 students |
| `CREATE_STUDENTS_TABLE.sql` | Original table creation (already done) |
| `CREATE_TABLE.sql` | Exam results table (already done) |
| `ADD_VIOLATION_COLUMNS.sql` | Violation tracking columns (run if not done) |

---

## ⚠️ Important Notes

1. **All students use same code:** `fsmba2026`
2. **One exam per student:** System enforces this automatically
3. **Violations tracked:** Tab switches, ESC presses logged in Supabase
4. **20 questions per exam:** Random selection from 200+ question bank
5. **30 minutes time limit:** Auto-submits when time expires

---

## 🆘 Troubleshooting

### Student can't login
1. Check if roll number exists in students table
2. Verify `is_active = true`
3. Confirm unique code is exactly `fsmba2026` (case sensitive)
4. Check if student already took exam

### SQL script errors
- Error "duplicate key": Student already exists (this is OK)
- Error "table doesn't exist": Run `CREATE_STUDENTS_TABLE.sql` first
- Error "permission denied": Check Supabase access level

### Need to reset a student's exam
```sql
-- ⚠️ Use with caution - this deletes their results
DELETE FROM exam_results 
WHERE roll_number = 'ROLL_NUMBER_HERE';
```

---

## 📞 Support Checklist

Before exam day, verify:
- [ ] All 31 students added to Supabase
- [ ] Students table has `is_active = true` for all
- [ ] Exam results table exists
- [ ] Violation columns added
- [ ] Website deployed on Vercel
- [ ] Test login with one student roll number
- [ ] Anti-cheating system tested

---

Last Updated: August 13, 2026  
Total Students: **31** (19 original + 12 new)  
Unique Code: **fsmba2026**
