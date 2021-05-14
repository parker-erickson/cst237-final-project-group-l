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
	beq $s0, 10, Label
	bne $s0, 10, And
	Label:
	
	addi $a0, $s1, 0
        addi $a1, $s2, 0
        
        jal DectoBase
        
        li $v0, 1
	addi $a0, $v1, 0
	syscall
	
	j Exit
	
	And: 
	beq $s1, 10, Label2
	bne $s1, 10, Label3
	
	Label2:
	
	addi $a0, $s0, 0
        addi $a1, $s2, 0
        
        jal Basetodec
        
         li $v0, 1
	addi $a0, $v1, 0
	syscall
	
	j Exit
	
	Label3:
	
	addi $a0, $s0, 0
        addi $a1, $s2, 0
        addi $a2, $s1, 0
        
        jal anybasetoanybase
        
        li $v0, 1
	addi $a0, $v1, 0
	syscall
	

Exit:
	li $v0, 10
	syscall 
	
	
	DectoBase: 
		addi $t9, $zero, 10
		addi $t1, $zero, 0 #Counter 
		move $t2, $a1 #Number in decimal 
		move $t5, $a0 # base to convert to 
		addi $t3, $zero, 0  # Int num=0
		addi $t7, $zero, 1
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		
			while1: 
				blt $t2, $t7, End  #while(quo != 0)
				div $t2, $t5 
				mfhi $t4   #rem = quo%base;
				div $t2, $t2, $t5  #quo = quo / base;
				add $a0, $t9, $zero
				add $a1, $t1, $zero
				jal power    #power(10,counter)
				mul $t6, $v1, $t4 #power(10,counter)*rem
				add $t3, $t3, $t6 #power(10,counter)*rem + num
				addi $t1, $t1, 1 #counter++
				j while1
				
		
		
		End: 
			move $v1, $t3
			lw $ra, 0($sp)
			addi $sp, $sp, 4
	        	jr $ra  
	
	power: 
		li $t0, 1 
		beq $a1, $zero, exit
		while: 
			beqz $a1, exit
			mul $t0, $t0, $a0
			subi $a1, $a1, 1
			j while
			
		exit:
			move $v1, $t0
			jr $ra
			
	Basetodec: 
		add $v1, $a1, $a0
		jr $ra
		
		
	anybasetoanybase:
		add $v1, $a1, $a0
		add $v1, $v1, $a2
		jr $ra 

		


		
	
