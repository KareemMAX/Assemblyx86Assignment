.section .data

input: .asciz "%d"
input_double: .asciz "%lf"
output_sum: .asciz "sum=%f"
output_avg: .asciz " avg=%f\n"
n: .int 0
sum: .double 0.0
n_double: .double 0.0

.section .text

.globl _main

_main:
    pushl $n
    pushl $input
    call _scanf
    add $8, %esp

    movl $0, %ecx
    fldl sum

input_loop:

    pushl %ecx

    pushl $sum
    pushl $input_double
    call _scanf
    add $8, %esp

    popl %ecx

    faddl sum

    add $1, %ecx

    cmpl %ecx, n
    ja input_loop

    fstpl sum

    pushl sum+4
    pushl sum
    pushl $output_sum
    call _printf
    add $12, %esp

    fildl n
    fstpl n_double

    fldl sum
    fdivl n_double
    fstpl sum

    pushl sum+4
    pushl sum
    pushl $output_avg
    call _printf
    add $12, %esp

    ret
