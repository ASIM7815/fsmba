# ISL Engineering College - Online Exam Portal

## 🎓 Overview
A secure online examination system for ISL Engineering College students with real-time validation, question shuffling, and automatic result storage.

## ✨ Features

### 🔐 Security
- **Roll Number Validation**: Only 19 pre-approved students can access the exam
- **Unique Code Authentication**: Single shared code (fsmba2026) for all students
- **One-Time Exam**: Prevents students from retaking the exam
- **Anti-Cheating**: Questions and answer choices shuffled per student
- **Page Close Warning**: Alerts students before leaving the exam page

### 📝 Exam Features
- **10 DSA Questions**: Multiple-choice questions on Data Structures & Algorithms
- **30-Minute Timer**: Auto-submit when time expires
- **Navigation**: Move between questions with Previous/Next buttons
- **Answer Selection**: Click to select/change answers
- **Submission Confirmation**: Custom modal popup before final submission

### 📊 Results
- **Instant Results**: Immediate feedback after submission
- **Detailed Scoring**: Shows correct answers, wrong answers, percentage
- **Automatic Storage**: Results saved to Supabase database
- **Roll Number Tracking**: All results linked to student roll numbers

### 🎨 Design
- **White & Blue Theme**: Clean, professional interface
- **Background Image**: Custom background (backimage.png)
- **Green Header**: ISL ENGINEERING COLLEGE in green color
- **Responsive**: Works on desktop, tablet, and mobile devices
- **Smooth Animations**: Modal popups with fade-in effects

## 🚀 Deployment

This project is ready to deploy on Vercel!

### Quick Deploy to Vercel

1. **Via GitHub** (Recommended):
   - Go to [Vercel](https://vercel.com)
   - Click "Import Project" 
   - Select this repository: `ASIM7815/fsmba`
   - Click "Deploy"
   - Your site will be live at: `https://your-project.vercel.app`

2. **Via Vercel CLI**:
   ```bash
   npm install -g vercel
   vercel login
   vercel --prod
   ```

3. **Manual Upload**:
   - Zip all files
   - Upload to any static hosting (Netlify, GitHub Pages, etc.)

See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed deployment instructions.

---

## 📋 Approved Students
Only the following roll numbers can access the exam:
- 160525672063, 160525672066, 160525672080
- 160525672104, 160525672116, 160525672125
- 160525672133, 160525672143, 160525672154
- 160525672174, 160525672176, 160525672178
- 160525672179, 160525672181, 160525672184
- 160525672186, 160525672191, 160525672218
- 160525672227

**Unique Code**: fsmba2026

## 🗄️ Database Setup

### Step 1: Create Students Table
1. Go to your Supabase project: https://ncwugityxjyfpreccvsp.supabase.co
2. Navigate to the SQL Editor
3. Run the SQL from `CREATE_STUDENTS_TABLE.sql` to:
   - Create the `students` table
   - Insert all 19 authorized roll numbers with their unique codes
   - Set up proper indexes and security policies

### Step 2: Create Exam Results Table
1. In the same SQL Editor
2. Run the SQL from `CREATE_TABLE.sql` to create the `exam_results` table
3. This will store all exam submissions with scores and answers

### Database Tables

#### students table
Stores authorized students who can take the exam:
```sql
students (
  id,
  roll_number (unique),
  unique_code,
  is_active,
  created_at
)
```

#### exam_results table
Stores exam results after submission:
```sql
exam_results (
  id,
  roll_number,
  correct_answers,
  wrong_answers,
  total_questions,
  percentage,
  score,
  user_answers (JSONB),
  shuffled_questions (JSONB),
  exam_date,
  exam_completed,
  created_at
)
```

## 🚀 How to Use

### For Administrators
1. Ensure `backimage.png` is in the fsmba folder
2. Set up the Supabase table using `CREATE_TABLE.sql`
3. Open `index.html` in a web browser or deploy to a web server
4. Share the exam link with approved students

### For Students
1. Open the exam portal
2. Enter your **Roll Number** (must be from approved list)
3. Enter **Unique Code**: fsmba2026
4. Click **Continue**
5. Read the instructions carefully
6. Click **Start Exam**
7. Answer all 10 questions within 30 minutes
8. Click **Submit Exam** when done
9. View your results immediately

## 🔄 Question Shuffling
Each student receives:
- Questions in **random order**
- Answer choices **shuffled** for each question
- Same content, different arrangement
- Prevents copying from neighboring students

### Example
**Student A sees:**
- Question 5: "What is binary search complexity?"
  - A) O(n log n)
  - B) O(log n) ✓
  - C) O(n)
  - D) O(1)

**Student B sees:**
- Question 2: "What is binary search complexity?"
  - A) O(1)
  - B) O(n)
  - C) O(log n) ✓
  - D) O(n log n)

## 📁 File Structure
```
fsmba/
├── index.html              # Main HTML file
├── styles.css              # CSS styling
├── script.js               # Main JavaScript logic
├── supabase-config.js      # Supabase configuration & functions
├── backimage.png           # Background image
├── .env                    # Environment variables (not for production)
├── CREATE_TABLE.sql        # Database schema
└── README.md              # This file
```

## 🔧 Configuration Files

### supabase-config.js
- Supabase client initialization
- Roll number validation
- Unique code verification
- Result submission functions
- Exam status checking

### script.js
- Question shuffling algorithm
- Timer management
- Answer tracking
- Page navigation
- Result calculation

## 🛠️ Technologies Used
- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Database**: Supabase (PostgreSQL)
- **Authentication**: Client-side validation
- **Styling**: Custom CSS with gradients and animations

## 📝 Notes for Future Updates
- Questions are currently hardcoded in `script.js`
- To update questions: Modify the `baseQuestions` array
- To change exam duration: Update `timeRemaining` variable (in seconds)
- To add/remove students: Update `ALLOWED_ROLL_NUMBERS` array
- To change unique code: Update `CORRECT_UNIQUE_CODE` constant

## 🔒 Security Considerations
- Current setup uses client-side validation
- For production, consider:
  - Server-side validation
  - API endpoints for result submission
  - JWT authentication
  - Rate limiting
  - Encrypted connections (HTTPS)

## 📞 Support
For issues or questions, contact the ISL Engineering College IT department.

## 📄 License
© 2026 ISL Engineering College. All rights reserved.
