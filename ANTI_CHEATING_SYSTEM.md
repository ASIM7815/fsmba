# Anti-Cheating System Documentation

## Overview
The exam portal has a two-tier anti-cheating violation system to maintain exam integrity while giving students one chance to correct accidental violations.

## Violation System

### 🟡 Tier 1: Warning (ESC Key / Fullscreen Exit)
**What happens:**
- Student presses ESC or exits fullscreen mode
- A warning popup appears immediately
- Student has **10 seconds** to return to fullscreen
- A countdown timer is displayed in the popup

**Student actions:**
- Click "Return to Fullscreen" button
- Exam continues normally if they return in time
- **If 10 seconds pass without returning:** Auto-submit with "Failed to Return to Fullscreen" violation

**Important:** This warning is only given ONCE per exam session.

---

### 🔴 Tier 2: Immediate Auto-Submit
**Triggers instant auto-submit:**
1. **Tab Switch** - Student switches to another browser tab (Ctrl+Tab, clicking another tab)
2. **Window Switch** - Student switches to another application (Alt+Tab)
3. **Second Violation** - Student exits fullscreen AGAIN after already receiving a warning
4. **Multiple Violations** - Any violation after the warning has been given

**What happens on auto-submit:**
- Exam is immediately submitted with current score (even if 0/20)
- All unanswered questions count as wrong
- Timer stops
- Results are saved to Supabase with violation details

---

## Technical Implementation

### Monitoring Events
```javascript
// Tab visibility changes
document.addEventListener('visibilitychange', handleVisibilityChange);

// Fullscreen changes
document.addEventListener('fullscreenchange', handleFullscreenChange);

// Window blur (switching apps)
window.addEventListener('blur', handleWindowBlur);
```

### Violation Tracking
Each exam result in Supabase includes:
- `violation_type` - Description of violation (e.g., "Tab Switch Detected")
- `violation_detected` - Boolean flag (true/false)

### Warning System Logic
```
First ESC press:
  → Show warning modal
  → Start 10-second countdown
  → warningGiven = true
  
  If student returns to fullscreen within 10s:
    → Continue exam normally
    
  If timeout or ANY other violation:
    → Auto-submit immediately
```

---

## Student Experience Flow

### Scenario 1: Accidental ESC Press
1. Student accidentally presses ESC during exam
2. **Warning popup appears:** "⚠️ WARNING: Fullscreen Exited"
3. Countdown shows: 10... 9... 8...
4. Student clicks "Return to Fullscreen"
5. ✅ Exam continues normally

### Scenario 2: Tab Switch Attempt
1. Student tries to open new tab (Ctrl+T or clicks another tab)
2. ❌ **Immediate auto-submit**
3. Alert: "EXAM VIOLATION DETECTED: Tab Switch Detected"
4. Exam submitted with current score
5. Results page shows violation warning in red

### Scenario 3: Multiple Fullscreen Exits
1. Student presses ESC → Gets warning
2. Student returns to fullscreen
3. Student presses ESC AGAIN
4. ❌ **Immediate auto-submit** (no second warning)
5. Violation: "Second Violation - Fullscreen Exit After Warning"

---

## Database Storage

### exam_results Table
```sql
CREATE TABLE exam_results (
    id BIGSERIAL PRIMARY KEY,
    roll_number TEXT NOT NULL,
    correct_answers INTEGER NOT NULL,
    wrong_answers INTEGER NOT NULL,
    total_questions INTEGER NOT NULL,
    percentage NUMERIC(5,2) NOT NULL,
    user_answers JSONB,
    additional_data JSONB,
    violation_type TEXT,           -- e.g., "Tab Switch Detected"
    violation_detected BOOLEAN,    -- true/false
    created_at TIMESTAMP DEFAULT NOW()
);
```

### Violation Types
- `"Tab Switch Detected"` - Student switched browser tabs
- `"Window Switch Detected"` - Student switched to another application
- `"Fullscreen Exit Detected"` - First fullscreen exit (with warning)
- `"Second Violation - Fullscreen Exit After Warning"` - ESC pressed after warning
- `"Failed to Return to Fullscreen"` - Didn't return within 10 seconds

---

## Admin Review

### Checking Violations in Supabase
1. Open Supabase Dashboard: https://ncwugityxjyfpreccvsp.supabase.co
2. Navigate to Table Editor → exam_results
3. Filter by `violation_detected = true`
4. Review `violation_type` column for details

### Interpreting Results
- **No violation** (`violation_detected = false`): Student completed exam normally
- **With violation** (`violation_detected = true`): Check `violation_type` for reason
- **Low score + violation**: May indicate cheating attempt caught
- **High score + violation**: May be accidental (review case-by-case)

---

## Testing the System

### Test Case 1: Warning Works
1. Start exam
2. Press ESC
3. ✅ Warning should appear with 10-second countdown
4. Click "Return to Fullscreen"
5. ✅ Exam should continue

### Test Case 2: Tab Switch Auto-Submit
1. Start exam
2. Press Ctrl+T or Ctrl+Tab
3. ✅ Should auto-submit immediately
4. ✅ Results page should show red violation warning

### Test Case 3: Timeout on Warning
1. Start exam
2. Press ESC
3. Wait full 10 seconds without clicking button
4. ✅ Should auto-submit with "Failed to Return to Fullscreen"

### Test Case 4: No Second Chance
1. Start exam
2. Press ESC → Return to fullscreen
3. Press ESC again
4. ✅ Should auto-submit immediately (no second warning)

---

## Configuration

### Modify Warning Timeout
In `script.js`, find `showFullscreenWarning()`:
```javascript
let countdown = 10; // Change this value (in seconds)
```

### Disable Specific Monitoring
Comment out unwanted event listeners in `startMonitoring()`:
```javascript
// To disable tab switch detection:
// document.addEventListener('visibilitychange', handleVisibilityChange);

// To disable window blur detection:
// window.addEventListener('blur', handleWindowBlur);
```

---

## Security Notes

1. **Browser Detection**: Some browser security features may interfere with fullscreen detection
2. **Mobile Devices**: Fullscreen behavior varies on mobile browsers
3. **Browser Compatibility**: Tested on Chrome, Firefox, Edge (latest versions)
4. **VPN/Proxy**: Does not affect anti-cheating system
5. **Multiple Monitors**: Window blur detects switching to other screens

---

## Support

For issues or questions:
1. Check browser console for error messages
2. Verify Supabase connection is active
3. Ensure JavaScript is enabled
4. Test on supported browsers (Chrome, Firefox, Edge)

Last Updated: August 13, 2026
