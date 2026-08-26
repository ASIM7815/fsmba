# 🎓 Civil Engineering Exam System

## Overview
Complete exam system for Civil Engineering students using the same Git/Linux/GitHub/Networking questions as CSE department, with random selection.

---

## 📊 System Details

### Student Information
| Parameter | Details |
|-----------|---------|
| **Total Students** | 28 students |
| **Roll Number Range** | 160525732001 - 160525732028 |
| **Unique Code** | `fscivil` |
| **Question Pool** | Same as CSE (60 questions) |
| **Questions per Exam** | 20 (randomly selected) |

### Question Topics
- **Git Commands:** clone, init, add, commit, push, fetch, log, branch, merge, reset, revert
- **Linux Commands:** chmod, chown, df, du, systemctl, rsync, dmesg, kill, ps, top
- **GitHub Features:** Fork, Pull Request, Project Boards, Issues, GitHub Actions
- **Networking:** ping, netstat, ss, ip addr, curl, wget
- **System Administration:** auditd, SELinux, fail2ban, SSH, cron, at

---

## 🗄️ Database Tables

### Table 1: civil_students
**Purpose:** Store Civil Engineering student information

**Schema:**
```sql
- id: SERIAL PRIMARY KEY
- roll_number: TEXT UNIQUE NOT NULL
- unique_code: TEXT NOT NULL
- student_name: TEXT
- created_at: TIMESTAMP WITH TIME ZONE DEFAULT NOW()
```

**Students:** 28 (160525732001-160525732028)

### Table 2: civil_exam_results
**Purpose:** Store exam results and violations

**Schema:**
```sql
- id: SERIAL PRIMARY KEY
- roll_number: TEXT NOT NULL
- unique_code: TEXT NOT NULL
- score: INTEGER NOT NULL
- total_questions: INTEGER NOT NULL DEFAULT 20
- correct_answers: INTEGER NOT NULL
- wrong_answers: INTEGER NOT NULL
- percentage: NUMERIC(5,2) NOT NULL
- time_taken: INTEGER (seconds)
- submitted_at: TIMESTAMP WITH TIME ZONE DEFAULT NOW()
- additional_data: JSONB (violations, metadata)
```

---

## 🚀 Setup Instructions

### Step 1: Create Tables in Supabase
1. Go to Supabase Dashboard: https://ncwugityxjyfpreccvsp.supabase.co
2. Click **SQL Editor**
3. Open file: `CREATE_CIVIL_TABLES.sql`
4. Click **Run**
5. Verify: "28 rows inserted" message

### Step 2: Verify Integration (Already Done)
✅ `supabase-config.js` - Detects `fscivil` code  
✅ `script.js` - Loads CSE questions for Civil students  
✅ `cse-questions.js` - Question pool ready

### Step 3: Test Login
```
Roll Number: 160525732001
Unique Code: fscivil
Expected: Login successful ✅
```

---

## 🎯 How It Works

### Random Question Selection
1. **Question Pool:** 60 questions (same as CSE)
2. **Selection:** Fisher-Yates shuffle algorithm
3. **Per Student:** 20 random questions
4. **Unique:** Every student gets different questions

### Example Flow:
```
Student 160525732001 logs in
↓
Validates against civil_students table
↓
Loads 60 Git/Linux questions
↓
Randomly selects 20 questions
↓
Student takes exam (30 minutes)
↓
Results saved to civil_exam_results
```

---

## 📋 Complete Student List

### Roll Numbers:
```
160525732001, 160525732002, 160525732003, 160525732004, 160525732005,
160525732006, 160525732007, 160525732008, 160525732009, 160525732010,
160525732011, 160525732012, 160525732013, 160525732014, 160525732015,
160525732016, 160525732017, 160525732018, 160525732019, 160525732020,
160525732021, 160525732022, 160525732023, 160525732024, 160525732025,
160525732026, 160525732027, 160525732028
```

---

## 🔒 Security Features

All standard security features apply:
- ✅ Anti-cheating system
- ✅ Fullscreen enforcement
- ✅ ESC warning (10-second countdown)
- ✅ Tab switch detection → auto-submit
- ✅ Anti-inspect protection (F12, right-click blocked)
- ✅ DevTools detection → auto-submit
- ✅ Text selection disabled
- ✅ Copy/paste blocked
- ✅ One-time exam enforcement
- ✅ 30-minute timer
- ✅ Violation logging

---

## 📊 All Exam Systems (Updated)

| System | Students | Code | Questions | Status |
|--------|----------|------|-----------|--------|
| **FSMBA** | 31 | fsmba2026 | 200+ Stock Market | ✅ Live |
| **MBA Regular** | 229 | fsmba03 | 150 TallyPrime | ✅ Live |
| **Stock Market** | 1 | fsmba100 | 200+ Stock Market | ✅ Live |
| **CSE** | 240 | fscse01 | 60 Git/Linux | ✅ Ready* |
| **Civil** | 28 | fscivil | 60 Git/Linux | ✅ Ready* |

**Total: 529 students across 5 exam systems!**

*Requires SQL execution in Supabase

---

## 🧪 Testing

### Test Login:
```
Roll Number: 160525732001
Unique Code: fscivil
```

### Expected Behavior:
1. ✅ Login page validates successfully
2. ✅ Instructions page displays
3. ✅ "Start Exam in Fullscreen" button
4. ✅ 20 random Git/Linux questions appear
5. ✅ Timer starts at 30:00
6. ✅ Navigation works (Previous/Next)
7. ✅ Submit shows results
8. ✅ Results save to `civil_exam_results` table

---

## 📝 Files Created/Updated

### New Files:
1. ✅ `CREATE_CIVIL_TABLES.sql` - Database setup script
2. ✅ `CIVIL_SYSTEM_SETUP.md` - This documentation

### Updated Files:
1. ✅ `supabase-config.js` - Added fscivil detection
2. ✅ `script.js` - Added CIVIL exam type handling

### Existing Files (Used):
1. ✅ `cse-questions.js` - Shared question pool
2. ✅ `questions-loader.js` - Security wrapper
3. ✅ `index.html` - Portal entry point

---

## 🎯 Key Differences: CSE vs Civil

| Feature | CSE | Civil |
|---------|-----|-------|
| Students | 240 | 28 |
| Code | fscse01 | fscivil |
| Questions | 60 Git/Linux | 60 Git/Linux (same) |
| Tables | cse_students, cse_exam_results | civil_students, civil_exam_results |
| Question Pool | cse-questions.js | cse-questions.js (shared) |

**Key Point:** Both use the SAME question pool, but different student tables and result tables!

---

## 🎊 Summary

### What's Complete:
- ✅ 28 Civil Engineering students configured
- ✅ Database tables designed
- ✅ SQL creation script ready
- ✅ Code integration complete
- ✅ Question pool ready (60 questions)
- ✅ Random selection (20 per student)
- ✅ All security features active
- ✅ Ready for deployment

### What You Need to Do:
1. ⏳ Run `CREATE_CIVIL_TABLES.sql` in Supabase SQL Editor
2. ⏳ Test with roll number 160525732001, code fscivil
3. ⏳ Verify results save to `civil_exam_results` table

**Civil Engineering exam system is fully integrated and ready to go!** 🚀🎉

---

**Last Updated:** August 13, 2026
