// Linux Operating System Questions - 100 Questions
// For FFCSE, FFIT, FFAIDS, FFECE exams
// 25 random questions selected per exam

const linuxQuestions = [
    {
        question: "Linux is best described as:",
        options: [
            "An open-source operating system kernel and ecosystem",
            "A proprietary word processor",
            "A database language",
            "A web browser"
        ],
        correctAnswer: 0
    },
    {
        question: "Who created the Linux kernel?",
        options: [
            "Linus Torvalds",
            "Dennis Ritchie",
            "Bill Gates",
            "Tim Berners-Lee"
        ],
        correctAnswer: 0
    },
    {
        question: "Which idea is central to open-source software?",
        options: [
            "Source code can be studied and modified under its license",
            "Source code must always remain secret",
            "Only one vendor can distribute it",
            "It cannot be shared"
        ],
        correctAnswer: 0
    },
    {
        question: "Which of the following is a Linux distribution?",
        options: [
            "Ubuntu",
            "MS Word",
            "Oracle SQL",
            "Photoshop"
        ],
        correctAnswer: 0
    },
    {
        question: "Which is another Linux distribution listed in the syllabus?",
        options: [
            "Fedora",
            "Excel",
            "ChromeOS only",
            "PowerPoint"
        ],
        correctAnswer: 0
    },
    {
        question: "CentOS is associated with:",
        options: [
            "Linux distributions",
            "Text editing only",
            "Database normalization",
            "Spreadsheet formulas"
        ],
        correctAnswer: 0
    },
    {
        question: "Which directory is the root of the Linux file-system hierarchy?",
        options: [
            "/",
            "/root only",
            "C:\\",
            "~root"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command prints the current working directory?",
        options: [
            "pwd",
            "ls",
            "cd",
            "cat"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command lists directory contents?",
        options: [
            "ls",
            "pwd",
            "rm",
            "touch"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command changes the current directory?",
        options: [
            "cd",
            "cat",
            "more",
            "pwd"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command displays the contents of a text file?",
        options: [
            "cat",
            "mkdir",
            "touch",
            "mv"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command is suitable for viewing text one screen at a time?",
        options: [
            "more",
            "rm",
            "cp",
            "pwd"
        ],
        correctAnswer: 0
    },
    {
        question: "Compared with more, which command commonly provides flexible forward/backward viewing?",
        options: [
            "less",
            "touch",
            "mv",
            "cd"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command copies a file?",
        options: [
            "cp",
            "mv",
            "rm",
            "cat"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command can move or rename a file?",
        options: [
            "mv",
            "cp",
            "pwd",
            "less"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command removes a file?",
        options: [
            "rm",
            "touch",
            "cat",
            "pwd"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command can create an empty file or update its timestamp?",
        options: [
            "touch",
            "rm",
            "mv",
            "less"
        ],
        correctAnswer: 0
    },
    {
        question: "Which of these is a terminal text editor?",
        options: [
            "nano",
            "pwd",
            "ls",
            "cp"
        ],
        correctAnswer: 0
    },
    {
        question: "Which is a classic Unix/Linux modal text editor?",
        options: [
            "vi",
            "cat",
            "touch",
            "rm"
        ],
        correctAnswer: 0
    },
    {
        question: "vim is best described as:",
        options: [
            "An enhanced vi-style editor",
            "A package manager",
            "A file system",
            "A boot loader"
        ],
        correctAnswer: 0
    },
    {
        question: "What does the path /home commonly contain?",
        options: [
            "Users' home directories",
            "Kernel source only",
            "Device files only",
            "Temporary boot files only"
        ],
        correctAnswer: 0
    },
    {
        question: "What does ~ commonly represent in a shell?",
        options: [
            "Current user's home directory",
            "Root of all files",
            "Current process ID",
            "A comment"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command would most directly show files in /etc?",
        options: [
            "ls /etc",
            "pwd /etc",
            "cd --show /etc",
            "cat --dir /etc"
        ],
        correctAnswer: 0
    },
    {
        question: "Which operation best preserves the original while creating another copy?",
        options: [
            "cp",
            "mv",
            "rm",
            "touch"
        ],
        correctAnswer: 0
    },
    {
        question: "If you want to rename report.txt to final.txt in the same directory, which is appropriate?",
        options: [
            "mv report.txt final.txt",
            "cp final.txt report.txt",
            "rm report.txt final.txt",
            "touch report.txt final.txt"
        ],
        correctAnswer: 0
    },
    {
        question: "Which combination best supports basic Linux navigation?",
        options: [
            "pwd, ls, cd",
            "kill, top, ps",
            "apt, yum, dnf",
            "chmod, chown, umask"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command is used to add a user on many Linux systems?",
        options: [
            "useradd",
            "userdelgroup",
            "mkuserfile",
            "addprocess"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command changes or sets a user's password?",
        options: [
            "passwd",
            "passwordctl",
            "pwd",
            "chpassfile"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command can switch to another user account?",
        options: [
            "su",
            "ls",
            "df",
            "ps"
        ],
        correctAnswer: 0
    },
    {
        question: "sudo is primarily used to:",
        options: [
            "Run permitted commands with elevated/other-user privileges",
            "List files",
            "Measure disk space",
            "Edit only text files"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command displays user and group identity information?",
        options: [
            "id",
            "df",
            "top",
            "free"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command shows group memberships?",
        options: [
            "groups",
            "jobs",
            "uptime",
            "du"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command changes file permission bits?",
        options: [
            "chmod",
            "chown",
            "umask",
            "passwd"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command changes file ownership?",
        options: [
            "chown",
            "chmod",
            "ps",
            "df"
        ],
        correctAnswer: 0
    },
    {
        question: "umask is used to influence:",
        options: [
            "Default permissions for newly created files/directories",
            "CPU scheduling only",
            "Network routing",
            "Package repositories"
        ],
        correctAnswer: 0
    },
    {
        question: "In rwxr-xr--, the owner's permissions are:",
        options: [
            "rwx",
            "r-x",
            "r--",
            "---"
        ],
        correctAnswer: 0
    },
    {
        question: "Which permission allows reading file contents?",
        options: [
            "r",
            "w",
            "x",
            "s"
        ],
        correctAnswer: 0
    },
    {
        question: "Which permission allows modifying a file?",
        options: [
            "w",
            "r",
            "x",
            "t"
        ],
        correctAnswer: 0
    },
    {
        question: "Which permission allows executing a file as a program/script?",
        options: [
            "x",
            "r",
            "w",
            "d"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command shows running processes?",
        options: [
            "ps",
            "cp",
            "df",
            "apt"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command provides an interactive process view?",
        options: [
            "top",
            "touch",
            "groups",
            "du"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command sends a signal to a process?",
        options: [
            "kill",
            "rm",
            "mv",
            "free"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command lists jobs started from the current shell?",
        options: [
            "jobs",
            "pswd",
            "groups",
            "df"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command brings a background job to the foreground?",
        options: [
            "fg",
            "bg",
            "top",
            "id"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command resumes/places a job in the background?",
        options: [
            "bg",
            "fg",
            "du",
            "free"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command reports file-system disk space usage?",
        options: [
            "df",
            "du",
            "free",
            "uptime"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command estimates space used by files/directories?",
        options: [
            "du",
            "df",
            "top",
            "jobs"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command displays memory usage?",
        options: [
            "free",
            "df",
            "du",
            "ps"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command shows system uptime?",
        options: [
            "uptime",
            "free",
            "df",
            "top"
        ],
        correctAnswer: 0
    },
    {
        question: "Which package manager is commonly used on Debian/Ubuntu?",
        options: [
            "apt",
            "yum",
            "dnf",
            "pacman"
        ],
        correctAnswer: 0
    },
    {
        question: "Which package managers are commonly associated with RPM-based distributions?",
        options: [
            "yum and dnf",
            "apt and nano",
            "pwd and cd",
            "cp and mv"
        ],
        correctAnswer: 0
    },
    {
        question: "A process consumes excessive CPU. Which pair is most useful to identify and terminate it?",
        options: [
            "top and kill",
            "cp and mv",
            "df and du",
            "chmod and chown"
        ],
        correctAnswer: 0
    },
    {
        question: "An environment variable is used to:",
        options: [
            "Store values that influence shell/program behavior",
            "Format a disk only",
            "Create users only",
            "Terminate every process"
        ],
        correctAnswer: 0
    },
    {
        question: "Which variable commonly contains directories searched for executable commands?",
        options: [
            "PATH",
            "HOMEFILE",
            "EXECUTE",
            "SHELLPATHFILE"
        ],
        correctAnswer: 0
    },
    {
        question: "An alias in a shell is primarily used to:",
        options: [
            "Create a shorthand for a command",
            "Create a disk partition",
            "Encrypt a file",
            "Add a user"
        ],
        correctAnswer: 0
    },
    {
        question: "A shell script is:",
        options: [
            "A file containing shell commands for execution",
            "A hardware driver only",
            "A compiled kernel module only",
            "A database table"
        ],
        correctAnswer: 0
    },
    {
        question: "Which line is commonly used as a Bash shebang?",
        options: [
            "#!/bin/bash",
            "#include <bash>",
            "//bin/bash",
            "bash#!"
        ],
        correctAnswer: 0
    },
    {
        question: "Which symbol is commonly used to access a shell variable's value?",
        options: [
            "$",
            "%",
            "@",
            "#"
        ],
        correctAnswer: 0
    },
    {
        question: "Which construct is used for decision-making in Bash scripts?",
        options: [
            "if",
            "mount",
            "ping",
            "tar"
        ],
        correctAnswer: 0
    },
    {
        question: "Which construct can repeat commands in a shell script?",
        options: [
            "for loop",
            "chmod",
            "df",
            "ssh key"
        ],
        correctAnswer: 0
    },
    {
        question: "Which construct is useful for repetition while a condition remains true?",
        options: [
            "while",
            "case file only",
            "tar",
            "curl"
        ],
        correctAnswer: 0
    },
    {
        question: "A shell function is useful for:",
        options: [
            "Grouping reusable commands",
            "Creating a partition table only",
            "Changing kernel version",
            "Replacing the file system"
        ],
        correctAnswer: 0
    },
    {
        question: "Which service schedules recurring jobs?",
        options: [
            "cron",
            "at",
            "ping",
            "curl"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command is designed for scheduling a one-time job?",
        options: [
            "at",
            "cron",
            "ss",
            "wget"
        ],
        correctAnswer: 0
    },
    {
        question: "A crontab entry is used to define:",
        options: [
            "Scheduled recurring commands",
            "File ownership",
            "Disk partitions",
            "Password hashes only"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command tests basic network reachability?",
        options: [
            "ping",
            "pwd",
            "du",
            "jobs"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command can transfer data using URLs and is commonly used with web APIs?",
        options: [
            "curl",
            "chmod",
            "ps",
            "free"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command is commonly used to download files from the web?",
        options: [
            "wget",
            "fg",
            "id",
            "lsblk"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command historically displays network connections and statistics?",
        options: [
            "netstat",
            "touch",
            "nano",
            "passwd"
        ],
        correctAnswer: 0
    },
    {
        question: "Which modern command can display socket information?",
        options: [
            "ss",
            "su",
            "cp",
            "at"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command displays/configures IP address information in modern Linux?",
        options: [
            "ip addr",
            "pwd addr",
            "df ip",
            "cat net"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command would best test whether a remote host responds to ICMP echo requests?",
        options: [
            "ping",
            "wget",
            "chmod",
            "jobs"
        ],
        correctAnswer: 0
    },
    {
        question: "Which is the best reason to automate repetitive administration tasks with Bash?",
        options: [
            "Consistency and reduced manual effort",
            "To eliminate all security requirements",
            "To avoid using commands",
            "To replace the operating system"
        ],
        correctAnswer: 0
    },
    {
        question: "A script needs to perform an action for every file in a list. Which structure is most suitable?",
        options: [
            "for loop",
            "single echo only",
            "umask",
            "systemctl"
        ],
        correctAnswer: 0
    },
    {
        question: "A script should execute backup commands only when a directory exists. Which feature is most relevant?",
        options: [
            "Conditional statement",
            "Package manager",
            "Boot target",
            "Firewall rule"
        ],
        correctAnswer: 0
    },
    {
        question: "To run a maintenance script every day automatically, which facility is most appropriate?",
        options: [
            "cron",
            "at for one-time only",
            "ping",
            "ss"
        ],
        correctAnswer: 0
    },
    {
        question: "To schedule a shutdown-related command once at a specific later time, which tool is most appropriate?",
        options: [
            "at",
            "cron only",
            "curl",
            "alias"
        ],
        correctAnswer: 0
    },
    {
        question: "A simple Bash automation project most directly demonstrates:",
        options: [
            "Combining commands, variables, conditions and loops to automate a task",
            "Replacing Linux with another OS",
            "Designing a CPU",
            "Creating a spreadsheet"
        ],
        correctAnswer: 0
    },
    {
        question: "systemd is primarily used for:",
        options: [
            "System and service management",
            "Editing images",
            "Compiling C only",
            "Managing Git repositories"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command manages systemd services?",
        options: [
            "systemctl",
            "fdisk",
            "tar",
            "lsblk"
        ],
        correctAnswer: 0
    },
    {
        question: "A systemd target is conceptually related to:",
        options: [
            "A desired system state/group of units",
            "A disk sector only",
            "A user password",
            "A Git branch"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command can show block devices?",
        options: [
            "lsblk",
            "ls",
            "cat",
            "free"
        ],
        correctAnswer: 0
    },
    {
        question: "Which tool can manipulate disk partition tables?",
        options: [
            "fdisk",
            "ping",
            "jobs",
            "nano"
        ],
        correctAnswer: 0
    },
    {
        question: "Which is another disk partitioning tool listed in the syllabus?",
        options: [
            "parted",
            "curl",
            "uptime",
            "chown"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command attaches a file system to the directory tree?",
        options: [
            "mount",
            "umount",
            "kill",
            "tar"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command detaches a mounted file system?",
        options: [
            "umount",
            "mount",
            "mv",
            "free"
        ],
        correctAnswer: 0
    },
    {
        question: "Which is a common Linux file system?",
        options: [
            "ext4",
            "NTTEXT",
            "HTTPFS",
            "GITFS"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command creates a new directory?",
        options: [
            "mkdir",
            "mkfile",
            "newdir",
            "createdir"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command removes an empty directory?",
        options: [
            "rmdir",
            "rm",
            "deletedir",
            "remdir"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command can search for files in a directory hierarchy?",
        options: [
            "find",
            "search",
            "locate",
            "grep"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command searches for patterns within files?",
        options: [
            "grep",
            "find",
            "search",
            "look"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command displays the first few lines of a file?",
        options: [
            "head",
            "tail",
            "top",
            "first"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command displays the last few lines of a file?",
        options: [
            "tail",
            "head",
            "bottom",
            "last"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command compares two files line by line?",
        options: [
            "diff",
            "cmp",
            "compare",
            "check"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command creates compressed archive files?",
        options: [
            "tar",
            "zip",
            "compress",
            "archive"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command compresses files using gzip compression?",
        options: [
            "gzip",
            "compress",
            "zip",
            "tar"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command decompresses gzip files?",
        options: [
            "gunzip",
            "unzip",
            "decompress",
            "extract"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command displays or sets the system date and time?",
        options: [
            "date",
            "time",
            "clock",
            "datetime"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command displays a calendar?",
        options: [
            "cal",
            "calendar",
            "date",
            "time"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command clears the terminal screen?",
        options: [
            "clear",
            "cls",
            "clean",
            "reset"
        ],
        correctAnswer: 0
    },
    {
        question: "Which command displays a line of text?",
        options: [
            "echo",
            "print",
            "display",
            "show"
        ],
        correctAnswer: 0
    }
];

// Function to select random Linux questions for exam
function selectLinuxExamQuestions() {
    // Shuffle and select 25 random questions
    const shuffled = [...linuxQuestions].sort(() => 0.5 - Math.random());
    return shuffled.slice(0, 25);
}

// Make function available globally
if (typeof window !== 'undefined') {
    window.selectLinuxExamQuestions = selectLinuxExamQuestions;
}
