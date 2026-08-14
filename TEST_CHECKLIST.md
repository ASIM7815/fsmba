# Testing Checklist for Anti-Cheating System

## ✅ Test Before Deployment

### 1. ESC Warning System
- [ ] Start exam and press ESC
- [ ] Verify warning popup appears with countdown
- [ ] Verify countdown starts at 10 seconds
- [ ] Click "Return to Fullscreen" within 10 seconds
- [ ] Verify exam continues normally
- [ ] Verify exam is still in fullscreen

### 2. Tab Switch Detection
- [ ] Start exam
- [ ] Press Ctrl+T to open new tab
- [ ] Verify immediate auto-submit
- [ ] Verify alert shows "Tab Switch Detected"
- [ ] Verify results page shows violation warning (red box)
- [ ] Check Supabase: violation_detected = true, violation_type = "Tab Switch Detected"

### 3. Window Switch Detection
- [ ] Start exam
- [ ] Press Alt+Tab to switch to another application
- [ ] Verify immediate auto-submit
- [ ] Verify alert shows "Window Switch Detected"
- [ ] Check Supabase: violation_type = "Window Switch Detected"

### 4. ESC Timeout
- [ ] Start exam and press ESC
- [ ] Wait full 10 seconds WITHOUT clicking button
- [ ] Verify auto-submit after countdown reaches 0
- [ ] Verify alert shows "Failed to Return to Fullscreen"
- [ ] Check Supabase: violation_type = "Failed to Return to Fullscreen"

### 5. Second ESC Press (No Second Chance)
- [ ] Start exam and press ESC
- [ ] Click "Return to Fullscreen" within 10 seconds
- [ ] Exam continues
- [ ] Press ESC AGAIN
- [ ] Verify immediate auto-submit (NO warning popup)
- [ ] Verify alert shows "Second Violation - Fullscreen Exit After Warning"
- [ ] Check Supabase: violation_type = "Second Violation..."

### 6. Tab Switch After Warning
- [ ] Start exam and press ESC
- [ ] Click "Return to Fullscreen"
- [ ] Press Ctrl+Tab to switch tabs
- [ ] Verify immediate auto-submit
- [ ] Verify violation recorded in Supabase

### 7. Normal Exam Completion
- [ ] Start exam
- [ ] Answer all 20 questions
- [ ] Submit normally
- [ ] Verify results page shows NO violation warning
- [ ] Check Supabase: violation_detected = false or NULL

### 8. Timer Auto-Submit (30 minutes)
- [ ] Modify timeRemaining to 10 seconds for testing: `let timeRemaining = 10;`
- [ ] Start exam
- [ ] Wait 10 seconds
- [ ] Verify auto-submit with alert "Time is up!"
- [ ] Check Supabase: NO violation flag (normal completion)

### 9. Browser Compatibility
- [ ] Test on Chrome (latest)
- [ ] Test on Firefox (latest)
- [ ] Test on Edge (latest)
- [ ] Test on Safari (if available)

### 10. Supabase Data Integrity
- [ ] Verify all exam results are saved
- [ ] Verify violation_type is NULL for normal exams
- [ ] Verify violation_detected is false for normal exams
- [ ] Verify roll_number is correct
- [ ] Verify percentage calculation is correct
- [ ] Verify user_answers array is saved

---

## 🔧 Debug Mode Testing

### Enable Debug Console Logging
Add to script.js for detailed logs:
```javascript
function handleCheatingAttempt(reason) {
    console.log('[DEBUG] Cheating attempt detected:', reason);
    console.log('[DEBUG] examInProgress:', examInProgress);
    console.log('[DEBUG] warningGiven:', warningGiven);
    console.log('[DEBUG] tabSwitchDetected:', tabSwitchDetected);
    // ... rest of function
}
```

### Monitor Network Requests
1. Open Browser DevTools (F12)
2. Go to Network tab
3. Start exam and trigger violation
4. Verify POST request to Supabase
5. Check request payload contains violation data

---

## 📊 Acceptance Criteria

### Must Pass All:
✅ ESC gives ONE warning with 10-second countdown  
✅ Tab switch triggers immediate auto-submit  
✅ Window switch triggers immediate auto-submit  
✅ Second ESC triggers immediate auto-submit (no second warning)  
✅ Tab switch after ESC warning triggers immediate auto-submit  
✅ Timeout on ESC warning triggers auto-submit  
✅ All violations save to Supabase with correct violation_type  
✅ Normal exam completion has NO violation flag  
✅ Timer auto-submit has NO violation flag  
✅ Violation warning displays on results page (red box)  

---

## 🚨 Known Issues / Edge Cases

### Browser-Specific
- **Mobile browsers**: Fullscreen may not work on some mobile devices
- **Safari**: May require user gesture for fullscreen
- **Incognito mode**: Should work normally

### User Experience
- **Accidental ESC**: System gives 10 seconds - clearly communicated
- **Network issues**: Violation still recorded locally, saved when connection restored
- **Multiple monitors**: Window blur detects switching to other monitors

### Limitations
- Cannot detect:
  - Taking photos with phone
  - Looking at another person's screen
  - Using physical notes
  - Screen sharing software running in background

---

## 🎯 Production Readiness

### Before Going Live:
- [ ] All 10 test cases passed
- [ ] Tested with all 19 student roll numbers
- [ ] Verified Supabase connection is stable
- [ ] Verified Vercel deployment is live
- [ ] Tested on multiple browsers
- [ ] Created backup of Supabase tables
- [ ] Instructed students about fullscreen requirement
- [ ] Prepared admin guide for reviewing violations

### Monitoring During Exam:
- [ ] Monitor Supabase for incoming results
- [ ] Check for any violation patterns
- [ ] Be ready to review individual cases
- [ ] Have backup plan if system fails

---

## 📝 Post-Exam Review

### Data Analysis:
1. Total students who took exam: _____
2. Students with violations: _____
3. Most common violation type: _____
4. Average score (no violations): _____
5. Average score (with violations): _____

### Violation Review:
- Review each violation case individually
- Check if score indicates genuine cheating attempt
- Make decisions on:
  - Accept score as-is
  - Request re-take
  - Manual investigation

---

Last Updated: August 13, 2026
