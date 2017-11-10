# who:  Rachael Shima
# what:  Lab1n(Column)
		 # Lab1n(Column).asm
# why: Lab1 for cs264
		 # Code to take 20 integers and store them in an array
		 # print the array with one int per line
# When:  11 May 2017
		 #18 May 2017
		 
	.data
			Array:   .space 80
			prompt1: .asciiz "Please enter 20 integers: "
			line:	 .asciiz "\n"
			prompt2: .asciiz "Please enter another integer: "
	 .text
		.globl main	
main: 
			li $t0, 0				#read counter
			la $t1, Array			#load address of Array
			
			move $t2, $t1			#array pointer
			la $a0, prompt1			#display message
			li $v0, 4				#print string
			syscall
readloop:
			li $v0, 5				#read user int
			syscall
		
			sw $v0, 0($t2)			#store integer in array at index
			
			addi $t0, $t0, 1		#incriment loop
			addi $t2, $t2, 4		#incriment array
			beq $t0, 20, printloop	#branch if array is full
				
			la $a0, prompt2			#new prompt
			li $v0, 4				#print string
			syscall
			b readloop
			
printloop:
			lw $a0, 0($t1)			#load int at index
			li $v0, 1				#print int
			syscall
			
			la $a0, line			#load line string
			li $v0, 4				#print string
			syscall 
			
			addi $t1, $t1, 4		#incriment array pointer
			addi $t0, $t0, -1		#decriment counter
			beq $t0, 0, finish		#branch if array is empty
			b printloop				#loop
			
finish:	
			li	$v0, 10				#terminate program
			syscall