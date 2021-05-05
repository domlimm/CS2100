# task1.asm
  .data 
str: .asciiz "the answer = "
ans: .asciiz ""
  .text

main:
    li   $v0, 4      # systel call code for print_string
    la   $a0, ans    # address of input line
    syscall

    li   $v0, 5      # system call code for read_int
    syscall          # print the integer
    la   $t1, 0($v0) # store input into temp register
    
    li   $v0, 4      # system call code for print_string
    la   $a0, str    # address of string to print
    syscall          # print the string

    li   $v0, 1      # system call code for print_int
    la   $a0, 0($t1) # address of answer to print
    syscall          # print the int

    li   $v0, 10     # system call code for exit
    syscall          # terminate program