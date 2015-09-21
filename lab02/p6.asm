#**********************************************************************
#   CSSE 232: Computer Architecture
#
#   File:    p6.asm
#   Written: 3/9/97, Rimli Sengupta
#   Modified by:  J.P. Mellor, 6 Sep. 2004
#
# This file contains a MIPS assembly language program that uses only the
# instructions introduced in p1.asm, p2.asm, p3.asm, p4.asm and p5.asm.
#
# It also takes advantage of several spim syscalls and the assembly
# directive .asciiz
#
#**********************************************************************

	.globl	main
	.globl	V


	.data

V:	.word   20, 56, -90, 37, -2, 30, 10, -66, -4, 18
N:	.word	10
message:	.asciiz "Rotated array: "
sep:	.asciiz " "
newline:	.asciiz "\n"

#**********************************************************************

	.text

main:	

	
#----------------------------------------------------------------------
# 	Rotate the array
#----------------------------------------------------------------------

#
# Insert your code here
#
	li      $t1, 9          #length
	la      $t2, V          #v
	li      $t3, 0          #index1
 	li      $t4, 0          #index2
	lw      $s0, 0($t2)     #V1
loop1:  beq     $t3, $t1, ok 
	addi    $t4, $t3, 1
        sll     $s1, $t4, 2	
        add     $s2, $t2, $s1   #address of v[i+1]
        sll     $s1, $t3, 2
        add     $s3, $t2, $s1   #address of v[i]     
	lw      $s4, ($s2)      #value of v[i+1]
        lw      $s5, ($s3)      #value of v[i]
        sw      $s5, ($s2)
        sw      $s4, ($s3)
        addi    $t3, $t3, 1
	j       loop1     

#----------------------------------------------------------------------
# 	Print the rotated array
#----------------------------------------------------------------------

ok:	la	$t1, N		# load the address of N
	lw	$t1, 0($t1)	# load the value of N
	sll	$t1, $t1, 2     # multiply by 4
	la	$a0, message	# store pointer to message
	li	$v0, 4		# use system call to
	syscall			# print message
	li	$t0, 0		# initialize the index
loop2:	lw	$a0, V($t0)	# store next element
	li	$v0, 1		# use system call to
	syscall			# print the min
	la	$a0, sep	# store pointer to sep
	li	$v0, 4		# use system call to
	syscall			# print sep
	add	$t0, $t0, 4	# increment the index
	bne	$t0, $t1, loop2	# check if we've printed all the elements
	la	$a0, newline	# store pointer to a new line
	li 	$v0, 4		# use system call to
	syscall			# print new line

# --------------------------------------------------------------------
#   Exit 
# ---------------------------------------------------------------------

	li	$v0, 10		# use system call to
	syscall			# exit

