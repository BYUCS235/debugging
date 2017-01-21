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
    // int average = sum / count;
    
    char *nowhere = 0;
    // *nowhere = 5;
    
    char small[2];
    bad(small);
}

