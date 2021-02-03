.data
	input: .space 4
	emsg: .asciiz  "the number entered is even"
	opmsg: .asciiz "the number entered is odd and prime"
	onpmsg: .asciiz "the number entered is odd but not prime"
.text
#taking user input and putting it into dynamic memory then using t1 as the register to use this input number
li $v0,5
syscall
sw $v0,input
lw $t1, input
# anding any number with 1 will result in 1 if it is odd and 0 if it is even as discussed with Dr.Karim 
and $t2,$t1,1


beq $t2,1,odd
beqz $t2,even
#printing the number is even
even:
li $v0,4
la $a0,emsg
syscall
j end

odd:
# dividing the number by have because if it has a factor it has to be less than its half 
div $t5,$t1,2
li $t4,2
# running a cursor through out the numbers from 2 to half the entered number to see if the entered number is divisible by any of them and hence it has a factor and is not prime
loop:
div $t6,$t1,$t4
mfhi $t7
addi $t4,$t4,1
addi $t5,$t5,-1
# t7 is the reminder if it is ever equal zero then the current t4 is a factor and t1 is not prime
beqz $t7, oddandnotprime
# if the counter ends before that then there is no factor and hence the number is prime
beqz $t5, oddandprime 
j loop

oddandprime:
li $v0,4
la $a0,opmsg
syscall 
j end

oddandnotprime:
li $v0,4
la $a0,onpmsg
syscall 

end:
li $v0,10
syscall
