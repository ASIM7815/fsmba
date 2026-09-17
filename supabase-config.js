// Supabase Configuration
// For production (Vercel), these will be replaced by environment variables
// For local development, update these values directly
let SUPABASE_URL = 'https://wofjapxwmowdhxchcjqs.supabase.co';
let SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndvZmphcHh3bW93ZGh4Y2hjanFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODk1MzU3ODksImV4cCI6MjEwNTExMTc4OX0.ESoYWOVmv-Xue3sAEN8x_SBFk14g07GlkqaNwE9fl18';

// Database connection details (for reference only - not used in frontend)
// host: db.wofjapxwmowdhxchcjqs.supabase.co
// port: 5432
// database: postgres
// user: postgres
// Connection String: postgresql://postgres:[BARIsir@123]@db.wofjapxwmowdhxchcjqs.supabase.co:5432/postgres

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
    } else if (uniqueCode === 'fsece') {
        return {
            type: 'ECE',
            studentsTable: 'ece_students',
            resultsTable: 'ece_exam_results'
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
    } else if (uniqueCode === 'ffcse') {
        return {
            type: 'FFCSE',
            studentsTable: 'ffcse_students',
            resultsTable: 'ffcse_exam_results'
        };
    } else if (uniqueCode === 'ffit') {
        return {
            type: 'FFIT',
            studentsTable: 'ffit_students',
            resultsTable: 'ffit_exam_results'
        };
    } else if (uniqueCode === 'ffaids') {
        return {
            type: 'FFAIDS',
            studentsTable: 'ffaids_students',
            resultsTable: 'ffaids_exam_results'
        };
    } else if (uniqueCode === 'ffece') {
        return {
            type: 'FFECE',
            studentsTable: 'ffece_students',
            resultsTable: 'ffece_exam_results'
        };
    } else if (uniqueCode === 'fffcse') {
        return {
            type: 'FFFCSE',
            studentsTable: 'fffcse_students',
            resultsTable: 'fffcse_exam_results'
        };
    } else if (uniqueCode === 'fffece') {
        return {
            type: 'FFFECE',
            studentsTable: 'fffece_students',
            resultsTable: 'fffece_exam_results'
        };
    } else if (uniqueCode === 'fffaids') {
        return {
            type: 'FFFAIDS',
            studentsTable: 'fffaids_students',
            resultsTable: 'fffaids_exam_results'
        };
    } else if (uniqueCode === 'fffit') {
        return {
            type: 'FFFIT',
            studentsTable: 'fffit_students',
            resultsTable: 'fffit_exam_results'
        };
    } else if (uniqueCode === 'fffcivil') {
        return {
            type: 'FFFCIVIL',
            studentsTable: 'fffcivil_students',
            resultsTable: 'fffcivil_exam_results'
        };
    } else if (uniqueCode === 'fs4cse') {
        return {
            type: 'FS4CSE',
            studentsTable: 'fs4cse_students',
            resultsTable: 'fs4cse_exam_results'
        };
    } else if (uniqueCode === 'fs4it') {
        return {
            type: 'FS4IT',
            studentsTable: 'fs4it_students',
            resultsTable: 'fs4it_exam_results'
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

    const examType = detectExamType(uniqueCode);
    if (!examType) {
        return {
            valid: false,
            error: 'Invalid unique code. Please check your credentials.'
        };
    }

    // Map FFF and FS4 exams to their RPC functions
    const rpcMap = {
        'FFECE': 'check_ffece_exam_eligibility',
        'FFFCSE': 'check_fffcse_exam_eligibility',
        'FFFECE': 'check_fffece_exam_eligibility',
        'FFFAIDS': 'check_fffaids_exam_eligibility',
        'FFFIT': 'check_fffit_exam_eligibility',
        'FFFCIVIL': 'check_fffcivil_exam_eligibility',
        'FS4CSE': 'check_fs4cse_exam_eligibility',
        'FS4IT': 'check_fs4it_exam_eligibility'
    };

    const rpcFunc = rpcMap[examType.type];

    // Use secure RPC for FFF exams
    if (rpcFunc) {
        try {
            const { data, error } = await supabaseClient.rpc(rpcFunc, {
                p_roll_number: rollNumber,
                p_unique_code: uniqueCode
            });

            if (error) {
                console.error('RPC error:', error);
                return { valid: false, error: 'Authentication error. Please try again.' };
            }

            const result = Array.isArray(data) ? data[0] : data;

            if (!result || !result.eligible) {
                return {
                    valid: false,
                    error: result?.message || 'Invalid credentials or exam already completed.',
                    alreadyTaken: result?.already_taken || false
                };
            }

            return { valid: true, error: null, examType: examType.type, alreadyTaken: false };
        } catch (err) {
            console.error('Exception calling RPC:', err);
            return { valid: false, error: 'Connection error. Please try again.' };
        }
    }

    // Original validation for non-FFF exams
    try {
        const timeoutPromise = new Promise((_, reject) => {
            setTimeout(() => reject(new Error('Connection timeout')), 10000);
        });

        const queryPromise = supabaseClient
            .from(examType.studentsTable)
            .select('*')
            .eq('roll_number', rollNumber)
            .eq('unique_code', uniqueCode)
            .eq('is_active', true)
            .single();

        const { data, error } = await Promise.race([queryPromise, timeoutPromise]);

        if (error) {
            if (error.code === 'PGRST116') {
                return {
                    valid: false,
                    error: 'Invalid roll number or unique code. Please check your credentials.'
                };
            }
            console.error('Error validating credentials:', error);
            return {
                valid: false,
                error: 'Authentication error. Please check your internet connection and try again.'
            };
        }

        return { valid: true, error: null, student: data, examType: examType.type };
    } catch (err) {
        console.error('Exception validating credentials:', err);
        if (err.message === 'Connection timeout') {
            return { valid: false, error: 'Connection timeout. Please check your internet connection and try again.' };
        }
        return { valid: false, error: 'Network error. Please check your internet connection and try again.' };
    }
}

// Save exam results to Supabase
async function saveExamResults(rollNumber, correctAnswers, wrongAnswers, totalQuestions, percentage, userAnswers, shuffledQuestions) {
    if (!supabaseClient) {
        console.warn('Supabase client not initialized - results will not be saved');
        return { success: true, warning: 'Results not saved - Supabase not configured' };
    }
    
    const examType = window.currentExamType || detectExamType(window.currentUniqueCode);
    if (!examType) {
        console.error('Exam type not detected');
        return { success: true, warning: 'Results not saved - exam type unknown' };
    }
    
    const violationDetected = shuffledQuestions.violationDetected || false;
    const violationType = shuffledQuestions.violation || null;
    
    // Map FFF and FS4 exams to their RPC submit functions
    const submitRpcMap = {
        'FFECE': 'submit_ffece_exam_result',
        'FFFCSE': 'submit_fffcse_exam_result',
        'FFFECE': 'submit_fffece_exam_result',
        'FFFAIDS': 'submit_fffaids_exam_result',
        'FFFIT': 'submit_fffit_exam_result',
        'FFFCIVIL': 'submit_fffcivil_exam_result',
        'FS4CSE': 'submit_fs4cse_exam_result',
        'FS4IT': 'submit_fs4it_exam_result'
    };

    const submitRpc = submitRpcMap[examType.type];

    // Use secure RPC for FFF exams
    if (submitRpc) {
        try {
            const { data, error } = await supabaseClient.rpc(submitRpc, {
                p_roll_number: rollNumber,
                p_correct_answers: correctAnswers,
                p_wrong_answers: wrongAnswers,
                p_total_questions: totalQuestions,
                p_percentage: percentage,
                p_user_answers: userAnswers,
                p_additional_data: {
                    score: `${correctAnswers}/${totalQuestions}`,
                    shuffled_questions: shuffledQuestions,
                    exam_date: new Date().toISOString(),
                    exam_completed: true
                },
                p_violation_type: violationType,
                p_violation_detected: violationDetected
            });

            if (error) {
                console.error('RPC submit error:', error);
                return { success: false, error: error.message };
            }

            const result = Array.isArray(data) ? data[0] : data;
            
            if (!result || !result.success) {
                return { success: false, error: result?.message || 'Failed to submit exam' };
            }

            return { success: true, data: result };
        } catch (err) {
            console.error('Exception submitting via RPC:', err);
            return { success: false, error: 'Failed to submit exam results' };
        }
    }

    // Original submission for non-FFF exams
    try {
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
        
        if (examType.type === 'THIRDIT' || examType.type === 'FS1CSE' || examType.type === 'FS1AIDS' || examType.type === 'FS1IT' || examType.type === 'FS1CIVIL') {
            if (typeof generateDeviceFingerprint !== 'undefined' && typeof getBrowserInfo !== 'undefined') {
                resultData.device_fingerprint = generateDeviceFingerprint();
                resultData.browser_info = getBrowserInfo();
                resultData.exam_started_at = window.examStartTime || new Date().toISOString();
                resultData.exam_completed_at = new Date().toISOString();
            }
        }
        
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
            return { success: true, warning: 'Results could not be saved to database', error: error.message };
        }
        
        if (examType.type === 'THIRDIT' || examType.type === 'FS1CSE' || examType.type === 'FS1AIDS' || examType.type === 'FS1IT' || examType.type === 'FS1CIVIL') {
            if (typeof deactivateSession !== 'undefined') {
                await deactivateSession(rollNumber, window.currentUniqueCode);
            }
        }

        return { success: true, data };
    } catch (err) {
        console.error('Exception saving results:', err);
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
