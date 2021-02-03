.data
input_message:
	.asciiz "if you want to add another integer please enter 1 else enter 0, note you can't enter more than 25 integer"
my_array:
	.align 2
	.space 100
newline:
	.asciiz "\n"
minmsg:
	.asciiz "minimum is "
maxmsg:
	.asciiz "maximum is "
.text
la $t8, my_array
li $t3, 0
enter_array:
li $v0, 5 #enter an integer
syscall
sw $v0, ($t8) # store the integer in memory
addi $t8,$t8,4 # after storing store in next address
addi $t3,$t3,1 #counter to how many elements in array
wrong_input:
li $v0, 4 # print a message asking if there is more
la $a0, input_message 
syscall
li $v0,5
syscall
beq $v0,1,enter_array
beq $v0,$zero, find
bne $v0, $zero , wrong_input


find:
addi $t3,$t3,-1
la $t0, my_array
# we will make t3 be the counter but since we are going to make the first comparison outside loop it equals n-1 where n is no of elements in array
# make the first loop outside to determine max and min then use cursor to compare to these two values
lw $t1,($t0)
addi $t0,$t0,4
lw $t2,($t0)
ble $t1,$t2,max
bgt $t1,$t2,min
max:
add $t5, $t2,$zero
j loop
min:
add $t5,$t1,$zero
add $t1,$t2,$zero

# we will make t1 hold the minimum value while making t5 hold the maximum value, t2 will be a cursor

loop:
addi $t0,$t0,4
lw $t2,($t0)
addi $t3,$t3,-1
beq $t3,$zero,print
ble $t2,$t1,setmin
bgt $t2,$t5,setmax
j loop
setmin:
add $t1,$t2,$zero
j loop
setmax:
add $t5,$t2,$zero
j loop

print:
li $v0, 4
la $a0, minmsg
syscall
li $v0, 1
add $a0,$t1,$zero
syscall
li $v0, 4
la $a0,newline
syscall
li $v0, 4
la $a0, maxmsg
syscall
li $v0,1
add $a0,$t5,$zero
syscall
