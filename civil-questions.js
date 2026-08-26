// ============================================
// CIVIL ENGINEERING EXAM QUESTIONS
// ============================================
// Topics: Git, Linux, GitHub, Networking, System Administration
// Total Questions: 60
// Questions per Exam: 20 (randomly selected)
// Same question bank as CSE exam
// ============================================

const civilQuestionBank = [
    // Git Commands Questions (Q1-Q15)
    {
        question: "A developer needs a local copy of a remote repository. Which command is appropriate?",
        options: ["git init", "git clone", "git add", "git reset"],
        correctAnswer: 1
    },
    {
        question: "After making changes to multiple files, which command stages all modified files for commit?",
        options: ["git commit -a", "git add .", "git push", "git fetch"],
        correctAnswer: 1
    },
    {
        question: "To view the commit history of a repository, which command should be used?",
        options: ["git status", "git log", "git show", "git diff"],
        correctAnswer: 1
    },
    {
        question: "A developer wants to create a new branch called 'feature'. What is the correct command?",
        options: ["git branch feature", "git checkout feature", "git merge feature", "git push feature"],
        correctAnswer: 0
    },
    {
        question: "To switch to an existing branch named 'develop', which command is used?",
        options: ["git branch develop", "git checkout develop", "git merge develop", "git delete develop"],
        correctAnswer: 1
    },
    {
        question: "Which command uploads local commits to a remote repository?",
        options: ["git fetch", "git pull", "git push", "git clone"],
        correctAnswer: 2
    },
    {
        question: "To combine changes from one branch into another, which operation is performed?",
        options: ["git branch", "git checkout", "git merge", "git rebase"],
        correctAnswer: 2
    },
    {
        question: "A developer wants to undo the last commit but keep the changes. Which command is appropriate?",
        options: ["git reset --soft HEAD~1", "git revert HEAD", "git checkout HEAD", "git clean -f"],
        correctAnswer: 0
    },
    {
        question: "To download changes from remote but not merge them, which command is used?",
        options: ["git pull", "git push", "git fetch", "git clone"],
        correctAnswer: 2
    },
    {
        question: "Which command initializes a new Git repository in the current directory?",
        options: ["git start", "git create", "git init", "git new"],
        correctAnswer: 2
    },
    {
        question: "To see the current status of the working directory and staging area, which command is used?",
        options: ["git log", "git status", "git show", "git info"],
        correctAnswer: 1
    },
    {
        question: "A developer wants to create a commit with a message. What is the correct command?",
        options: ["git commit 'message'", "git commit -m 'message'", "git add -m 'message'", "git push -m 'message'"],
        correctAnswer: 1
    },
    {
        question: "To view the differences between the working directory and the last commit, which command is used?",
        options: ["git status", "git log", "git diff", "git show"],
        correctAnswer: 2
    },
    {
        question: "Which command creates a new commit that undoes changes from a previous commit?",
        options: ["git reset", "git revert", "git undo", "git remove"],
        correctAnswer: 1
    },
    {
        question: "To list all branches in a repository, which command is used?",
        options: ["git branch", "git branch --list", "git show-branch", "Both A and B"],
        correctAnswer: 3
    },

    // Linux Commands Questions (Q16-Q30)
    {
        question: "Which command changes file permissions in Linux?",
        options: ["chmod", "ps", "umask", "chown"],
        correctAnswer: 0
    },
    {
        question: "To change the owner of a file, which command is used?",
        options: ["chmod", "chown", "chgrp", "usermod"],
        correctAnswer: 1
    },
    {
        question: "Which command displays disk space usage of file systems?",
        options: ["du", "df", "ls", "stat"],
        correctAnswer: 1
    },
    {
        question: "To check the disk usage of a specific directory, which command is appropriate?",
        options: ["df", "du", "ls -l", "stat"],
        correctAnswer: 1
    },
    {
        question: "Which command is used to manage systemd services?",
        options: ["service", "systemctl", "init", "daemon"],
        correctAnswer: 1
    },
    {
        question: "To synchronize files and directories between two locations, which command is efficient?",
        options: ["cp", "mv", "rsync", "scp"],
        correctAnswer: 2
    },
    {
        question: "Which command displays kernel ring buffer messages?",
        options: ["dmesg", "journalctl", "syslog", "logread"],
        correctAnswer: 0
    },
    {
        question: "To terminate a process by its PID, which command is used?",
        options: ["stop", "kill", "terminate", "end"],
        correctAnswer: 1
    },
    {
        question: "Which command displays currently running processes?",
        options: ["ls", "ps", "proc", "tasks"],
        correctAnswer: 1
    },
    {
        question: "To view real-time system resource usage and processes, which command is used?",
        options: ["ps", "top", "htop", "Both B and C"],
        correctAnswer: 3
    },
    {
        question: "Which permission numeric value represents read, write, and execute for the owner?",
        options: ["644", "755", "700", "777"],
        correctAnswer: 2
    },
    {
        question: "To make a file executable, which chmod command is appropriate?",
        options: ["chmod +x file", "chmod 777 file", "chmod -x file", "chmod execute file"],
        correctAnswer: 0
    },
    {
        question: "Which command shows the amount of free and used memory in the system?",
        options: ["mem", "memory", "free", "ram"],
        correctAnswer: 2
    },
    {
        question: "To search for running processes by name, which command is useful?",
        options: ["ps aux | grep process", "find process", "search process", "locate process"],
        correctAnswer: 0
    },
    {
        question: "Which command displays open network connections and listening ports?",
        options: ["netstat", "ifconfig", "route", "arp"],
        correctAnswer: 0
    },

    // GitHub Features Questions (Q31-Q40)
    {
        question: "What is a fork in GitHub?",
        options: [
            "A copy of a repository under your account",
            "A branch in the same repository",
            "A commit with multiple parents",
            "A merge conflict"
        ],
        correctAnswer: 0
    },
    {
        question: "What is the purpose of a Pull Request?",
        options: [
            "To download code from remote",
            "To propose changes for review and merging",
            "To delete a branch",
            "To create a new repository"
        ],
        correctAnswer: 1
    },
    {
        question: "Which GitHub feature helps organize and track work items?",
        options: ["Forks", "Issues", "Commits", "Branches"],
        correctAnswer: 1
    },
    {
        question: "What are GitHub Actions used for?",
        options: [
            "Managing repository permissions",
            "Automating workflows and CI/CD",
            "Creating branches",
            "Viewing commit history"
        ],
        correctAnswer: 1
    },
    {
        question: "In GitHub, what is a Project Board used for?",
        options: [
            "Managing and tracking issues and pull requests",
            "Storing files",
            "Running tests",
            "Managing branches"
        ],
        correctAnswer: 0
    },
    {
        question: "What happens when you create a fork of a repository?",
        options: [
            "You get write access to the original repository",
            "You create a copy under your account",
            "You create a new branch",
            "You delete the original"
        ],
        correctAnswer: 1
    },
    {
        question: "To contribute to an open-source project on GitHub, what is the typical workflow?",
        options: [
            "Clone → Commit → Push to main",
            "Fork → Clone → Branch → Commit → Push → Pull Request",
            "Download → Edit → Email maintainer",
            "Fork → Delete → Create new"
        ],
        correctAnswer: 1
    },
    {
        question: "What is the purpose of GitHub Issues?",
        options: [
            "To track bugs, features, and tasks",
            "To store code files",
            "To create branches",
            "To merge pull requests"
        ],
        correctAnswer: 0
    },
    {
        question: "Which file in a repository typically contains project documentation?",
        options: ["INDEX.html", "README.md", "DOCS.txt", "INFO.doc"],
        correctAnswer: 1
    },
    {
        question: "What does CI/CD stand for in the context of GitHub Actions?",
        options: [
            "Code Integration / Code Deployment",
            "Continuous Integration / Continuous Deployment",
            "Complete Integration / Complete Development",
            "Central Integration / Central Distribution"
        ],
        correctAnswer: 1
    },

    // Networking Commands Questions (Q41-Q50)
    {
        question: "Which command tests network connectivity to a host?",
        options: ["ping", "traceroute", "netstat", "ifconfig"],
        correctAnswer: 0
    },
    {
        question: "The 'ss' command is a modern replacement for which older command?",
        options: ["ping", "netstat", "ifconfig", "route"],
        correctAnswer: 1
    },
    {
        question: "To display network interface configuration, which command is used?",
        options: ["ifconfig", "ip addr", "netstat", "Both A and B"],
        correctAnswer: 3
    },
    {
        question: "Which command downloads files from the web via command line?",
        options: ["download", "get", "wget", "fetch"],
        correctAnswer: 2
    },
    {
        question: "The 'curl' command is primarily used for?",
        options: [
            "Compressing files",
            "Transferring data with URLs",
            "Managing users",
            "Editing files"
        ],
        correctAnswer: 1
    },
    {
        question: "To view active network connections in real-time, which command is useful?",
        options: ["ss -t", "netstat -an", "ip addr", "Both A and B"],
        correctAnswer: 3
    },
    {
        question: "Which command shows the routing table?",
        options: ["route", "ip route", "netstat -r", "All of the above"],
        correctAnswer: 3
    },
    {
        question: "To test DNS resolution, which command can be used?",
        options: ["nslookup", "dig", "host", "All of the above"],
        correctAnswer: 3
    },
    {
        question: "Which port does SSH typically use?",
        options: ["21", "22", "23", "80"],
        correctAnswer: 1
    },
    {
        question: "To download a file and save it with a different name using wget, which option is used?",
        options: ["-O", "-o", "-s", "-n"],
        correctAnswer: 0
    },

    // System Administration Questions (Q51-Q60)
    {
        question: "A server needs secure remote administration. Which syllabus technology should be used?",
        options: ["SSH", "tar", "cron", "Git issues"],
        correctAnswer: 0
    },
    {
        question: "Which system is used for mandatory access control in Linux?",
        options: ["firewall", "SELinux", "iptables", "sudo"],
        correctAnswer: 1
    },
    {
        question: "To schedule recurring tasks in Linux, which daemon is used?",
        options: ["at", "cron", "systemd", "init"],
        correctAnswer: 1
    },
    {
        question: "The 'at' command is used for?",
        options: [
            "Scheduling one-time tasks",
            "Scheduling recurring tasks",
            "Managing services",
            "Viewing logs"
        ],
        correctAnswer: 0
    },
    {
        question: "Which tool helps protect against brute-force attacks by monitoring log files?",
        options: ["firewall", "fail2ban", "SELinux", "iptables"],
        correctAnswer: 1
    },
    {
        question: "To audit system events and track security-relevant information, which system is used?",
        options: ["syslog", "auditd", "journald", "dmesg"],
        correctAnswer: 1
    },
    {
        question: "Which file contains cron job schedules for the current user?",
        options: ["/etc/crontab", "crontab -e", "/var/spool/cron/user", "Both B and C"],
        correctAnswer: 3
    },
    {
        question: "To connect to a remote server securely, which command is used?",
        options: ["telnet user@host", "ssh user@host", "ftp user@host", "rlogin user@host"],
        correctAnswer: 1
    },
    {
        question: "Which SELinux mode enforces security policies?",
        options: ["Permissive", "Enforcing", "Disabled", "Monitoring"],
        correctAnswer: 1
    },
    {
        question: "To view the current SELinux status, which command is used?",
        options: ["selinux-status", "sestatus", "getenforce", "Both B and C"],
        correctAnswer: 3
    }
];

// ============================================
// CIVIL EXAM QUESTION SELECTOR
// ============================================
// Randomly selects 20 questions from the 60-question bank
// Uses Fisher-Yates shuffle for true randomization
// Every student gets different questions

function selectCivilExamQuestions() {
    // Create array of indices [0, 1, 2, ..., 59]
    let indices = Array.from({ length: civilQuestionBank.length }, (_, i) => i);
    
    // Fisher-Yates shuffle
    for (let i = indices.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [indices[i], indices[j]] = [indices[j], indices[i]];
    }
    
    // Take first 20 indices
    const selectedIndices = indices.slice(0, 20);
    
    // Get corresponding questions
    const selectedQuestions = selectedIndices.map(index => civilQuestionBank[index]);
    
    console.log('Civil Exam: Selected 20 random questions from 60-question bank');
    return selectedQuestions;
}

// Export for use in main script
if (typeof window !== 'undefined') {
    window.civilQuestionBank = civilQuestionBank;
    window.selectCivilExamQuestions = selectCivilExamQuestions;
}
