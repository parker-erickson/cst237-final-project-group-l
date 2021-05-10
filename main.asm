## main function in base converter##


.data
	msg1: .asciiz "Input the base of the number: "
	msg2: .asciiz "Input the base to convert to: "
	msg3: .asciiz "Input the number to be converted: "

.text
main:
	#   printf("Input the base of the number: ");
	li $v0, 4
	la $a0, msg1
	syscall
	
	#   scanf("%d", &baseFrom);
	li $v0, 5
	syscall
	move $s0, $v0 #storing the value into $s0
	
	#   printf("Input the base to convert to: ");
	li $v0, 4
	la $a0, msg2
	syscall
	
	 #  scanf("%d", &baseTo);
	li $v0, 5
	syscall
	move $s1, $v0
	
	#  printf("Input the number to be converted: ");
	li $v0, 4
	la $a0, msg3
	syscall
	
	#  scanf("%s", str);
	li $v0, 5
	syscall
	move $s2, $v0
	
	#  if, else-if branching
	bne $s0, 10, label1
	jal DectoBase
	label1: beq $s0, 10, label2
		bne $s1, 10, label2
		jal basetoDec
	label2: bne $s0, 10
		bne $s1, 10
		jal anyBasetoanyBAse
	li $v0, 1
	syscall
	j exit

exit:
	li $v0, 10
	syscall 


	power: 
		li $t0, 1 
		beq $a2, $zero, exit
		while: 
			beqz $a2, exit
			mul $t0, $t0, $a1
			subi $a2, $a2, 1
			j while
			
		exit:
			move $v1, $t0
			jr $ra



