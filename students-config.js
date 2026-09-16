// Student Configuration - Helper Functions
// This file contains helper functions for exam validation
// All validation now goes through Supabase (supabase-config.js)

// Check if student has already taken exam (from Supabase)
async function checkIfExamTaken(rollNumber, uniqueCode) {
    if (!supabaseClient) {
        console.warn('Supabase not initialized - skipping duplicate check');
        return { alreadyTaken: false };
    }
    
    try {
        const examType = detectExamType(uniqueCode);
        if (!examType) {
            return { alreadyTaken: false };
        }
        
        // Set a timeout of 3 seconds
        const timeoutPromise = new Promise((resolve) => {
            setTimeout(() => resolve({ alreadyTaken: false, timeout: true }), 3000);
        });
        
        const queryPromise = supabaseClient
            .from(examType.resultsTable)
            .select('id')
            .eq('roll_number', rollNumber)
            .limit(1)
            .maybeSingle();
        
        const result = await Promise.race([queryPromise, timeoutPromise]);
        
        if (result.timeout) {
            console.warn('Duplicate check timed out - allowing exam');
            return { alreadyTaken: false };
        }
        
        const { data, error } = result;

        if (error && error.code !== 'PGRST116') {
            console.error('Error checking exam status:', error);
            return { alreadyTaken: false };
        }

        return { alreadyTaken: !!data, data };
    } catch (err) {
        console.error('Exception checking exam status:', err);
        return { alreadyTaken: false };
    }
}
