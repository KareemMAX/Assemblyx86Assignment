# Sum and average calculator

This is a sum and average calculator written in x86 AT&T assembly. It first takes how many numbers to calculate average and sum to, then it takes inputs separated by space.  
This program was made an assignment for the Computer Organization and Architecture course taught by Cairo University - Faculty of Computers and Artificial Intelligence.

```console
~$ .\sum_and_average.exe
3 9 8 7
sum=24.000000 avg=8.000000
```

## How to compile

You need a version of [gcc](https://www.mingw-w64.org/downloads/) installed. Then you can compile the `main.s` file with this command:

```shell
gcc -O3 -o sum_and_average.exe main.s
```
