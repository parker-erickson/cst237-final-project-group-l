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
	beq $s0, 8, And
	beq $s0, 2, And1
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
	
	And1:
	beq $s1, 10, Label3
	
	Label2:
	
        addi $a0, $s2, 0
        
        jal octaltodec
        
        li $v0, 1
	addi $a0, $v1, 0
	syscall
	
	j Exit
	
	Label3:
	
	addi $a0, $s2, 0
        
        jal Binarytodec
        
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
			beqz $a1, exit #while (y != 0)
			mul $t0, $t0, $a0 #result*=x;
			subi $a1, $a1, 1
			j while
			
		exit:
			move $v1, $t0
			jr $ra
			
	octaltodec: 
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		addi $t1, $zero, 0
		addi $t2, $zero, 0
		move $t3, $a0
		addi $t4, $zero, 8
		addi $t6, $zero, 10
		addi $t9, $zero, 1
		
		While2: 
			blt $t3, $t9, End1
			rem $t5, $t3, $t6
			add $a0, $t4, $zero
			add $a1, $t2, $zero
			jal power
			mul $t7, $v1, $t5
			add $t1, $t1, $t7
			addi $t2, $t2, 1
			div $t3, $t3, $t6
			j While2
		End1:
		
			move $v1, $t1
			lw $ra, 0($sp)
			addi $sp, $sp, 4
	        	jr $ra  
		
	Binarytodec:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		addi $t1, $zero, 0
		addi $t2, $zero, 0
		move $t4, $a0
		addi $t5, $zero, 10
		addi $t6, $zero, 2
		addi $t7, $zero, 1
		
		While3: 
			blt $t4, $t7, End3
			rem $t3, $t4, $t5
			div $t4, $t4, $t5
			add $a0, $t6, $zero
			add $a1, $t2, $zero
			jal power
			mul $t8, $v1, $t3
			add $t1, $t1, $t8
			addi $t2, $t2, 1
			j While3
		End3: 
			move $v1, $t1
			lw $ra, 0($sp)
			addi $sp, $sp, 4
	        	jr $ra  
		

			
		


		
	