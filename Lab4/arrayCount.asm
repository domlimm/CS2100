# arrayCount.asm
  .data 
arrayA:   .word   11, 0, 31, 22, 9, 7, 6, 9 # arrayA has now 8 values
count:    .word   999                       # dummy value
x:        .asciiz ""                        # prompt for x
  .text
  
main:
    # code to setup the variable mappings
    la    $t0, arrayA                       # load base address of arrayA
    la    $t7, count
    lw    $t8, 0($t7)                       # load value of count into $t8
    addi  $s1, $t0, 0                       # start index of arrayA
    addi  $s2, $t0, 32                      # end index of arrayA
    addi  $s3, $0, 0                        # count multiples of X

    # code for reading in the user value X
    li    $v0, 4                            # system call code for print_string
    la    $a0, x                            # address of input line
    syscall

    li    $v0, 5                            # system call code for read_int
    syscall
    la    $t5, 0($v0)                       # store x into $t5
    addi  $t5, $t5, -1                      # store mask into $t5

loop:
    # code for counting multiples of X in arrayA
    slt   $t2, $s1, $s2                     # if last element of arrayA (store)
    beq   $t2, $0, result                   # if last element, goto br result
    lw    $t3, 0($s1)                       # load element into $t3
    and   $t4, $t3, $t5                     # check if multiple of X
    slti  $t6, $t4, 1                       # if result (mod) lesser than 1, 0
    beq   $t6, $0, skip                     # if result (mod) != 0, loop back
    addi  $s3, $s3, 1                       # ++count multiples of X

skip:
    # code for moving to next element
    addi  $s1, $s1, 4                       # move to next element of arrayA
    j     loop

result:
    # code for printing result
    li    $v0, 1                            # system call code for print_int
    la    $a0, 0($s3)                       # load the address of result to print
    syscall

    sw    $s3, 0($t7)                       # store count back to memory

    # code for terminating program
    li    $v0, 10
    syscall
