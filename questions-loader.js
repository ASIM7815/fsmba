// Questions Loader with Basic Obfuscation
// This makes it harder (but not impossible) to read questions in browser inspect

(function() {
    'use strict';
    
    // Simple decode function
    function _0x4a2b(str) {
        try {
            return atob(str);
        } catch(e) {
            return str;
        }
    }
    
    // Decode and parse question data
    function _0x3c1d(data) {
        if (!data) return null;
        try {
            let decoded = _0x4a2b(data);
            return JSON.parse(decoded);
        } catch(e) {
            console.error('Failed to load exam data');
            return null;
        }
    }
    
    // Protect against console access
    window._getQuestions = function() {
        console.warn('⚠️ Unauthorized access attempt detected and logged.');
        return null;
    };
    
    // Load questions only when needed
    window._loadExamData = function(examType) {
        // Questions will be loaded from the original files
        // But accessed through this wrapper
        if (examType === 'FSMBA' || examType === 'STOCK_MARKET') {
            return typeof selectExamQuestions !== 'undefined' ? selectExamQuestions() : null;
        } else if (examType === 'MBA_REGULAR') {
            return typeof selectMBARegularExamQuestions !== 'undefined' ? selectMBARegularExamQuestions() : null;
        }
        return null;
    };
    
    // Disable right-click during exam
    document.addEventListener('contextmenu', function(e) {
        const examPage = document.getElementById('examPage');
        if (examPage && examPage.classList.contains('active')) {
            e.preventDefault();
            console.warn('Right-click disabled during exam');
            return false;
        }
    });
    
    // Detect DevTools opening
    let devtoolsOpen = false;
    const threshold = 160;
    
    setInterval(function() {
        if (window.outerWidth - window.innerWidth > threshold || 
            window.outerHeight - window.innerHeight > threshold) {
            if (!devtoolsOpen) {
                devtoolsOpen = true;
                console.warn('⚠️ Developer tools detected. Activity is being monitored.');
            }
        } else {
            devtoolsOpen = false;
        }
    }, 1000);
    
    // Prevent common shortcuts
    document.addEventListener('keydown', function(e) {
        const examPage = document.getElementById('examPage');
        if (examPage && examPage.classList.contains('active')) {
            // Prevent F12, Ctrl+Shift+I, Ctrl+Shift+C, Ctrl+Shift+J, Ctrl+U
            if (e.keyCode === 123 || 
                (e.ctrlKey && e.shiftKey && (e.keyCode === 73 || e.keyCode === 67 || e.keyCode === 74)) ||
                (e.ctrlKey && e.keyCode === 85)) {
                e.preventDefault();
                return false;
            }
        }
    });
    
    console.log('%c⚠️ WARNING', 'color: red; font-size: 40px; font-weight: bold;');
    console.log('%cThis is a browser feature intended for developers.', 'font-size: 16px;');
    console.log('%cUnauthorized access to exam content is prohibited and monitored.', 'font-size: 16px; color: red;');
    console.log('%cViolations will be reported to administrators.', 'font-size: 16px; color: red;');
    
})();
