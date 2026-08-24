// CSE Exam Questions - Git, Linux, GitHub, Networking
// Total: 60 questions
// Each student gets 20 random questions

let cseQuestionBank = [
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
        question: "Which pair contains only undoing-change commands explicitly listed in the syllabus?",
        options: ["git branch and git merge", "git init and git clone", "git add and git commit", "git reset and git revert"],
        correct: 3
    },
    {
        question: "Which command reports file-system disk-space usage?",
        options: ["df", "du", "free", "top"],
        correct: 0
    },
    {
        question: "Which package manager listed in the syllabus is used on modern Fedora-family systems?",
        options: ["sudo", "cat", "dnf", "fg"],
        correct: 2
    },
    {
        question: "Which sequence best matches the basic collaboration workflow named in the syllabus?",
        options: ["Clone → useradd → mount", "Push → firewall → snapshot", "Feature branch → pull request → merge", "Issue → disk format → merge"],
        correct: 2
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
        question: "Which desktop virtualization platform is explicitly listed?",
        options: ["auditd", "fail2ban", "iptables", "VirtualBox"],
        correct: 3
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
        question: "A service must be managed on a systemd-based machine. Which command is appropriate?",
        options: ["systemctl", "parted", "tar", "lsblk"],
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
        question: "A script needs to check whether a server responds. Which command is suitable?",
        options: ["alias", "wget", "ping", "at"],
        correct: 2
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
        question: "A script must repeat a command ten times. Which construct is most appropriate?",
        options: ["Network command", "Alias", "Environment variable", "Loop"],
        correct: 3
    },
    {
        question: "A one-time task must run later today. Which scheduler is appropriate?",
        options: ["cron", "curl", "at", "netstat"],
        correct: 2
    },
    {
        question: "Which command adds a remote named origin?",
        options: ["git remote add origin", "git status", "git init", "git branch"],
        correct: 0
    },
    {
        question: "Which command provides an interactive view of running processes?",
        options: ["top", "ps", "df", "fg"],
        correct: 0
    },
    {
        question: "To quickly create notes.txt as an empty file, which command is appropriate?",
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
        question: "Files must be synchronized to a backup location. Which utility is appropriate?",
        options: ["fdisk", "mount", "systemctl", "rsync"],
        correct: 3
    },
    {
        question: "Which command copies a file?",
        options: ["cp", "rm", "mv", "pwd"],
        correct: 0
    },
    {
        question: "What is the purpose of a .gitignore file?",
        options: ["Ignore unnecessary files from tracking", "Schedule jobs", "Create a firewall", "Delete the repository"],
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
        question: "What does CI/CD automation in this syllabus primarily relate to?",
        options: ["Linux text editors", "Disk partitions", "GitHub Actions workflows", "User groups"],
        correct: 2
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
        question: "A server needs secure remote administration. Which syllabus technology should be used?",
        options: ["SSH", "tar", "cron", "Git issues"],
        correct: 0
    },
    {
        question: "Which command switches to another user account?",
        options: ["id", "groups", "su", "free"],
        correct: 2
    },
    {
        question: "Which pair contains only troubleshooting/logging items from the syllabus?",
        options: ["mount and umount", "journalctl and dmesg", "tar and rsync", "fdisk and parted"],
        correct: 1
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
        question: "Which utility schedules a job for a specified later time?",
        options: ["at", "cron", "wget", "ss"],
        correct: 0
    },
    {
        question: "An existing process priority must be changed. Which command is appropriate?",
        options: ["openssl", "renice", "fail2ban", "ulimit"],
        correct: 1
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
        question: "Which pair contains only web/network access commands from the syllabus?",
        options: ["curl and wget", "functions and aliases", "cron and at", "variables and loops"],
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
        question: "Which command removes a file?",
        options: ["touch", "pwd", "rm", "less"],
        correct: 2
    },
    {
        question: "Which type of files does the syllabus mention as candidates for .gitignore?",
        options: ["Logs and build files", "Linux distributions", "Mounted file systems", "User passwords"],
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
    // Shuffle all questions
    let shuffled = [...cseQuestionBank];
    
    // Fisher-Yates shuffle
    for (let i = shuffled.length - 1; i > 0; i--) {
        let j = Math.floor(Math.random() * (i + 1));
        [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
    }
    
    // Return first 20 questions
    return shuffled.slice(0, 20);
}
