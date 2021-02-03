.data
dir: 
     .word 2,3,4
     
.text
li $t3, 3
la $t0, dir
loop:

lw $t1, ($t0)
add $t2,$t2,$t1
add $t0,$t0,4
add $t3,$t3,-1

beq  $t3,$zero,print 
j loop
print:
li $v0, 1

add $a0,$t2,$zero
syscall
li $t4,3
div $a0,$t2,$t4
syscall


   