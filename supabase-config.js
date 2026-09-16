// Supabase Configuration
// For production (Vercel), these will be replaced by environment variables
// For local development, update these values directly
let SUPABASE_URL = 'https://ncwugityxjyfpreccvsp.supabase.co';
let SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5jd3VnaXR5eGp5ZnByZWNjdnNwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODY2MzgwMDQsImV4cCI6MjEwMjIxNDAwNH0.7SqtNMBdXUgVy2hrOGmfknt8mViCAdfqZdh5bp-7HUs';

// Note: In a production environment, these should ideally come from environment variables
// But since this is a static site, we keep them here (the anon key is safe to expose)

// Initialize Supabase client (wait for supabase library to load)
let supabaseClient;

// Initialize when script loads
if (typeof supabase !== 'undefined') {
    supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
} else {
    console.error('Supabase library not loaded');
}

// Detect exam type based on unique code
function detectExamType(uniqueCode) {
    if (uniqueCode === 'fsmba2026') {
        return {
            type: 'FSMBA',
            studentsTable: 'students',
            resultsTable: 'exam_results'
        };
    } else if (uniqueCode === 'fsmba03') {
        return {
            type: 'MBA_REGULAR',
            studentsTable: 'mba_regular_students',
            resultsTable: 'mba_regular_exam_results'
        };
    } else if (uniqueCode === 'fsmba100') {
        return {
            type: 'STOCK_MARKET',
            studentsTable: 'students',
            resultsTable: 'exam_results'
        };
    } else if (uniqueCode === 'fscse01') {
        return {
            type: 'CSE',
            studentsTable: 'cse_students',
            resultsTable: 'cse_exam_results'
        };
    } else if (uniqueCode === 'fscivil') {
        return {
            type: 'CIVIL',
            studentsTable: 'civil_students',
            resultsTable: 'civil_exam_results'
        };
    } else if (uniqueCode === 'fsece') {
        return {
            type: 'ECE',
            studentsTable: 'ece_students',
            resultsTable: 'ece_exam_results'
        };
    } else if (uniqueCode === 'fsit') {
        return {
            type: 'IT',
            studentsTable: 'it_students',
            resultsTable: 'it_exam_results'
        };
    } else if (uniqueCode === 'fsaids') {
        return {
            type: 'AIDS',
            studentsTable: 'aids_students',
            resultsTable: 'aids_exam_results'
        };
    } else if (uniqueCode === 'fs4cse02') {
        return {
            type: 'THIRDCSE',
            studentsTable: 'thirdcse_students',
            resultsTable: 'thirdcse_exam_results'
        };
    } else if (uniqueCode === 'fs4it02') {
        return {
            type: 'THIRDIT',
            studentsTable: 'thirditrollno',
            resultsTable: 'thirdit_exam_results',
            sessionsTable: 'thirdit_active_sessions'
        };
    } else if (uniqueCode === 'fs1cse') {
        return {
            type: 'FS1CSE',
            studentsTable: 'fs1cse_students',
            resultsTable: 'fs1cse_exam_results',
            sessionsTable: 'fs1cse_active_sessions'
        };
    } else if (uniqueCode === 'fs1aids') {
        return {
            type: 'FS1AIDS',
            studentsTable: 'fs1aids_students',
            resultsTable: 'fs1aids_exam_results',
            sessionsTable: 'fs1aids_active_sessions'
        };
    } else if (uniqueCode === 'fsit') {
        return {
            type: 'FS1IT',
            studentsTable: 'fs1it_students',
            resultsTable: 'fs1it_exam_results',
            sessionsTable: 'fs1it_active_sessions'
        };
    } else if (uniqueCode === 'fscivil') {
        return {
            type: 'FS1CIVIL',
            studentsTable: 'fs1civil_students',
            resultsTable: 'fs1civil_exam_results',
            sessionsTable: 'fs1civil_active_sessions'
        };
    } else if (uniqueCode === 'fcse') {
        return {
            type: 'FCSE',
            studentsTable: 'fcse_students',
            resultsTable: 'fcse_exam_results'
        };
    } else if (uniqueCode === 'faids') {
        return {
            type: 'FAIDS',
            studentsTable: 'faids_students',
            resultsTable: 'faids_exam_results'
        };
    } else if (uniqueCode === 'fit') {
        return {
            type: 'FIT',
            studentsTable: 'fit_students',
            resultsTable: 'fit_exam_results'
        };
    } else if (uniqueCode === 'fcivil') {
        return {
            type: 'FCIVIL',
            studentsTable: 'fcivil_students',
            resultsTable: 'fcivil_exam_results'
        };
    }
    return null;
}

// Validate student credentials against database
async function validateCredentials(rollNumber, uniqueCode) {
    if (!supabaseClient) {
        return {
            valid: false,
            error: 'Database connection not available. Please try again later.'
        };
    }

    // Detect which exam system to use
    const examType = detectExamType(uniqueCode);
    if (!examType) {
        return {
            valid: false,
            error: 'Invalid unique code. Please check your credentials.'
        };
    }

    try {
        // Query the appropriate students table
        const { data, error } = await supabaseClient
            .from(examType.studentsTable)
            .select('*')
            .eq('roll_number', rollNumber)
            .eq('unique_code', uniqueCode)
            .eq('is_active', true)
            .single();

        if (error) {
            // If no matching record found
            if (error.code === 'PGRST116') {
                return {
                    valid: false,
                    error: 'Invalid roll number or unique code. Please check your credentials.'
                };
            }
            console.error('Error validating credentials:', error);
            return {
                valid: false,
                error: 'Authentication error. Please try again.'
            };
        }

        // Valid credentials found
        return {
            valid: true,
            error: null,
            student: data,
            examType: examType.type
        };
    } catch (err) {
        console.error('Exception validating credentials:', err);
        return {
            valid: false,
            error: 'An error occurred during authentication. Please try again.'
        };
    }
}

// Save exam results to Supabase
async function saveExamResults(rollNumber, correctAnswers, wrongAnswers, totalQuestions, percentage, userAnswers, shuffledQuestions) {
    if (!supabaseClient) {
        console.warn('Supabase client not initialized - results will not be saved');
        return { success: true, warning: 'Results not saved - Supabase not configured' };
    }
    
    // Detect exam type from global variable (set during login)
    const examType = window.currentExamType || detectExamType(window.currentUniqueCode);
    if (!examType) {
        console.error('Exam type not detected');
        return { success: true, warning: 'Results not saved - exam type unknown' };
    }
    
    try {
        // Extract violation information if present
        const violationDetected = shuffledQuestions.violationDetected || false;
        const violationType = shuffledQuestions.violation || null;
        
        // Prepare data object based on table schema
        const resultData = {
            roll_number: rollNumber,
            correct_answers: correctAnswers,
            wrong_answers: wrongAnswers,
            total_questions: totalQuestions,
            percentage: percentage,
            user_answers: userAnswers,
            violation_detected: violationDetected,
            violation_type: violationType
        };
        
        // Add device tracking for THIRDIT, FS1CSE, FS1AIDS, FS1IT, and FS1CIVIL only
        // (FCSE, FAIDS, FIT, FCIVIL do NOT have device tracking columns)
        if (examType.type === 'THIRDIT' || examType.type === 'FS1CSE' || examType.type === 'FS1AIDS' || examType.type === 'FS1IT' || examType.type === 'FS1CIVIL') {
            if (typeof generateDeviceFingerprint !== 'undefined' && typeof getBrowserInfo !== 'undefined') {
                resultData.device_fingerprint = generateDeviceFingerprint();
                resultData.browser_info = getBrowserInfo();
                resultData.exam_started_at = window.examStartTime || new Date().toISOString();
                resultData.exam_completed_at = new Date().toISOString();
            }
        }
        
        // Add additional_data with all exam information
        resultData.additional_data = {
            score: `${correctAnswers}/${totalQuestions}`,
            shuffled_questions: shuffledQuestions,
            exam_date: new Date().toISOString(),
            exam_completed: true
        };
        
        const { data, error } = await supabaseClient
            .from(examType.resultsTable)
            .insert([resultData]);

        if (error) {
            console.error('Error saving results to Supabase:', error);
            // Don't fail the exam - just log the error
            return { success: true, warning: 'Results could not be saved to database', error: error.message };
        }
        
        // Deactivate session for THIRDIT, FS1CSE, FS1AIDS, FS1IT, and FS1CIVIL only
        // (FCSE, FAIDS, FIT, FCIVIL do NOT have session tracking)
        if (examType.type === 'THIRDIT' || examType.type === 'FS1CSE' || examType.type === 'FS1AIDS' || examType.type === 'FS1IT' || examType.type === 'FS1CIVIL') {
            if (typeof deactivateSession !== 'undefined') {
                await deactivateSession(rollNumber, window.currentUniqueCode);
            }
        }

        return { success: true, data };
    } catch (err) {
        console.error('Exception saving results:', err);
        // Don't fail the exam - just log the error
        return { success: true, warning: 'Results could not be saved', error: err.message };
    }
}

// Check if student has already taken the exam
async function checkExamStatus(rollNumber, uniqueCode) {
    if (!supabaseClient) {
        console.error('Supabase client not initialized');
        return { alreadyTaken: false, error: 'Database connection not available' };
    }
    
    // Detect exam type
    const examType = detectExamType(uniqueCode);
    if (!examType) {
        console.error('Exam type not detected');
        return { alreadyTaken: false, error: 'Exam type not identified' };
    }
    
    try {
        const { data, error } = await supabaseClient
            .from(examType.resultsTable)
            .select('*')
            .eq('roll_number', rollNumber)
            .single();

        if (error && error.code !== 'PGRST116') { // PGRST116 is "not found" error
            console.error('Error checking exam status:', error);
            return { alreadyTaken: false, error: error.message };
        }

        return { alreadyTaken: !!data, data };
    } catch (err) {
        console.error('Exception checking exam status:', err);
        return { alreadyTaken: false, error: err.message };
    }
}

// Generate device fingerprint (simple implementation)
function generateDeviceFingerprint() {
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');
    ctx.textBaseline = 'top';
    ctx.font = '14px Arial';
    ctx.fillText('Device', 2, 2);
    const canvasData = canvas.toDataURL();
    
    const fingerprint = {
        userAgent: navigator.userAgent,
        language: navigator.language,
        platform: navigator.platform,
        screen: `${screen.width}x${screen.height}x${screen.colorDepth}`,
        timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
        canvas: canvasData.substring(0, 100), // First 100 chars of canvas fingerprint
        memory: navigator.deviceMemory || 'unknown',
        hardwareConcurrency: navigator.hardwareConcurrency || 'unknown'
    };
    
    // Create a simple hash
    const fingerprintString = JSON.stringify(fingerprint);
    let hash = 0;
    for (let i = 0; i < fingerprintString.length; i++) {
        const char = fingerprintString.charCodeAt(i);
        hash = ((hash << 5) - hash) + char;
        hash = hash & hash;
    }
    
    return Math.abs(hash).toString(36);
}

// Get browser info
function getBrowserInfo() {
    return {
        userAgent: navigator.userAgent,
        language: navigator.language,
        platform: navigator.platform,
        screen: {
            width: screen.width,
            height: screen.height,
            colorDepth: screen.colorDepth
        },
        timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
        online: navigator.onLine,
        cookieEnabled: navigator.cookieEnabled,
        memory: navigator.deviceMemory || 'unknown',
        cores: navigator.hardwareConcurrency || 'unknown'
    };
}

// Check if student has an active session (for THIRDIT only)
async function checkActiveSession(rollNumber, uniqueCode) {
    if (!supabaseClient) {
        console.error('Supabase client not initialized');
        return { hasActiveSession: false, error: 'Database connection not available' };
    }
    
    const examType = detectExamType(uniqueCode);
    if (!examType || (examType.type !== 'THIRDIT' && examType.type !== 'FS1CSE' && examType.type !== 'FS1AIDS' && examType.type !== 'FS1IT' && examType.type !== 'FS1CIVIL')) {
        // Only THIRDIT, FS1CSE, FS1AIDS, FS1IT, and FS1CIVIL have session tracking
        return { hasActiveSession: false };
    }
    
    try {
        const { data, error } = await supabaseClient
            .from(examType.sessionsTable)
            .select('*')
            .eq('roll_number', rollNumber)
            .eq('is_active', true);

        if (error) {
            console.error('Error checking active session:', error);
            // If table doesn't exist or other error, just allow login
            return { hasActiveSession: false };
        }

        // Check if any active sessions exist
        if (data && data.length > 0) {
            return { 
                hasActiveSession: true, 
                sessionData: data[0],
                deviceFingerprint: data[0].device_fingerprint
            };
        }

        return { hasActiveSession: false };
    } catch (err) {
        console.error('Exception checking active session:', err);
        // On exception, allow login
        return { hasActiveSession: false };
    }
}

// Create active session (for THIRDIT, FS1CSE, FS1AIDS, FS1IT, and FS1CIVIL only)
async function createActiveSession(rollNumber, uniqueCode) {
    if (!supabaseClient) {
        console.error('Supabase client not initialized');
        return { success: false, error: 'Database connection not available' };
    }
    
    const examType = detectExamType(uniqueCode);
    if (!examType || (examType.type !== 'THIRDIT' && examType.type !== 'FS1CSE' && examType.type !== 'FS1AIDS' && examType.type !== 'FS1IT' && examType.type !== 'FS1CIVIL')) {
        return { success: true }; // Skip for other exam types
    }
    
    try {
        const deviceFingerprint = generateDeviceFingerprint();
        const browserInfo = getBrowserInfo();
        
        const sessionData = {
            roll_number: rollNumber,
            device_fingerprint: deviceFingerprint,
            browser_info: browserInfo,
            session_started_at: new Date().toISOString(),
            last_activity_at: new Date().toISOString(),
            is_active: true
        };
        
        // Try to insert, if duplicate exists, update it
        const { data, error } = await supabaseClient
            .from(examType.sessionsTable)
            .upsert(sessionData, {
                onConflict: 'roll_number',
                ignoreDuplicates: false
            });

        if (error) {
            console.error('Error creating active session:', error);
            return { success: false, error: error.message };
        }

        return { success: true, deviceFingerprint, data };
    } catch (err) {
        console.error('Exception creating active session:', err);
        return { success: false, error: err.message };
    }
}

// Deactivate session when exam is completed (for THIRDIT, FS1CSE, FS1AIDS, FS1IT, and FS1CIVIL only)
async function deactivateSession(rollNumber, uniqueCode) {
    if (!supabaseClient) {
        console.error('Supabase client not initialized');
        return { success: false, error: 'Database connection not available' };
    }
    
    const examType = detectExamType(uniqueCode);
    if (!examType || (examType.type !== 'THIRDIT' && examType.type !== 'FS1CSE' && examType.type !== 'FS1AIDS' && examType.type !== 'FS1IT' && examType.type !== 'FS1CIVIL')) {
        return { success: true }; // Skip for other exam types
    }
    
    try {
        const { data, error } = await supabaseClient
            .from(examType.sessionsTable)
            .update({ is_active: false })
            .eq('roll_number', rollNumber);

        if (error) {
            console.error('Error deactivating session:', error);
            return { success: false, error: error.message };
        }

        return { success: true, data };
    } catch (err) {
        console.error('Exception deactivating session:', err);
        return { success: false, error: err.message };
    }
}
