// CSE/Civil/ECE/IT/AIDS Exam Questions - Git, Linux, GitHub, Networking
// Total: 60 questions
// Each student gets 20 random questions

let cseQuestionBank = [
    // Q1-Q20
    {
        question: "A developer needs a local copy of a remote repository. Which command is appropriate?",
        options: ["git init", "git clone", "git add", "git reset"],
        correct: 1
    },
    {
        question: "A contributor cannot directly modify the original repository and needs their own copy on GitHub. Which feature is appropriate?",
        options: ["Issue", "Action", "Fork", "Discussion"],
        correct: 2
    },
    {
        question: "Which command changes file ownership?",
        options: ["jobs", "df", "chown", "chmod"],
        correct: 2
    },
    {
        question: "Which command stages a modified file named `app.py` for the next commit?",
        options: ["git add app.py", "git log app.py", "git branch app.py", "git clone app.py"],
        correct: 0
    },
    {
        question: "Which command changes the password of the current user?",
        options: ["passwd", "groups", "ps", "df"],
        correct: 0
    },
    {
        question: "Which package manager listed in the syllabus is used on modern Fedora-family systems?",
        options: ["sudo", "cat", "dnf", "fg"],
        correct: 2
    },
    {
        question: "Which GitHub feature is the standard place to report a bug or request a feature?",
        options: ["Issues", "Releases only", "Git stash", "Linux jobs"],
        correct: 0
    },
    {
        question: "A team wants a board for tracking work items visually. Which feature is appropriate?",
        options: ["Pull request only", "git fetch", "HEAD", "Project Boards"],
        correct: 3
    },
    {
        question: "Which auditing tool is explicitly included in the syllabus?",
        options: ["wget", "vim", "df", "auditd"],
        correct: 3
    },
    {
        question: "Which firewall utility provides a simplified interface commonly used on Ubuntu systems?",
        options: ["ufw", "gpg", "nice", "KVM"],
        correct: 0
    },
    {
        question: "Which command changes file permissions?",
        options: ["chmod", "ps", "umask", "chown"],
        correct: 0
    },
    {
        question: "Which synchronization tool is listed for backup and restore?",
        options: ["service", "rsync", "mount", "parted"],
        correct: 1
    },
    {
        question: "Which command attaches a file system to the Linux directory tree?",
        options: ["mount", "umount", "journalctl", "rsync"],
        correct: 0
    },
    {
        question: "Which command displays kernel-related messages for troubleshooting?",
        options: ["parted", "service", "rsync", "dmesg"],
        correct: 3
    },
    {
        question: "Which modern command can display socket information?",
        options: ["ss", "curl", "cron", "wget"],
        correct: 0
    },
    {
        question: "Which command displays commit history?",
        options: ["git branch", "git add", "git log", "git clone"],
        correct: 2
    },
    {
        question: "In a Bash script, which line is commonly used as the interpreter directive?",
        options: ["#!/bin/bash", "//bin/bash", "@bash", "<bash>"],
        correct: 0
    },
    {
        question: "Which pair is specifically listed for examining network/socket information?",
        options: ["netstat and ss", "cron and at", "curl and wget", "loops and functions"],
        correct: 0
    },
    {
        question: "Which command displays network connections and related information?",
        options: ["ping", "netstat", "at", "wget"],
        correct: 1
    },
    {
        question: "Which Bash construct is used to choose between alternatives based on a condition?",
        options: ["if", "mount", "ping", "alias"],
        correct: 0
    },
    
    // Q21-Q40
    {
        question: "A one-time task must run later today. Which scheduler is appropriate?",
        options: ["cron", "curl", "at", "netstat"],
        correct: 2
    },
    {
        question: "Which command adds a remote named `origin`?",
        options: ["git remote add origin", "git status", "git init", "git branch"],
        correct: 0
    },
    {
        question: "An administrator wants to remove an existing user account. Which command is appropriate?",
        options: ["userdel", "useradd", "uptime", "top"],
        correct: 0
    },
    {
        question: "To quickly create `notes.txt` as an empty file, which command is appropriate?",
        options: ["touch", "less", "rm", "cd"],
        correct: 0
    },
    {
        question: "Which syllabus topic focuses on handling incompatible branch changes?",
        options: ["Firewall security", "Linux file permissions", "Process limits", "Merge conflicts and resolutions"],
        correct: 3
    },
    {
        question: "Which topic describes the Linux startup sequence?",
        options: ["Open-source history", "File tracking", "Pull request", "Boot process"],
        correct: 3
    },
    {
        question: "Which command creates a compressed gzip tar archive named `backup.tar.gz` from folder `data`?",
        options: ["tar -czf backup.tar.gz data", "mount backup.tar.gz data", "rsync -d backup.tar.gz", "lsblk backup.tar.gz"],
        correct: 0
    },
    {
        question: "A student wants to display the contents of a short text file directly in the terminal. Which command is appropriate?",
        options: ["cat", "pwd", "mkdir", "cd"],
        correct: 0
    },
    {
        question: "Which command records staged changes in the local repository?",
        options: ["git commit", "git fetch", "git clone", "git status"],
        correct: 0
    },
    {
        question: "Which traditional command is also listed for service management?",
        options: ["service", "rsync", "parted", "mount"],
        correct: 0
    },
    {
        question: "System activity needs auditing. Which syllabus tool is most relevant?",
        options: ["VirtualBox", "nice", "openssl", "auditd"],
        correct: 3
    },
    {
        question: "A developer wants teammates to review a feature branch before it enters main. What should be opened?",
        options: ["Pull request", "Disk partition", "Cron job", "User group"],
        correct: 0
    },
    {
        question: "A mounted file system must be safely detached. Which command is appropriate?",
        options: ["parted", "journalctl", "umount", "rsync"],
        correct: 2
    },
    {
        question: "Which security topic controls how users prove their identity?",
        options: ["User authentication", "File copying", "Git branching", "Disk partitioning"],
        correct: 0
    },
    {
        question: "A student wants to enter another directory. Which command should be used?",
        options: ["more", "ls", "touch", "cd"],
        correct: 3
    },
    {
        question: "Which firewall management service is commonly associated with Fedora/RHEL-family systems?",
        options: ["firewalld", "passwd", "rsync", "git"],
        correct: 0
    },
    {
        question: "Which command switches to another user account?",
        options: ["id", "groups", "su", "free"],
        correct: 2
    },
    {
        question: "Which command displays messages from the systemd journal?",
        options: ["journalctl", "fdisk", "parted", "lsblk"],
        correct: 0
    },
    {
        question: "Repeated malicious login attempts need automatic blocking. Which tool is most relevant?",
        options: ["fail2ban", "KVM", "Docker", "gpg"],
        correct: 0
    },
    {
        question: "Which scripting element stores a value for later use?",
        options: ["Snapshot", "Firewall", "Repository", "Variable"],
        correct: 3
    },
    
    // Q41-Q60
    {
        question: "Which mandatory-access-control technology is introduced in the syllabus?",
        options: ["cron", "GitHub Actions", "tar", "SELinux"],
        correct: 3
    },
    {
        question: "Which command is used to terminate a process?",
        options: ["jobs", "yum", "free", "kill"],
        correct: 3
    },
    {
        question: "Which command tests basic reachability of a remote host?",
        options: ["ping", "cron", "at", "alias"],
        correct: 0
    },
    {
        question: "Which command-line tool can create encrypted or signed data using OpenPGP?",
        options: ["gpg", "top", "df", "mount"],
        correct: 0
    },
    {
        question: "Which file system is listed along with ext4?",
        options: ["Git", "SSH", "LXC", "xfs"],
        correct: 3
    },
    {
        question: "To inspect IP addresses assigned to interfaces, which command should be used?",
        options: ["wget", "curl", "at", "ip addr"],
        correct: 3
    },
    {
        question: "Which chapter includes both shell automation and networking operations?",
        options: ["GitHub Collaboration", "Linux Scripting & Networking", "Linux Fundamentals", "Git Version Control"],
        correct: 1
    },
    {
        question: "Which utility can transfer data to or from a URL and is commonly used with web APIs?",
        options: ["curl", "jobs", "passwd", "df"],
        correct: 0
    },
    {
        question: "Which enhanced version of vi is listed in the syllabus?",
        options: ["top", "yum", "ping", "vim"],
        correct: 3
    },
    {
        question: "A developer wants to obtain remote updates before deciding how to integrate them. Which command is appropriate?",
        options: ["git push", "git init", "git fetch", "git commit"],
        correct: 2
    },
    {
        question: "Which topic is part of the Git installation unit?",
        options: ["SSH daemon logs", "Git configuration", "Linux firewall zones", "Disk formatting"],
        correct: 1
    },
    {
        question: "Which command queries logs managed by systemd?",
        options: ["tar", "fdisk", "journalctl", "umount"],
        correct: 2
    },
    {
        question: "Which command creates a new Git repository in the current directory?",
        options: ["git log", "git clone", "git init", "git status"],
        correct: 2
    },
    {
        question: "Which command creates a new directory named `project`?",
        options: ["rm project", "mkdir project", "pwd project", "less project"],
        correct: 1
    },
    {
        question: "Which command creates and switches to a new branch named `feature` using traditional syntax?",
        options: ["git checkout -b feature", "git init feature", "git log feature", "git reset feature"],
        correct: 0
    },
    {
        question: "Which of the following is a Linux distribution?",
        options: ["Dockerfile", "Ubuntu", "GitHub", "Bash function"],
        correct: 1
    },
    {
        question: "Which command displays IP address information for network interfaces?",
        options: ["ip addr", "cron", "ping", "at"],
        correct: 0
    },
    {
        question: "Which GitHub collaboration mechanism creates a personal copy of another repository?",
        options: ["Fork", "Issue", "Commit message", "Action"],
        correct: 0
    },
    {
        question: "Which command copies an existing Git repository?",
        options: ["git add", "git revert", "git init", "git clone"],
        correct: 3
    },
    {
        question: "Which container technology is listed along with Docker?",
        options: ["LXC", "KVM", "Git", "VirtualBox"],
        correct: 0
    }
];

// Function to select 20 random questions for CSE exam
function selectCSEExamQuestions() {
    // Create a copy of the question bank
    let availableQuestions = [...cseQuestionBank];
    let selectedQuestions = [];
    
    // Fisher-Yates shuffle algorithm to randomize
    for (let i = availableQuestions.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [availableQuestions[i], availableQuestions[j]] = [availableQuestions[j], availableQuestions[i]];
    }
    
    // Select first 20 questions after shuffle
    selectedQuestions = availableQuestions.slice(0, 20);
    
    return selectedQuestions;
}
