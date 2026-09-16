// Student Configuration - Hardcoded Roll Numbers
// This allows exams to work without Supabase login validation
// Results will still be saved to Supabase

const studentsConfig = {
    // FS1 CSE - 39 students - Code: fs1cse
    'fs1cse': [
        '160525733004', '160525733013', '160525733021', '160525733022', '160525733025',
        '160525733037', '160525733040', '160525733053', '160525733054', '160525733055',
        '160525733063', '160525733070', '160525733072', '160525733084', '160525733089',
        '160525733090', '160525733093', '160525733095', '160525733096', '160525733100',
        '160525733101', '160525733108', '160525733110', '160525733131', '160525733133',
        '160525733136', '160525733138', '160525733142', '160525733143', '160525733148',
        '160525733149', '160525733158', '160525733163', '160525733167', '160525733170',
        '160525733172', '160525733186', '160525733213', '160525733214'
    ],
    
    // FS1 AIDS - 16 students - Code: fs1aids
    'fs1aids': [
        '160524735007', '160525747011', '160525747026', '160525747027', '160525747036',
        '160525747046', '160525747055', '160525747065', '160525747066', '160525747067',
        '160525747072', '160525747073', '160525747078', '160525747088', '160525747089',
        '160525747094'
    ],
    
    // FS1 IT - 7 students - Code: fsit
    'fsit': [
        '160525737019', '160525737033', '160525737037', '160525737039', '160525737041',
        '160525737042', '160525737045'
    ],
    
    // FS1 CIVIL - 5 students - Code: fscivil
    'fscivil': [
        '160525732010', '160525732025', '160525732026', '160525732027', '160525732028'
    ]
};

// Validate student credentials using hardcoded data
function validateStudentCredentials(rollNumber, uniqueCode) {
    // Check if the unique code exists
    if (!studentsConfig[uniqueCode]) {
        return {
            valid: false,
            error: 'Invalid unique code. Please check your credentials.',
            examType: null
        };
    }
    
    // Check if the roll number exists for this unique code
    if (!studentsConfig[uniqueCode].includes(rollNumber)) {
        return {
            valid: false,
            error: 'Invalid roll number for this exam. Please check your credentials.',
            examType: null
        };
    }
    
    // Determine exam type based on unique code
    let examType = null;
    switch(uniqueCode) {
        case 'fs1cse':
            examType = 'FS1CSE';
            break;
        case 'fs1aids':
            examType = 'FS1AIDS';
            break;
        case 'fsit':
            examType = 'FS1IT';
            break;
        case 'fscivil':
            examType = 'FS1CIVIL';
            break;
        default:
            return {
                valid: false,
                error: 'Exam type not recognized.',
                examType: null
            };
    }
    
    // Valid credentials
    return {
        valid: true,
        error: null,
        examType: examType,
        student: {
            roll_number: rollNumber,
            unique_code: uniqueCode
        }
    };
}

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
