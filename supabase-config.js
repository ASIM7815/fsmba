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

// Validate student credentials against database
async function validateCredentials(rollNumber, uniqueCode) {
    if (!supabaseClient) {
        return {
            valid: false,
            error: 'Database connection not available. Please try again later.'
        };
    }

    try {
        // Query the students table
        const { data, error } = await supabaseClient
            .from('students')
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
            student: data
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
    
    try {
        // Extract violation information if present
        const violationDetected = shuffledQuestions.violationDetected || false;
        const violationType = shuffledQuestions.violation || null;
        
        const { data, error } = await supabaseClient
            .from('exam_results')
            .insert([
                {
                    roll_number: rollNumber,
                    correct_answers: correctAnswers,
                    wrong_answers: wrongAnswers,
                    total_questions: totalQuestions,
                    percentage: percentage,
                    score: `${correctAnswers}/${totalQuestions}`,
                    user_answers: userAnswers,
                    shuffled_questions: shuffledQuestions,
                    exam_date: new Date().toISOString(),
                    exam_completed: true,
                    violation_detected: violationDetected,
                    violation_type: violationType
                }
            ]);

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
async function checkExamStatus(rollNumber) {
    if (!supabaseClient) {
        console.error('Supabase client not initialized');
        return { alreadyTaken: false, error: 'Database connection not available' };
    }
    
    try {
        const { data, error } = await supabaseClient
            .from('exam_results')
            .select('*')
            .eq('roll_number', rollNumber)
            .eq('exam_completed', true)
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
