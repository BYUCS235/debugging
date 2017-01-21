# debugging
Although using cout to check the status of your program will work a lot of the time, there will be times when you will need more help.  When this occurs, you will need to use a debugger.  Although there are different debuggers for each development environment, they all have about the same features.  The debugger that it available for the c9.io environment is "gdb".  Lets experiment with using gdb to find common errors.

1. First create a file that we can debug, call it "debug.cpp"
  ```c++
#include <iostream>
using namespace std;

void bad(char *smallarray)
{
    for(int i = 0; i < 1000; i++) {
        smallarray[i] = 0;
    }
}
main()
{
    int sum = 5;
    int count = 0;
    int average = sum / count;
    
    char *nowhere = 0;
    *nowhere = 5;
    
    char small[2];
    bad(small);
}
  ```
2. Next you will need to compile your program with the "-g" flag.  Lets create an entry in your Makefile for the pinewood example for debug.cpp.

  ```
CFLAGS=-std=c++11 -g
debug: debug.cpp
		g++ $(CFLAGS) debug.cpp -o debug
  ```
3. Type "make debug" and the compiler should create an executable called "debug".  When you run this executable with "./debug", you should see "Floating point exception".  Your program has tried to divide by zero, since "count=0".  Lets use the debugger to find the location of this error.

  ```
mjcleme:~/workspace/V2 $ gdb debug
GNU gdb (Ubuntu 7.7.1-0ubuntu5~14.04.2) 7.7.1
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
---Type <return> to continue, or q <return> to quit---
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from debug...done.
(gdb) 
  ```
4. You will have to enter a "return" to get to the gdb prompt.  You can now enter commands.  Try "help" to see what the possible commands are.  Now try "run" and you will see the following output
  ```
Starting program: /home/ubuntu/workspace/V2/debug 

Program received signal SIGFPE, Arithmetic exception.
0x0000000000400717 in main () at debug.cpp:14
14          int average = sum / count;
(gdb) 
  ```
5. You can see that the bug is on line 14.  This gdb command will help you find most of your problems.  Lets remove this error by commenting out the errant line of code so we can find the next bug.  You will have to enter "quit" to exit gdb.

  ```
// int average = sum / count;
  ```
6. Compile ("make debug") and run your program ("./debug") and you will see the dreaded "Segmentation fault" error.  This occurs because we tried to write a 5 to our nowhere pointer which pointed to zero.  Run gdb again to find where the bug is
  ```
(gdb) run
Starting program: /home/ubuntu/workspace/V2/debug 

Program received signal SIGSEGV, Segmentation fault.
0x000000000040071f in main () at debug.cpp:17
17          *nowhere = 5;
(gdb) 
  ```
7. Remove this bug by commenting out the errant line and lets see if we can find the next one.

  ```
// *nowhere = 5;
  ```
8. Compile and run the program and you should get another dreaded "Segmentation fault".  This occurs because your "bad()" function has tried to write beyond the end of the array.  When you run it in the debugger, you will get no help.  The output will be:
  ```
(gdb) run
Starting program: /home/ubuntu/workspace/V2/debug 

Program received signal SIGSEGV, Segmentation fault.
0x0000000000000000 in ?? ()
  ```
Your "bad()" function has written zeros to the stack and when you return from this function, you return to the address zero.  The only remedy is to be very careful to not access locations past the end of an array.  Debugging this kind of an error will require a lot of looking at your source code to find the problem.
