# arrayFunction.asm
       .data 
array: .word 8, 2, 1, 6, 9, 7, 3, 5, 0, 4
newl:  .asciiz "\n"

       .text
main:
	# Print the original content of array
	# setup the parameter(s)
	la	 $a0, array				# Load base address of 'array'
	li 	 $a1, 10					# Store number of elements of 'array'
	
	# call the printArray function
	jal	 printArray				# Jump to printArray function

	# Ask the user for two indices
	li   $v0, 5         	# System call code for read_int
	syscall           
	addi $t0, $v0, 0    	# first user input in $t0
 
	li   $v0, 5         	# System call code for read_int
	syscall           
	addi $t1, $v0, 0    	# second user input in $t1

	# Call the findMin function
	# setup the parameter(s)
	la	 $t2, array			# load base address of 'array'
	sll	 $a0, $t0, 2		# multiply by 4 of lower bound
	add	 $a0, $a0, $t2	# store address pointer of lower bound	
	sll	 $a1, $t1, 2		# multiply by 4 of upper bound
	add	 $a1, $a1, $t2	# store address pointer of upper bound

	# call the function
	jal	 findMin

	# Print the min item
	# place the min item in $t3	for printing
	lw $t3, 0($v0)			# store minimum element address

	# Print an integer followed by a newline
	li   $v0, 1   		# system call code for print_int
    addi $a0, $t3, 0    # print $t3
    syscall       		# make system call

	li   $v0, 4   		# system call code for print_string
    la   $a0, newl    	# 
    syscall       		# print newline

	#Calculate and print the index of min item
	
	# Place the min index in $t3 for printing
	la	$a0, array		 # Load base address of 'array'
	sub $t3, $s1, $a0	 # subtract minimum address by base address
	srl $t3, $t3, 2		 # divide by 4 to get index

	# Print the min index
	# Print an integer followed by a newline
	li   $v0, 1   		# system call code for print_int
    addi $a0, $t3, 0    # print $t3
    syscall       		# make system call
	
	li   $v0, 4   		# system call code for print_string
    la   $a0, newl    	# 
    syscall       		# print newline
	
	# End of main, make a syscall to "exit"
	li   $v0, 10   		# system call code for exit
	syscall	       	# terminate program
	

#######################################################################
###   Function printArray   ### 
#Input: Array Address in $a0, Number of elements in $a1
#Output: None
#Purpose: Print array elements
#Registers used: $t0, $t1, $t2, $t3
#Assumption: Array element is word size (4-byte)
printArray:
	addi $t1, $a0, 0	#$t1 is the pointer to the item
	sll  $t2, $a1, 2	#$t2 is the offset beyond the last item
	add  $t2, $a0, $t2 	#$t2 is pointing beyond the last item
l1:	
	beq  $t1, $t2, e1
	lw   $t3, 0($t1)	#$t3 is the current item
	li   $v0, 1   		# system call code for print_int
     	addi $a0, $t3, 0    	# integer to print
     	syscall       		# print it
	addi $t1, $t1, 4
	j l1				# Another iteration
e1:
	li   $v0, 4   		# system call code for print_string
     	la   $a0, newl    	# 
     	syscall       		# print newline
	jr $ra			# return from this function


#######################################################################
###   Student Function findMin   ### 
#Input: Lower Array Pointer in $a0, Higher Array Pointer in $a1
#Output: $v0 contains the address of min item 
#Purpose: Find and return the minimum item 
#              between $a0 and $a1 (inclusive)
#Registers used: $t0, $t1, $t2, $t3, $t4, $s0, $s1
#Assumption: Array element is word size (4-byte), $a0 <= $a1
findMin:
	addi	$v0, $a0, 0			# store address of minimum item
	addi	$s1, $a0, 0			# store address of minimum item
	beq		$a0, $a1, end		# if a0 < a1
	lw		$s0, 0($a0)			# load item in initial lower bound

loop:
	addi	$a0, $a0, 4			# move to next item in array
	slt 	$t2, $a0, $a1		# compare lower bound and upper bound
	beq		$t2, $0, end		# hit last upper bound
	#slt		$t2, $a0, $t1		# check for out of bounds
	#beq		$t2, $0, end		# if out of bounds

	lw		$t3, 0($a0)			# load current item
	slt		$t2, $t3, $s0		# check if current less than minimum
	beq		$t2, $0, loop		# return to loop if current more than minimum
	addi	$s0, $t3, 0			# set new minimum
	addi	$v0, $a0, 0			# store address of minimum item
	addi	$s1, $a0, 0			# store address of minimum item
	j loop

end:
	jr 		$ra							# return from this function
