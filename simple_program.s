	.text
	.equ	LEDs,		0xFF200000
	.equ	SWITCHES,	0xFF200040
	.equ 	HEX0,		0xFF200020
	.equ	HEX1,		0xFF200028
	.equ	x,			0
	.global _start
_start:
	movia	r2, LEDs		# Address of LEDs         
	movia	r3, SWITCHES	# Address of switches
	movia 	r5, HEX0		# move r5 to be the hex values
	movia 	r8,	HEX1
	movia 	r6, 	0b00000000	#all off
	movia 	r7, 	0b11111111	#LIT
	movia 	r9, 	0b01110110	#H
	movia 	r10, 	0b00111101 #E
	stwio	r0, 0(r5)		# Display value off to HEX0

	movia 	r11, 5			#execute 4 times, for the 4 display	
	movia 	r13, 9000000		#delay of 9 million cycles?

LOOP:

#	add 	r6, r6, r9		#add r9 (H) to the r6 register.

	mov		r6, r9			#copy r9 into r6
	#erase previous display to get scroll. done automatically by the shift left logical imiidiate (SLLI), fills with 0
	stwio	r6, 0(r5)		#display newest thing to screen, display r6 contents to hex
	slli	r9, r9, 8		#shift the H now

		

	subi 	r11, r11, 1		#DECREMENT, should go 4 times	
#will probably be looping very fast so everything will look lit up.
#at least 4 of them

	#stwio 	r7, 4(r5)
	beq		r11, r0, END
	movia r12, 0	#set the delay counter to 0
	blt		r12, r13, Delay
	br		LOOP



END:
#RESET the h 
	movia r9, 0b01110110
	movia r11, 5
	br LOOP

Delay:
	addi r12, r12, 1
	beq r12, r13, LOOP
	br Delay
	
.end



.data
x:	.word	4	#counter so we know to loop 4 times
