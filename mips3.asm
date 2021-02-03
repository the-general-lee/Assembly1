.data
    hello: .asciiz "Hello There!"
    input: .space 1
.text
la $t6 , input
li $v0, 8
la $a0, ($t6) 
li $a1,1
li $t2,0
syscall
la $t0,hello
loop:

lb $t1,($t0)
add $t0,$t0,1
beq  $t1,$t6,increment
beq  $t1,$zero,print
increment:
add $t2,$t2,+1
j loop

print:
li $v0, 1

add $a0,$t2,$zero
syscall
