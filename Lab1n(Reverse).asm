# who:  Rachael Shima
# what:  Lab1n(Reverse)
		 # Lab1n(Reverse).asm
# why: Lab1 for cs264
		 # Code to take 20 integers and store them in an array
		 # print the array in reverse
		 # print the array with n numbers per line
# When:  11 May 2017
		 #18 May 2017
		 
	.data
	
			Array:   .space 80
			prompt1: .asciiz "Please enter 20 integers: "
			space:	 .asciiz " "
			nprompt: .asciiz "How many integers per line?: "
			line:	 .asciiz "\n"
			prompt2: .asciiz "Please enter another integer: "
	 .text
		.globl main	
main: 
			li $t0, 0				#read counter
			la $t1, Array			#load address of Array
			
			la $a0, prompt1			#display message
			li $v0, 4				#print string
			syscall
readloop:
			li $v0, 5				#read user int
			syscall
		
			sw $v0, 0($t1)			#store integer in array at index
			
			addi $t0, $t0, 1		#incriment loop
			addi $t1, $t1, 4		#incriment array
			beq $t0, 20, printloop	#branch if array is full
				
			la $a0, prompt2			#new prompt
			li $v0, 4				#print string
			syscall
			b readloop				#loop
			
printloop:
			addi $t1, $t1, -4		#incriment array pointer
			lw $a0, 0($t1)			#load int at index
			li $v0, 1				#print int
			syscall
			
			la $a0, space			#load space string
			li $v0, 4				#print string
			syscall 
			
			addi $t0, $t0, -1		#decriment counter
			beq $t0, 0, n			#branch if array is empty
			b printloop				#loop
			
n:
			la $a0, line			#start new line
			li $v0, 4				#print string
			syscall
			
			la $a0, nprompt			#display message
			li $v0, 4				#print string
			syscall
			
			li $v0, 5				#read user int
			syscall
			
			add $t3, $zero, $v0		#store user int
			add $t4, $zero, $t3		#store an extra instance of $t3 for reference
			li $t0, 20				#reset $t0

nloop:
			lw $a0, 0($t1)			#load data of array at index
			li $v0, 1				#print int
			syscall
			
			la $a0, space			#add space
			li $v0, 4				#print string
			syscall
			
			addi $t1, $t1, 4		#incriment pointer
			addi $t0, $t0, -1		#decriment array counter
			addi $t3, $t3, -1		#decriment line counter
			beq $t0, 0, finish		#branch if array is empty
			beq $t3, 0, nline		#branch for new line
			b nloop					#loop
			
nline:
			la $a0, line			#start new line
			li $v0, 4				#print string
			syscall
			
			add $t3, $zero, $t4		#reset $t3
			
			b nloop					#loop

finish:	
			li	$v0, 10				#terminate program
			syscall