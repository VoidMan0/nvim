#include<stdio.h> 
#include<stdlib.h>
#include<math.h>

#define PHI3 4.236068


int fib_even(int n){

    int x1 = 1;
    int x2 = 2;
    int temp = 0,sum = 0;
    for(int i = 0; i < n && temp < 4000000; ++i){
        if(x2 % 2 == 0) sum += x2;
        temp = x2; x2 += x1; x1 = temp;
    }

    return sum;
}
 
//usage: call the compiled file with the numbers you want in the fibonacci series
//and will return the sum of the even numbers
int main (int argc, char *argv[])
{

    float num = atoi(argv[1]);
    printf("%i\n", fib_even(num));
    

    return 0;
}
