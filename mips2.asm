.text
li $t0, 1
li $t1, 3
loop:

mul $t0,$t0,4
add $t1,$t1,-1

beq  $t1,$zero,print 
j loop
print:
li $v0, 1
add $a0,$t0,$zero
syscall