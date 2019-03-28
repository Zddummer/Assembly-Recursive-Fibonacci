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
 jal readNonNegInt
 j fib

#readInt
readInt:
 li $v0, 5
 syscall
 jr $ra
 
#readNonNegInt
readNonNegInt:
 jal readInt
 bltz $v0, printError
 move $t1, $v0
 move $a0, $ra
 jr $ra
 
#print error
printError:
 la $a0, error 
 li $v0, 4
 syscall
 move $a1, $ra
 j readInt
 
 #print answer
printAnswer:
 la $a0, output
 li $v0, 4
 syscall
 move $a0, $a1
 li $v0, 1
 syscall
 j end
 
 #sub-routine for Fibonacci sequence
fib:
 
 
 #exit program
end:
 li $v0, 10
 syscall
