.data
my_array:
	.space 20
comma: 
	.asciiz "," 
.text
li $v0,8
la $a0, my_array
li $a1, 20
syscall

la $t1, my_array 
li $t3,0
read_loop:
lb $t2, ($t1)
addi $t1, $t1,1 #cursor
beq $t2,$zero, determine #end of text
addi $t3, $t3,1 #counter
j read_loop

determine:
add $t3,$t3,-1
la  $t1, my_array  #get cursor at the beginning
div $t6,$t3,2  #get half elements in an array

array:
li $t9,0 # counter for how many errors
add $t0, $t3, -1
add $t7, $t1,$t0
array_compare:
lb $t2, ($t1)
lb $t8, ($t7)
addi $t1, $t1, 1
addi $t7, $t7, -1
bne $t2, $t8, write_array
addi $t6, $t6, -1
beq $t6,$zero,print
j array_compare
write_array:
sb $t8,-1($t1)
addi $t9,$t9,1 #counting how many changes made
j array_compare



print: 
li $v0, 1
add $a0, $t9,$zero
syscall

li $v0, 4
la $a0, comma
syscall

li $v0,4
la $a0,my_array
syscall









 
