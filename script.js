// ============================================
// ANTI-INSPECT / DEVTOOLS BLOCKING
// ============================================

// Disable right-click context menu
document.addEventListener('contextmenu', function(e) {
    e.preventDefault();
    return false;
});

// Disable keyboard shortcuts for DevTools
document.addEventListener('keydown', function(e) {
    // F12 (DevTools)
    if (e.keyCode === 123) {
        e.preventDefault();
        return false;
    }
    
    // Ctrl+Shift+I (Inspect)
    if (e.ctrlKey && e.shiftKey && e.keyCode === 73) {
        e.preventDefault();
        return false;
    }
    
    // Ctrl+Shift+J (Console)
    if (e.ctrlKey && e.shiftKey && e.keyCode === 74) {
        e.preventDefault();
        return false;
    }
    
    // Ctrl+Shift+C (Inspect Element)
    if (e.ctrlKey && e.shiftKey && e.keyCode === 67) {
        e.preventDefault();
        return false;
    }
    
    // Ctrl+U (View Source)
    if (e.ctrlKey && e.keyCode === 85) {
        e.preventDefault();
        return false;
    }
    
    // Ctrl+S (Save Page)
    if (e.ctrlKey && e.keyCode === 83) {
        e.preventDefault();
        return false;
    }
    
    // Cmd+Option+I (Mac Inspect)
    if (e.metaKey && e.altKey && e.keyCode === 73) {
        e.preventDefault();
        return false;
    }
    
    // Cmd+Option+J (Mac Console)
    if (e.metaKey && e.altKey && e.keyCode === 74) {
        e.preventDefault();
        return false;
    }
    
    // Cmd+Option+C (Mac Inspect Element)
    if (e.metaKey && e.altKey && e.keyCode === 67) {
        e.preventDefault();
        return false;
    }
});

// Detect DevTools opening (by checking window size changes)
let devtoolsOpen = false;
const threshold = 160;

const detectDevTools = () => {
    const widthThreshold = window.outerWidth - window.innerWidth > threshold;
    const heightThreshold = window.outerHeight - window.innerHeight > threshold;
    
    if (widthThreshold || heightThreshold) {
        if (!devtoolsOpen && examInProgress) {
            devtoolsOpen = true;
            console.warn('DevTools detected - This is a violation');
            // Auto-submit if exam is in progress
            if (examInProgress) {
                alert('Developer tools detected! Exam will be auto-submitted.');
                submitExam(true); // Force submit
            }
        }
    } else {
        devtoolsOpen = false;
    }
};

// Check for DevTools every 500ms
setInterval(detectDevTools, 500);

// Detect if DevTools is open using console debugging
let consoleCheckInterval;
const detectConsole = () => {
    const before = performance.now();
    debugger;
    const after = performance.now();
    
    if (after - before > 100 && examInProgress) {
        console.warn('Console debugging detected');
        alert('Developer tools detected! Exam will be auto-submitted.');
        submitExam(true);
    }
};

// Disable text selection during exam
document.addEventListener('selectstart', function(e) {
    if (examInProgress) {
        e.preventDefault();
        return false;
    }
});

// Disable copy during exam
document.addEventListener('copy', function(e) {
    if (examInProgress) {
        e.preventDefault();
        return false;
    }
});

// Disable cut during exam
document.addEventListener('cut', function(e) {
    if (examInProgress) {
        e.preventDefault();
        return false;
    }
});

// Override console methods to detect usage
(function() {
    const original = {
        log: console.log,
        warn: console.warn,
        error: console.error,
        info: console.info
    };
    
    console.log = function() {
        if (examInProgress) {
            // Silently ignore
        }
    };
    
    console.warn = function() {
        if (examInProgress) {
            // Silently ignore
        }
    };
    
    console.error = function() {
        if (examInProgress) {
            // Silently ignore
        }
    };
    
    console.info = function() {
        if (examInProgress) {
            // Silently ignore
        }
    };
})();

// Global Variables
let studentRollNumber = '';
let uniqueCode = '';
let currentQuestionIndex = 0;
let userAnswers = [];
let timerInterval;
let timeRemaining = 1800; // 30 minutes in seconds
let shuffledQuestions = []; // Store shuffled questions for this student
let originalQuestionOrder = []; // Store original question indices
let baseQuestions = []; // Will be populated from questionBank
let examInProgress = false; // Track if exam is in progress
let tabSwitchDetected = false; // Track if student switched tabs
let fullscreenExitDetected = false; // Track if student exited fullscreen
let warningGiven = false; // Track if warning has been given
let returnTimeout = null; // Timeout for returning to fullscreen

// Shuffle array function (Fisher-Yates algorithm)
function shuffleArray(array) {
    const shuffled = [...array];
    for (let i = shuffled.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
    }
    return shuffled;
}

// Create shuffled questions with shuffled options for each student
function createShuffledQuestions(rollNumber) {
    // Use roll number as seed for consistent shuffling per student
    let seed = parseInt(rollNumber.slice(-4));
    
    // Simple seeded random function
    function seededRandom() {
        seed = (seed * 9301 + 49297) % 233280;
        return seed / 233280;
    }
    
    // Shuffle array using seeded random
    function shuffleWithSeed(array) {
        let shuffled = [...array];
        for (let i = shuffled.length - 1; i > 0; i--) {
            let j = Math.floor(seededRandom() * (i + 1));
            [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
        }
        return shuffled;
    }
    
    // Shuffle questions order
    let questionIndices = baseQuestions.map((_, idx) => idx);
    let shuffledIndices = shuffleWithSeed(questionIndices);
    
    // Create shuffled questions with shuffled options
    shuffledQuestions = shuffledIndices.map(originalIndex => {
        let originalQuestion = baseQuestions[originalIndex];
        
        // Create array of option objects with their original indices
        let optionsWithIndices = originalQuestion.options.map((option, idx) => ({
            text: option,
            originalIndex: idx
        }));
        
        // Shuffle the options
        let shuffledOptions = shuffleWithSeed(optionsWithIndices);
        
        // Find new position of correct answer
        let newCorrectIndex = shuffledOptions.findIndex(
            opt => opt.originalIndex === originalQuestion.correct
        );
        
        return {
            question: originalQuestion.question,
            options: shuffledOptions.map(opt => opt.text),
            correct: newCorrectIndex,
            originalQuestionIndex: originalIndex
        };
    });
    
    originalQuestionOrder = shuffledIndices;
}

// Initialize user answers array
function initializeAnswers() {
    userAnswers = new Array(shuffledQuestions.length).fill(null);
}

// Page Navigation Functions
function showPage(pageId) {
    document.querySelectorAll('.page').forEach(page => {
        page.classList.remove('active');
    });
    document.getElementById(pageId).classList.add('active');
}

// Proceed to Instructions Page
async function proceedToInstructions() {
    const rollNumberInput = document.getElementById('studentRollNumber').value.trim();
    const codeInput = document.getElementById('uniqueCode').value.trim();

    if (!rollNumberInput || !codeInput) {
        showErrorModal('Please enter both Student Roll Number and Unique Code');
        return;
    }

    // Check if validateCredentials function exists
    if (typeof validateCredentials === 'undefined') {
        showErrorModal('System not ready. Please refresh the page and try again.');
        console.error('validateCredentials function not found. Check if supabase-config.js loaded properly.');
        return;
    }

    // Show loading state
    const continueBtn = document.querySelector('.btn-primary');
    const originalText = continueBtn.textContent;
    continueBtn.textContent = 'Validating...';
    continueBtn.disabled = true;

    try {
        // Validate credentials against database
        const validation = await validateCredentials(rollNumberInput, codeInput);
        
        // Reset button
        continueBtn.textContent = originalText;
        continueBtn.disabled = false;

        if (!validation.valid) {
            showErrorModal(validation.error);
            return;
        }

        // Store exam type globally
        window.currentExamType = detectExamType(codeInput);
        window.currentUniqueCode = codeInput;

        // Check if student has already taken the exam
        const examStatus = await checkExamStatus(rollNumberInput, codeInput);
        if (examStatus.alreadyTaken) {
            showErrorModal('You have already completed this exam. You cannot take it again.');
            return;
        }

        studentRollNumber = rollNumberInput;
        uniqueCode = codeInput;
        
        // Select 20 questions from question bank based on exam type
        if (validation.examType === 'FSMBA') {
            // FSMBA: Use existing selectExamQuestions function
            baseQuestions = selectExamQuestions();
        } else if (validation.examType === 'STOCK_MARKET') {
            // Stock Market: Use existing selectExamQuestions function (9 modules)
            baseQuestions = selectExamQuestions();
        } else if (validation.examType === 'MBA_REGULAR') {
            // MBA Regular: Use new selectMBARegularExamQuestions function
            baseQuestions = selectMBARegularExamQuestions();
        } else if (validation.examType === 'CSE') {
            // CSE: Use selectCSEExamQuestions function (60 total, 20 random)
            baseQuestions = selectCSEExamQuestions();
        } else {
            showErrorModal('Exam type not recognized. Please contact administrator.');
            return;
        }
        
        // Create shuffled questions specific to this student
        createShuffledQuestions(studentRollNumber);
        
        showPage('instructionsPage');
    } catch (error) {
        // Reset button
        continueBtn.textContent = originalText;
        continueBtn.disabled = false;
        
        console.error('Error during validation:', error);
        showErrorModal('An error occurred. Please try again or contact support.');
    }
}

// Show error modal
function showErrorModal(message) {
    const modal = document.getElementById('errorModal');
    const errorMessage = document.getElementById('errorMessage');
    errorMessage.textContent = message;
    modal.classList.add('active');
}

// Close error modal
function closeErrorModal() {
    const modal = document.getElementById('errorModal');
    modal.classList.remove('active');
}

// Start Exam
function startExam() {
    initializeAnswers();
    currentQuestionIndex = 0;
    timeRemaining = 1800; // Reset timer to 30 minutes
    examInProgress = true; // Mark exam as in progress
    tabSwitchDetected = false;
    fullscreenExitDetected = false;
    warningGiven = false;
    
    document.getElementById('displayStudentRollNumber').textContent = 'Roll No: ' + studentRollNumber;
    showPage('examPage');
    
    // Request fullscreen
    enterFullscreen();
    
    // Start monitoring for tab switches and fullscreen exit
    startMonitoring();
    
    startTimer();
    displayQuestion();
    
    // Prevent page closing
    window.onbeforeunload = function() {
        return "Are you sure you want to leave? Your exam progress will be lost!";
    };
}

// Enter fullscreen mode
function enterFullscreen() {
    const elem = document.documentElement;
    
    if (elem.requestFullscreen) {
        elem.requestFullscreen().catch(err => {
            console.error('Error attempting to enable fullscreen:', err);
            alert('Please allow fullscreen mode to start the exam');
        });
    } else if (elem.webkitRequestFullscreen) { /* Safari */
        elem.webkitRequestFullscreen();
    } else if (elem.msRequestFullscreen) { /* IE11 */
        elem.msRequestFullscreen();
    }
}

// Exit fullscreen mode
function exitFullscreen() {
    if (document.exitFullscreen) {
        document.exitFullscreen();
    } else if (document.webkitExitFullscreen) { /* Safari */
        document.webkitExitFullscreen();
    } else if (document.msExitFullscreen) { /* IE11 */
        document.msExitFullscreen();
    }
}

// Start monitoring for violations
function startMonitoring() {
    // Monitor tab visibility changes (switching tabs/windows)
    document.addEventListener('visibilitychange', handleVisibilityChange);
    
    // Monitor fullscreen changes (ESC key or exit fullscreen)
    document.addEventListener('fullscreenchange', handleFullscreenChange);
    document.addEventListener('webkitfullscreenchange', handleFullscreenChange);
    document.addEventListener('mozfullscreenchange', handleFullscreenChange);
    document.addEventListener('MSFullscreenChange', handleFullscreenChange);
    
    // Monitor window blur (switching to another window/app)
    window.addEventListener('blur', handleWindowBlur);
}

// Stop monitoring
function stopMonitoring() {
    document.removeEventListener('visibilitychange', handleVisibilityChange);
    document.removeEventListener('fullscreenchange', handleFullscreenChange);
    document.removeEventListener('webkitfullscreenchange', handleFullscreenChange);
    document.removeEventListener('mozfullscreenchange', handleFullscreenChange);
    document.removeEventListener('MSFullscreenChange', handleFullscreenChange);
    window.removeEventListener('blur', handleWindowBlur);
}

// Handle tab/window visibility change
function handleVisibilityChange() {
    if (examInProgress && document.hidden) {
        tabSwitchDetected = true;
        handleCheatingAttempt('Tab Switch Detected');
    }
}

// Handle fullscreen exit
function handleFullscreenChange() {
    const isFullscreen = document.fullscreenElement || 
                        document.webkitFullscreenElement || 
                        document.mozFullScreenElement || 
                        document.msFullscreenElement;
    
    if (examInProgress && !isFullscreen) {
        fullscreenExitDetected = true;
        
        // If already warned or tab switch detected, auto-submit
        if (warningGiven || tabSwitchDetected) {
            handleCheatingAttempt('Second Violation - Fullscreen Exit After Warning');
        } else {
            // First time - give warning
            showFullscreenWarning();
        }
    }
}

// Show warning modal for fullscreen exit
function showFullscreenWarning() {
    warningGiven = true;
    
    const modal = document.getElementById('fullscreenWarningModal');
    modal.classList.add('active');
    
    // Give 10 seconds to return to fullscreen
    let countdown = 10;
    const countdownElement = document.getElementById('warningCountdown');
    countdownElement.textContent = countdown;
    
    returnTimeout = setInterval(() => {
        countdown--;
        countdownElement.textContent = countdown;
        
        if (countdown <= 0) {
            clearInterval(returnTimeout);
            closeFullscreenWarning();
            handleCheatingAttempt('Failed to Return to Fullscreen');
        }
    }, 1000);
}

// Return to fullscreen from warning
function returnToFullscreen() {
    clearInterval(returnTimeout);
    closeFullscreenWarning();
    enterFullscreen();
    fullscreenExitDetected = false;
}

// Close fullscreen warning modal
function closeFullscreenWarning() {
    const modal = document.getElementById('fullscreenWarningModal');
    modal.classList.remove('active');
}

// Handle window blur (switched to another app/window)
function handleWindowBlur() {
    if (examInProgress) {
        tabSwitchDetected = true;
        handleCheatingAttempt('Window Switch Detected');
    }
}

// Handle cheating attempt
function handleCheatingAttempt(reason) {
    if (!examInProgress) return; // Already handled
    
    examInProgress = false; // Mark exam as no longer in progress
    
    // Stop the timer
    clearInterval(timerInterval);
    
    // Auto-submit exam with violation flag
    autoSubmitForViolation(reason);
}

// Auto-submit exam due to violation
async function autoSubmitForViolation(violationType) {
    alert(`EXAM VIOLATION DETECTED: ${violationType}\n\nYour exam will be submitted automatically with your current score.`);
    
    // Calculate current results
    let correctCount = 0;
    let wrongCount = 0;
    
    shuffledQuestions.forEach((question, index) => {
        if (userAnswers[index] === question.correct) {
            correctCount++;
        } else if (userAnswers[index] !== null) {
            wrongCount++;
        }
    });
    
    const unanswered = shuffledQuestions.length - correctCount - wrongCount;
    const percentage = ((correctCount / shuffledQuestions.length) * 100).toFixed(2);
    
    // Save results to Supabase with violation flag
    const saveResult = await saveExamResults(
        studentRollNumber,
        correctCount,
        wrongCount + unanswered,
        shuffledQuestions.length,
        parseFloat(percentage),
        userAnswers,
        {
            questionOrder: originalQuestionOrder,
            questions: shuffledQuestions,
            violation: violationType,
            violationDetected: true
        }
    );
    
    if (!saveResult.success) {
        console.error('Failed to save results:', saveResult.error);
    }
    
    // Stop monitoring
    stopMonitoring();
    
    // Exit fullscreen
    exitFullscreen();
    
    // Remove page close warning
    window.onbeforeunload = null;
    
    // Display results
    document.getElementById('resultStudentRollNumber').textContent = studentRollNumber;
    document.getElementById('correctAnswers').textContent = correctCount;
    document.getElementById('wrongAnswers').textContent = wrongCount + unanswered;
    document.getElementById('score').textContent = `${correctCount}/${shuffledQuestions.length}`;
    document.getElementById('percentage').textContent = `${percentage}%`;
    
    // Add violation warning to results
    const resultsBox = document.querySelector('.results-box');
    const violationWarning = document.createElement('div');
    violationWarning.style.cssText = 'background: #fee2e2; color: #dc2626; padding: 15px; border-radius: 8px; margin-bottom: 20px; border-left: 4px solid #dc2626;';
    violationWarning.innerHTML = `<strong>⚠️ EXAM VIOLATION:</strong> ${violationType}`;
    resultsBox.insertBefore(violationWarning, resultsBox.querySelector('.result-content'));
    
    // Change score color
    const scoreElement = document.getElementById('score');
    if (percentage >= 70) {
        scoreElement.style.color = '#10b981';
    } else if (percentage >= 40) {
        scoreElement.style.color = '#f59e0b';
    } else {
        scoreElement.style.color = '#dc2626';
    }
    
    // Show results page
    showPage('resultsPage');
}

// Timer Function
function startTimer() {
    updateTimerDisplay();
    
    timerInterval = setInterval(() => {
        timeRemaining--;
        updateTimerDisplay();
        
        if (timeRemaining <= 0) {
            clearInterval(timerInterval);
            autoSubmitExam();
        }
    }, 1000);
}

function updateTimerDisplay() {
    const minutes = Math.floor(timeRemaining / 60);
    const seconds = timeRemaining % 60;
    const display = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    document.getElementById('timer').textContent = display;
    
    // Change color when time is running out
    if (timeRemaining <= 300) { // Less than 5 minutes
        document.getElementById('timer').style.background = '#dc2626';
    } else if (timeRemaining <= 600) { // Less than 10 minutes
        document.getElementById('timer').style.background = '#f59e0b';
    }
}

// Display Question
function displayQuestion() {
    const question = shuffledQuestions[currentQuestionIndex];
    
    // Update question number
    document.getElementById('questionNumber').textContent = 
        `Question ${currentQuestionIndex + 1} of ${shuffledQuestions.length}`;
    
    // Update question text
    document.getElementById('questionText').textContent = question.question;
    
    // Update options
    const optionsContainer = document.getElementById('optionsContainer');
    optionsContainer.innerHTML = '';
    
    question.options.forEach((option, index) => {
        const optionDiv = document.createElement('div');
        optionDiv.className = 'option';
        optionDiv.textContent = option;
        
        // Check if this option was previously selected
        if (userAnswers[currentQuestionIndex] === index) {
            optionDiv.classList.add('selected');
        }
        
        optionDiv.onclick = () => selectOption(index);
        optionsContainer.appendChild(optionDiv);
    });
    
    // Update navigation buttons
    updateNavigationButtons();
}

// Select Option
function selectOption(optionIndex) {
    userAnswers[currentQuestionIndex] = optionIndex;
    
    // Update UI
    document.querySelectorAll('.option').forEach((opt, idx) => {
        if (idx === optionIndex) {
            opt.classList.add('selected');
        } else {
            opt.classList.remove('selected');
        }
    });
}

// Navigation Functions
function previousQuestion() {
    if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
        displayQuestion();
    }
}

function nextQuestion() {
    if (currentQuestionIndex < shuffledQuestions.length - 1) {
        currentQuestionIndex++;
        displayQuestion();
    }
}

function updateNavigationButtons() {
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const submitBtn = document.getElementById('submitBtn');
    
    // Previous button
    prevBtn.disabled = currentQuestionIndex === 0;
    
    // Next and Submit buttons
    if (currentQuestionIndex === shuffledQuestions.length - 1) {
        nextBtn.style.display = 'none';
        submitBtn.style.display = 'block';
    } else {
        nextBtn.style.display = 'block';
        submitBtn.style.display = 'none';
    }
}

// Submit Exam
function submitExam() {
    // Check if all questions are answered
    const unansweredCount = userAnswers.filter(ans => ans === null).length;
    
    if (unansweredCount > 0) {
        showSubmitModal(`You have ${unansweredCount} unanswered question(s). Do you want to submit anyway?`);
    } else {
        showSubmitModal('Are you sure you want to submit the exam?');
    }
}

// Show custom modal
function showSubmitModal(message) {
    const modal = document.getElementById('submitModal');
    const modalMessage = document.getElementById('modalMessage');
    modalMessage.textContent = message;
    modal.classList.add('active');
}

// Close modal
function closeSubmitModal() {
    const modal = document.getElementById('submitModal');
    modal.classList.remove('active');
}

// Confirm submission from modal
function confirmSubmit() {
    closeSubmitModal();
    finishExam();
}

function autoSubmitExam() {
    alert('Time is up! Your exam will be submitted automatically.');
    finishExam();
}

function finishExam() {
    examInProgress = false; // Mark exam as finished
    clearInterval(timerInterval);
    stopMonitoring(); // Stop monitoring for violations
    exitFullscreen(); // Exit fullscreen
    window.onbeforeunload = null; // Remove the page close warning
    
    // Calculate results
    calculateResults();
    
    // Show results page
    showPage('resultsPage');
}

// Calculate Results
async function calculateResults() {
    let correctCount = 0;
    let wrongCount = 0;
    
    shuffledQuestions.forEach((question, index) => {
        if (userAnswers[index] === question.correct) {
            correctCount++;
        } else if (userAnswers[index] !== null) {
            wrongCount++;
        }
    });
    
    const unanswered = shuffledQuestions.length - correctCount - wrongCount;
    const percentage = ((correctCount / shuffledQuestions.length) * 100).toFixed(2);
    
    // Save results to Supabase
    const saveResult = await saveExamResults(
        studentRollNumber,
        correctCount,
        wrongCount + unanswered,
        shuffledQuestions.length,
        parseFloat(percentage),
        userAnswers,
        {
            questionOrder: originalQuestionOrder,
            questions: shuffledQuestions
        }
    );
    
    if (!saveResult.success) {
        console.error('Failed to save results:', saveResult.error);
        showErrorModal('Failed to save your exam results. Please contact the administrator.');
    }
    
    // Display results
    document.getElementById('resultStudentRollNumber').textContent = studentRollNumber;
    document.getElementById('correctAnswers').textContent = correctCount;
    document.getElementById('wrongAnswers').textContent = wrongCount + unanswered;
    document.getElementById('score').textContent = `${correctCount}/${shuffledQuestions.length}`;
    document.getElementById('percentage').textContent = `${percentage}%`;
    
    // Change score color based on percentage
    const scoreElement = document.getElementById('score');
    if (percentage >= 70) {
        scoreElement.style.color = '#10b981'; // Green
    } else if (percentage >= 40) {
        scoreElement.style.color = '#f59e0b'; // Orange
    } else {
        scoreElement.style.color = '#dc2626'; // Red
    }
}

// Prevent context menu and certain keyboard shortcuts during exam
document.addEventListener('contextmenu', function(e) {
    const examPage = document.getElementById('examPage');
    if (examPage.classList.contains('active')) {
        e.preventDefault();
    }
});

document.addEventListener('keydown', function(e) {
    const examPage = document.getElementById('examPage');
    if (examPage.classList.contains('active')) {
        // Prevent F12, Ctrl+Shift+I, Ctrl+Shift+J, Ctrl+U
        if (e.keyCode === 123 || 
            (e.ctrlKey && e.shiftKey && (e.keyCode === 73 || e.keyCode === 74)) ||
            (e.ctrlKey && e.keyCode === 85)) {
            e.preventDefault();
        }
    }
});
