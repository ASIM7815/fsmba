// Global Variables
let studentRollNumber = '';
let uniqueCode = '';
let currentQuestionIndex = 0;
let userAnswers = [];
let timerInterval;
let timeRemaining = 1800; // 30 minutes in seconds
let shuffledQuestions = []; // Store shuffled questions for this student
let originalQuestionOrder = []; // Store original question indices

// DSA Questions Array (Base Questions)
let baseQuestions = [
    {
        question: "What is the time complexity of binary search in a sorted array?",
        options: ["O(n)", "O(log n)", "O(n log n)", "O(1)"],
        correct: 1
    },
    {
        question: "Which data structure uses LIFO (Last In First Out) principle?",
        options: ["Queue", "Stack", "Array", "Linked List"],
        correct: 1
    },
    {
        question: "What is the worst-case time complexity of QuickSort?",
        options: ["O(n)", "O(n log n)", "O(n²)", "O(log n)"],
        correct: 2
    },
    {
        question: "In a binary tree, what is the maximum number of nodes at level 'l'?",
        options: ["2^l", "2^(l-1)", "2^(l+1)", "l^2"],
        correct: 0
    },
    {
        question: "Which traversal of a binary tree visits nodes in the order: Left, Root, Right?",
        options: ["Preorder", "Inorder", "Postorder", "Level Order"],
        correct: 1
    },
    {
        question: "What is the space complexity of merge sort?",
        options: ["O(1)", "O(log n)", "O(n)", "O(n²)"],
        correct: 2
    },
    {
        question: "In a hash table, what is used to handle collisions?",
        options: ["Linear Probing", "Chaining", "Both A and B", "None of the above"],
        correct: 2
    },
    {
        question: "What is the time complexity of inserting an element at the beginning of a linked list?",
        options: ["O(1)", "O(n)", "O(log n)", "O(n log n)"],
        correct: 0
    },
    {
        question: "Which algorithm is used to find the shortest path in a weighted graph?",
        options: ["BFS", "DFS", "Dijkstra's Algorithm", "Binary Search"],
        correct: 2
    },
    {
        question: "What is the height of a complete binary tree with n nodes?",
        options: ["log₂(n)", "n", "n/2", "2n"],
        correct: 0
    }
];

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

        // Check if student has already taken the exam
        const examStatus = await checkExamStatus(rollNumberInput);
        if (examStatus.alreadyTaken) {
            showErrorModal('You have already completed this exam. You cannot take it again.');
            return;
        }

        studentRollNumber = rollNumberInput;
        uniqueCode = codeInput;
        
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
    
    document.getElementById('displayStudentRollNumber').textContent = 'Roll No: ' + studentRollNumber;
    showPage('examPage');
    startTimer();
    displayQuestion();
    
    // Prevent page closing
    window.onbeforeunload = function() {
        return "Are you sure you want to leave? Your exam progress will be lost!";
    };
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
    clearInterval(timerInterval);
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
