# 🚀 Quick Start - Deploy in 5 Minutes

## Step 1: Deploy to Vercel (2 minutes)

### Option A: One-Click Deploy Button
Click this button to deploy:

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/ASIM7815/fsmba)

### Option B: Manual Deploy
1. Go to https://vercel.com
2. Sign in with GitHub
3. Click "Add New Project"
4. Import `ASIM7815/fsmba`
5. Click "Deploy" (no configuration needed!)

## Step 2: Your Exam is Live! 🎉

After deployment, you'll get a URL like:
```
https://isl-exam-portal.vercel.app
```

## Step 3: Share with Students

Send this info to your students:

```
📝 ISL Engineering College - Online Exam

🔗 Exam Portal: https://your-app.vercel.app

📋 Your Roll Number: (one of the 19 approved roll numbers)
🔑 Unique Code: fsmba2026

⏰ Duration: 30 minutes
📊 Questions: 10 DSA multiple-choice questions

Good luck! 🎓
```

## 📋 Approved Roll Numbers

Only these 19 students can access the exam:
```
160525672063, 160525672066, 160525672080
160525672104, 160525672116, 160525672125
160525672133, 160525672143, 160525672154
160525672174, 160525672176, 160525672178
160525672179, 160525672181, 160525672184
160525672186, 160525672191, 160525672218
160525672227
```

## 🔍 Monitor Results

View exam submissions in real-time:
1. Go to https://supabase.com
2. Select your project: `ncwugityxjyfpreccvsp`
3. Table Editor → `exam_results`
4. See all student scores, answers, and timestamps

## ⚙️ Environment Variables (Optional)

Your Supabase credentials are already configured in the code:
- ✅ URL: `https://ncwugityxjyfpreccvsp.supabase.co`
- ✅ Anon Key: Already in `supabase-config.js`

No environment variables needed for Vercel deployment!

## 🐛 Troubleshooting

### Issue: Students can't login
- ✅ Check roll number is in the approved list (19 students)
- ✅ Verify unique code is exactly: `fsmba2026`
- ✅ Ensure students table exists in Supabase

### Issue: Results not saving
- ✅ Check Supabase project is active
- ✅ Verify RLS policies are enabled
- ✅ Check browser console for errors

### Issue: Questions not shuffling
- ✅ Each student should see different question order
- ✅ Verify roll number is entered correctly
- ✅ Check browser console for JavaScript errors

## 📱 Test Before Exam Day

1. Open your deployed URL
2. Login with test roll number: `160525672063`
3. Use code: `fsmba2026`
4. Complete a test exam
5. Check results in Supabase
6. Test on mobile devices

## 🔒 Security Features

✅ Only 19 authorized roll numbers can login
✅ Unique code verification (fsmba2026)
✅ Questions shuffled per student (anti-cheating)
✅ Answer choices randomized
✅ One-time exam (can't retake)
✅ 30-minute auto-submit timer
✅ Page close warning

## 📊 What Gets Saved

For each student, the system saves:
- Roll number
- Correct answers count
- Wrong answers count
- Total score and percentage
- All answer selections (JSONB)
- Question order received
- Exam completion timestamp

## 🎯 Ready to Go!

Your exam portal is now:
- ✅ Deployed on Vercel
- ✅ Connected to Supabase
- ✅ Secured with authentication
- ✅ Mobile responsive
- ✅ Production ready

For detailed documentation, see [DEPLOYMENT.md](DEPLOYMENT.md)

Good luck with your exam! 🎓📚
