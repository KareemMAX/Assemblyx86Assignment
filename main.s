.section .data                      # initialized memory variables, will be part of the exe

input: .asciz "%d"                  # string terminated by 0 that will be used for scanf parameter
input_double: .asciz "%lf"          # string terminated by 0 that will be used for scanf parameter
output_sum: .asciz "sum=%f"         # string terminated by 0 that will be used for printf parameter
output_avg: .asciz " avg=%f\n"      # string terminated by 0 that will be used for printf parameter
n: .int 0                           # the variable n which we will get from user using the first scanf
sum: .double 0.0
n_double: .double 0.0

.section .text              # instructions

.globl _main                # make _main accessible from external

_main:                      # the label indicating the start of the program

    # get how many inputs
    pushl $n                # push to stack the second parameter to scanf (the address of the integer variable n) the char "l" in pushl means 32-bits address
    pushl $input            # push to stack the first parameter to scanf
    call _scanf             # call scanf, it will use the two parameters on the top of the stack in the reverse order
    add $8, %esp            # pop the above two parameters from the stack (the esp register keeps track of the stack top, 8=2*4 bytes popped as param was 4 bytes)

    # get the n floats from the user
    movl $0, %ecx           # ecx iterates over the integer array (0,1,...,n-1)
    fldl sum                # push 0 to the floating point stack

input_loop:

    pushl %ecx              # push to stack ecx because _scanf may change it

    pushl $sum              # push to stack the second parameter to scanf
    pushl $input_double     # push to stack the first parameter to scanf
    call _scanf             # call scanf, it will use the two parameters on the top of the stack in the reverse order
    add $8, %esp            # pop the above two parameters from the stack

    popl %ecx               # pop ecx

    faddl sum               # pop the floating point stack top, add it to sum, and push the result

    add $1, %ecx            # increase ecx by 1

    cmpl %ecx, n            # compare %ecx and n and update some status flags that will be used by ja below
    ja input_loop           # ja = jump if above: goto input_loop only if n is above %ecx

    fstpl sum               # pop the floating point stack top into the memory variable sum

    pushl sum+4             # push to stack the high 32-bits of the second parameter to printf (the double at label sum)
    pushl sum               # push to stack the low 32-bits of the second parameter to printf (the double at label sum)
    pushl $output_sum       # push to stack the first parameter to printf
    call _printf            # call printf
    add $12, %esp           # pop the two parameters

    fildl n                 # convert n to double and push it to stack
    fstpl n_double          # pop the floating point stack top into the memory variable n_double

    fldl sum                # push sum to the floating point stack
    fdivl n_double          # pop the floating point stack top (sum), divide it over r and push the result (sum/n)
    fstpl sum               # pop the floating point stack top into the memory variable sum

    pushl sum+4             # push to stack the high 32-bits of the second parameter to printf (the double at label sum)
    pushl sum               # push to stack the low 32-bits of the second parameter to printf (the double at label sum)
    pushl $output_avg       # push to stack the first parameter to printf
    call _printf            # call printf
    add $12, %esp           # pop the two parameters

    ret                     # end the main function
