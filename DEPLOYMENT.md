# 🚀 Deployment Guide - ISL Engineering College Exam Portal

## Deploy to Vercel

### Option 1: Deploy via GitHub (Recommended)

1. **Push your code to GitHub** ✅ (Already done!)
   - Repository: https://github.com/ASIM7815/fsmba

2. **Go to Vercel**
   - Visit: https://vercel.com
   - Sign up or login with your GitHub account

3. **Import Your Repository**
   - Click "Add New Project"
   - Select "Import Git Repository"
   - Choose `ASIM7815/fsmba` from your repositories
   - Click "Import"

4. **Configure Project**
   - Project Name: `isl-exam-portal` (or any name you prefer)
   - Framework Preset: `Other` (it's a static site)
   - Root Directory: `./` (leave as default)
   - Build Command: Leave empty (no build needed)
   - Output Directory: Leave empty

5. **Environment Variables** (Optional)
   - You don't need to add any environment variables
   - The Supabase keys are already in `supabase-config.js`
   - The `anon` key is safe to expose in client-side code

6. **Deploy**
   - Click "Deploy"
   - Wait 1-2 minutes for deployment to complete
   - You'll get a URL like: `https://isl-exam-portal.vercel.app`

7. **Custom Domain** (Optional)
   - Go to Project Settings > Domains
   - Add your custom domain if you have one

### Option 2: Deploy via Vercel CLI

```bash
# Install Vercel CLI
npm install -g vercel

# Navigate to your project
cd /home/newuser/Desktop/FSMBA/fsmba

# Login to Vercel
vercel login

# Deploy
vercel

# Deploy to production
vercel --prod
```

---

## 📋 Pre-Deployment Checklist

### ✅ Already Completed:
- [x] Created `vercel.json` configuration
- [x] Set up Supabase tables (students & exam_results)
- [x] Added all 19 authorized roll numbers
- [x] Configured CORS headers
- [x] Added `.gitignore` to protect sensitive files
- [x] Pushed code to GitHub

### ⚠️ Before Going Live:

1. **Test Locally**
   ```bash
   cd /home/newuser/Desktop/FSMBA/fsmba
   python3 -m http.server 8000
   # Open http://localhost:8000
   ```

2. **Test Supabase Connection**
   - Open `test-supabase.html`
   - Run all three tests
   - Ensure all pass ✅

3. **Test Full Exam Flow**
   - Login with a roll number (e.g., 160525672063)
   - Complete the exam
   - Verify results are saved in Supabase

4. **Verify Supabase RLS Policies**
   - Go to Supabase Dashboard > Authentication > Policies
   - Ensure `students` table has read access
   - Ensure `exam_results` table has insert and read access

---

## 🌐 After Deployment

### Update Supabase Allowed Origins (if needed)

1. Go to Supabase Dashboard
2. Settings > API > CORS
3. Add your Vercel URL: `https://your-app.vercel.app`

### Share Exam Link

Once deployed, share this with students:
```
https://your-app.vercel.app

Roll Numbers: (19 authorized students)
Unique Code: fsmba2026
```

---

## 🔒 Security Notes

### What's Safe to Expose:
- ✅ Supabase URL
- ✅ Supabase `anon` (public) key
- ✅ Student roll numbers
- ✅ Unique code (fsmba2026)

### What's Protected:
- 🔒 Supabase service role key (never in client code)
- 🔒 Database admin credentials
- 🔒 Row Level Security (RLS) policies protect data

### Why Anon Key is Safe:
- It's designed for client-side use
- RLS policies control what can be accessed
- Students can only insert their own results
- Students can only read their own exam status
- No sensitive data is exposed

---

## 📊 Monitoring After Deployment

### Check Exam Submissions:
1. Go to Supabase Dashboard
2. Table Editor > `exam_results`
3. View all submissions in real-time

### View Authorized Students:
1. Go to Supabase Dashboard
2. Table Editor > `students`
3. See all 19 roll numbers

---

## 🐛 Troubleshooting

### Issue: "Invalid API Key" Error
**Solution**: Check Supabase API key in `supabase-config.js`

### Issue: "Student Not Found" Error
**Solution**: Verify student roll number exists in `students` table

### Issue: Database Connection Failed
**Solution**: 
- Check Supabase project is active
- Verify RLS policies are set correctly
- Check browser console for specific errors

### Issue: Vercel Build Failed
**Solution**: 
- Ensure `vercel.json` is present
- Check all files are committed to Git
- Try deploying via Vercel dashboard instead of CLI

---

## 🔄 Continuous Deployment

Vercel automatically redeploys when you push to GitHub:

```bash
# Make changes locally
git add .
git commit -m "Update exam questions"
git push origin main

# Vercel automatically deploys the changes
# New version live in ~2 minutes
```

---

## 📱 Mobile Testing

After deployment, test on:
- ✅ Desktop browsers (Chrome, Firefox, Safari)
- ✅ Mobile browsers (iOS Safari, Chrome Android)
- ✅ Different screen sizes
- ✅ Tablet devices

---

## 🎯 Going Live Checklist

- [ ] Deploy to Vercel
- [ ] Test with all 19 roll numbers
- [ ] Verify timer works correctly
- [ ] Check results save to database
- [ ] Test on mobile devices
- [ ] Share link with students
- [ ] Monitor first few submissions
- [ ] Be available for support during exam

---

## 📞 Support

For deployment issues:
- Vercel Docs: https://vercel.com/docs
- Supabase Docs: https://supabase.com/docs

Good luck with your exam! 🎓
