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
    } else if (uniqueCode === 'fsmba1708') {
        return {
            type: 'MBA_REGULAR',
            studentsTable: 'mba_regular_students',
            resultsTable: 'mba_regular_exam_results'
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
        console.error('Supabase client not initialized');
        return { success: false, error: 'Database connection not available' };
    }
    
    // Detect exam type from global variable (set during login)
    const examType = window.currentExamType || detectExamType(window.currentUniqueCode);
    if (!examType) {
        console.error('Exam type not detected');
        return { success: false, error: 'Exam type not identified' };
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
            console.error('Error saving results:', error);
            return { success: false, error: error.message };
        }

        return { success: true, data };
    } catch (err) {
        console.error('Exception saving results:', err);
        return { success: false, error: err.message };
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
