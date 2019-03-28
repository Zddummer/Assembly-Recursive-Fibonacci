
# Zach Dummer assignment 02
.data
prompt: .asciiz "Which Fibonacci number do you want? "
output: .asciiz "The Fibonacci number is "
error: .asciiz "You must enter an integer greater than or equal to 0. Try again. "
.text
main:
 la $a0, prompt
 li $v0, 4
 syscall
 j readNonNegInt
 

#readInt
readInt:
 li $v0, 5
 syscall
 jr $ra
 
#readNonNegInt
readNonNegInt:
 jal readInt
 bltz $v0, printError
 move $a0, $v0
 
 jal fib
 j printAnswer
 
#print error
printError:
 la $a0, error 
 li $v0, 4
 syscall
 move $a1, $ra
 j readInt
 
 #print answer
printAnswer:
move $t0, $v0
 la $a0, output
 li $v0, 4
 syscall
 move $a0, $t0
 li $v0, 1
 syscall
 j end
 
 #sub-routine for Fibonacci sequence
fib:
 bgt $a0, 1, rec
 move $v0, $a0
 jr $ra
 
rec:
 sub $sp, $sp, 12
 sw $ra, 0($sp)
 sw $a0, 4($sp)
 
 add $a0, $a0, -1
 jal fib
 lw $a0, 4($sp)
 sw $v0, 8($sp)
 
 add $a0,$a0, -2
 jal fib
 lw $t0, 8($sp)
 add $v0, $v0, $t0
 
 lw $ra, 0($sp)
 add $sp, $sp, 12
 jr $ra
 #exit program
end:
 li $v0, 10
 syscall

