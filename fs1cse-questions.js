// FS1 CSE Exam Questions - C Programming
// Total questions: 100
// Each student gets 25 random questions
// Exam duration: 30 minutes

let fs1cseQuestionBank = [
    // Unit 1 - Questions 1-40
    {question:"What is the primary purpose of the Program Development Life Cycle (PDLC)?",options:["To provide a systematic process for developing programs","To increase processor speed","To design computer hardware","To replace operating systems"],correct:0},
    {question:"Which PDLC stage normally comes first?",options:["Coding","Problem definition and analysis","Testing","Maintenance"],correct:1},
    {question:"During problem analysis, the programmer mainly identifies:",options:["Only the programming language","Inputs, outputs, and processing requirements","The monitor resolution","The compiler version only"],correct:1},
    {question:"An algorithm is best described as:",options:["A hardware device","A finite sequence of steps to solve a problem","A compiled program only","A type of variable"],correct:1},
    {question:"Which representation uses standard symbols to show program logic graphically?",options:["Flowchart","Source file","Object file","Header file"],correct:0},
    {question:"Which flowchart symbol is commonly used for a decision?",options:["Rectangle","Diamond","Circle","Parallelogram"],correct:1},
    {question:"Which flowchart symbol is commonly used for input/output?",options:["Parallelogram","Diamond","Rectangle","Oval"],correct:0},
    {question:"Which flowchart symbol usually represents processing?",options:["Rectangle","Diamond","Oval","Arrow"],correct:0},
    {question:"The start and end of a flowchart are commonly represented by:",options:["Terminator/oval symbols","Diamonds","Rectangles","Parallelograms"],correct:0},
    {question:"A dry run of an algorithm means:",options:["Executing it manually with sample data","Deleting the algorithm","Compiling hardware","Formatting the disk"],correct:0},
    {question:"Which PDLC activity checks whether a program produces expected results?",options:["Testing","Problem definition","Documentation only","Installation of hardware"],correct:0},
    {question:"Debugging is the process of:",options:["Finding and correcting program errors","Writing only comments","Creating hardware circuits","Converting decimal to binary"],correct:0},
    {question:"Documentation in PDLC is useful because it:",options:["Helps users and developers understand the program","Eliminates the need for testing","Prevents all errors automatically","Replaces source code"],correct:0},
    {question:"Maintenance of a program generally occurs:",options:["After implementation/deployment","Before problem definition","Before writing an algorithm","Only before compilation"],correct:0},
    {question:"C was originally developed by:",options:["Dennis Ritchie","James Gosling","Bjarne Stroustrup","Guido van Rossum"],correct:0},
    {question:"C is commonly classified as a:",options:["General-purpose programming language","Database only","Markup language","Spreadsheet language"],correct:0},
    {question:"Which function is the usual entry point of a C program?",options:["start()","main()","begin()","init()"],correct:1},
    {question:"Which header is commonly used for printf() and scanf()?",options:["stdio.h","math.h","string.h","ctype.h"],correct:0},
    {question:"Which statement correctly includes the standard input/output header?",options:["#include <stdio.h>","#include stdio.h","include <stdio.h>","#stdio include"],correct:0},
    {question:"Which symbol ends most C statements?",options:[";",":",".",","],correct:0},
    {question:"Which pair is used to enclose a block of C statements?",options:["{ }","( )","[ ]","< >"],correct:0},
    {question:"Which function is used to display formatted output in basic C programs?",options:["printf()","scanf()","read()","input()"],correct:0},
    {question:"Which function is commonly used for formatted keyboard input in C?",options:["scanf()","printf()","display()","write()"],correct:0},
    {question:"In printf(\"Hello\");, the text Hello is a:",options:["String literal","Variable","Keyword","Operator"],correct:0},
    {question:"Which escape sequence moves the cursor to a new line?",options:["\\n","\\t","\\b","\\0"],correct:0},
    {question:"Which escape sequence represents a horizontal tab?",options:["\\t","\\n","\\r","\\a"],correct:0},
    {question:"Which is a valid single-line comment in modern C?",options:["// comment","<!-- comment -->","## comment","** comment"],correct:0},
    {question:"Which is a valid block comment in C?",options:["/* comment */","// comment //","<!-- comment -->","{# comment #}"],correct:0},
    {question:"Source code is translated into machine-understandable form mainly by a:",options:["Compiler","Keyboard","Printer","Scanner"],correct:0},
    {question:"A syntax error occurs when:",options:["The program violates language grammar rules","The program gives a logically wrong answer only","The computer is switched off","The monitor is disconnected"],correct:0},
    {question:"A logical error is most likely when:",options:["The program runs but produces an incorrect result","The compiler cannot recognize a missing semicolon","The source file is absent","The keyboard fails"],correct:0},
    {question:"Which file typically contains human-readable C statements?",options:["Source file","Object code only","Executable only","Image file"],correct:0},
    {question:"Which step should follow algorithm/flowchart preparation in a basic PDLC sequence?",options:["Coding","Problem definition","Discarding requirements","Hardware manufacturing"],correct:0},
    {question:"A well-designed algorithm should be:",options:["Finite and unambiguous","Infinite and vague","Dependent on one computer brand","Written only in machine code"],correct:0},
    
    // Unit 2 - Questions 35-67
    {question:"Which is a valid C variable name?",options:["total_marks","2marks","total-marks","float"],correct:0},
    {question:"Which is NOT a valid C identifier?",options:["student1","_count","total value","sum"],correct:2},
    {question:"Which keyword declares an integer variable?",options:["int","real","number","integer"],correct:0},
    {question:"Which data type is commonly used for a single character?",options:["char","int","float","double"],correct:0},
    {question:"Which data type is commonly used for fractional values with single precision?",options:["float","char","void","int"],correct:0},
    {question:"Which data type generally provides more floating-point precision than float?",options:["double","char","short","void"],correct:0},
    {question:"Which declaration is valid?",options:["int age;","age int;","integer age;","declare age int;"],correct:0},
    {question:"Which statement initializes x to 10?",options:["int x = 10;","int x == 10;","x := 10 int;","10 = x;"],correct:0},
    {question:"A constant is a value that:",options:["Is intended not to change during program execution","Must always be zero","Can only be a character","Cannot be printed"],correct:0},
    {question:"Which keyword can qualify an object as read-only in C?",options:["const","fixed","constant","final"],correct:0},
    {question:"Which operator performs addition?",options:["+","-","*","/"],correct:0},
    {question:"Which operator gives the remainder after integer division?",options:["%","/","*","+"],correct:0},
    {question:"What is the result of 17 % 5?",options:["2","3","5","12"],correct:0},
    {question:"What is the value of 7 / 2 using integer operands in C?",options:["3","3.5","4","2"],correct:0},
    {question:"Which operator is used for assignment?",options:["=","==","!=",">="],correct:0},
    {question:"Which operator tests equality?",options:["==","=","!","<>"],correct:0},
    {question:"Which operator means 'not equal to' in C?",options:["!=","<>","~=","=!"],correct:0},
    {question:"Which is a relational operator?",options:[">=","&&","++","%"],correct:0},
    {question:"Which operator represents logical AND?",options:["&&","||","!","&="],correct:0},
    {question:"Which operator represents logical OR?",options:["||","&&","!","%"],correct:0},
    {question:"Which operator represents logical NOT?",options:["!","!=","&&","||"],correct:0},
    {question:"If int a=5,b=2; what is a+b*3?",options:["11","21","9","7"],correct:0},
    {question:"Which expression is evaluated first in a+b*c under normal precedence?",options:["b*c","a+b","a+b*c all at once","a*c"],correct:0},
    {question:"Parentheses in an expression are mainly used to:",options:["Control evaluation order","Declare a variable","End a statement","Start a comment"],correct:0},
    {question:"Which operator increments a variable by one?",options:["++","--","+=","**"],correct:0},
    {question:"Which operator decrements a variable by one?",options:["--","++","-=","//"],correct:0},
    {question:"If x=4, what is the value of x after x += 3?",options:["7","1","12","4"],correct:0},
    {question:"Which format specifier is commonly used with printf() for int?",options:["%d","%f","%c","%s"],correct:0},
    {question:"Which format specifier is commonly used for a character?",options:["%c","%d","%f","%u"],correct:0},
    {question:"Which format specifier is commonly used with printf() for a floating-point value?",options:["%f","%d","%c","%x"],correct:0},
    {question:"In scanf(\"%d\", &x), the & before x normally supplies:",options:["The address of x","The value of x twice","A comment","A logical AND operation"],correct:0},
    {question:"What is the value of y after int y = 3 + 4 * 2;?",options:["11","14","10","7"],correct:0},
    {question:"Which conversion is implicit in an expression such as 5 + 2.5?",options:["The integer may be converted to floating-point for evaluation","2.5 becomes a character","Both values become strings","No arithmetic can occur"],correct:0},
    
    // Unit 3 - Questions 68-100
    {question:"Which statement is used for two-way decision making in C?",options:["if-else","for","break","continue"],correct:0},
    {question:"Which keyword introduces an alternative branch after if?",options:["else","case","loop","then"],correct:0},
    {question:"Which statement is suitable for selecting among many constant integral cases?",options:["switch","while","goto only","continue"],correct:0},
    {question:"Each labeled alternative inside a switch normally begins with:",options:["case","if","option","select"],correct:0},
    {question:"Which keyword is commonly used to leave a switch case and prevent fall-through?",options:["break","continue","returning","stop"],correct:0},
    {question:"The default label in a switch executes when:",options:["No case matches","Every case matches","The first case matches","The program has a syntax error"],correct:0},
    {question:"Which loop checks its condition before executing the body?",options:["while","do-while only","Both while and for can be entry-controlled","None"],correct:2},
    {question:"Which loop guarantees that its body executes at least once?",options:["do-while","while","for","Nested if"],correct:0},
    {question:"Which loop is often preferred when the number of iterations is known?",options:["for","switch","if","break"],correct:0},
    {question:"What are the three common expressions in a for loop header?",options:["Initialization, condition, update","Input, output, return","Case, break, default","Header, body, footer"],correct:0},
    {question:"Which statement immediately terminates the nearest loop?",options:["break","continue","if","case"],correct:0},
    {question:"Which statement skips the remaining statements of the current loop iteration?",options:["continue","break","switch","default"],correct:0},
    {question:"What is printed by: if(5>3) printf(\"Yes\"); else printf(\"No\");?",options:["Yes","No","5","3"],correct:0},
    {question:"What is printed by: int x=4; if(x%2==0) printf(\"Even\");?",options:["Even","Odd","4","Nothing"],correct:0},
    {question:"Which condition correctly checks whether x is between 1 and 10 inclusive?",options:["x>=1 && x<=10","x>=1 || x<=10","1<=x<=10","x=1 && x=10"],correct:0},
    {question:"Which condition checks whether x is NOT equal to zero?",options:["x != 0","x =! 0","x <> 0","!x == !0 always"],correct:0},
    {question:"How many times does for(i=0;i<5;i++) execute its body?",options:["5","4","6","0"],correct:0},
    {question:"What are the values of i used in for(i=1;i<=3;i++)?",options:["1, 2, 3","0, 1, 2","1, 2","1, 2, 3, 4"],correct:0},
    {question:"What is the final value of x after int x=0; while(x<3) x++;?",options:["3","2","4","0"],correct:0},
    {question:"What is printed by: for(i=1;i<=3;i++) printf(\"%d \",i);?",options:["1 2 3","0 1 2","1 2 3 4","3 2 1"],correct:0},
    {question:"A loop that never reaches a false termination condition is called:",options:["Infinite loop","Nested loop","Selection","Finite branch"],correct:0},
    {question:"Which for loop can intentionally run indefinitely?",options:["for(;;)","for(i=0;i<0;i++)","for(i=1;i==0;i++)","for(i=0;i<1;i++)"],correct:0},
    {question:"In a nested loop, the inner loop normally completes its iterations:",options:["For each applicable iteration of the outer loop","Only once in the entire program","Before the outer loop starts","Only after program termination"],correct:0},
    {question:"What is printed by: int i=1; do { printf(\"%d\",i); i++; } while(i<1);?",options:["1","Nothing","12","0"],correct:0},
    {question:"If x=10, which branch executes in if(x>5) ... else ...?",options:["The if branch","The else branch","Both always","Neither"],correct:0},
    {question:"Which structure is best for repeatedly accepting values until a sentinel value is entered?",options:["A loop","A single if only","A switch without loop","A comment"],correct:0},
    {question:"Which statement correctly tests whether n is divisible by 5?",options:["if(n%5==0)","if(n/5==0)","if(n%5=0)","if(5%n==1)"],correct:0},
    {question:"To print numbers from 10 down to 1, which update is appropriate?",options:["i--","i++","i+=10","i*=0"],correct:0},
    {question:"What happens when break executes inside a loop?",options:["Control moves to the statement after that loop","The program always ends","The current iteration restarts","The condition becomes true"],correct:0},
    {question:"What happens when continue executes in a for loop?",options:["Control proceeds toward the update/next iteration","The entire program terminates","The loop is permanently exited","All previous output is erased"],correct:0},
    {question:"Which construct can implement an if-else-if ladder?",options:["Multiple conditional branches","Only a do-while loop","Only comments","Only declarations"],correct:0},
    {question:"Which is the correct syntax for a while loop?",options:["while(condition) { statements; }","while condition then statements","loop(condition) statements","while {condition}; statements"],correct:0},
    {question:"Which is the correct closing syntax of a do-while loop?",options:["while(condition);","while(condition)","endwhile;","until(condition)"],correct:0}
];

// Function to select 25 random questions for FS1 CSE exam
function selectFS1CSEExamQuestions() {
    if (fs1cseQuestionBank.length === 0) {
        console.error('FS1 CSE question bank is empty!');
        return [];
    }
    
    let availableQuestions = [...fs1cseQuestionBank];
    let selectedQuestions = [];
    
    // Fisher-Yates shuffle
    for (let i = availableQuestions.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [availableQuestions[i], availableQuestions[j]] = [availableQuestions[j], availableQuestions[i]];
    }
    
    // Select 25 random questions from the 100 available
    selectedQuestions = availableQuestions.slice(0, 25);
    
    return selectedQuestions;
}
