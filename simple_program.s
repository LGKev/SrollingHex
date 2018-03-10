	.text
	.equ 	HEX0,		0xFF200020	#hex0 address base
	.equ	HEX_INDEX,			4	# loop over the 4 hexes
	.equ	WAIT_DELAY,			9000000 #I think this might be redundent because wait_dealy is decalred in data.
	.equ	LetterArraySize,		17	#currently we only have []hello_ _ _ in the array
	.global _start
_start:
	movia 	r5, HEX0		# move r5 to be the hex base address.
#make an index
	movia 	r6, LetterArray	#points to first element. offsets allow next element. in array
	ldw		r9, 0(r6)		#load the first element into r9
	stwio	r0, 0(r5)		# Display value off to HEX0
	movia 	r11, LetterArraySize			#execute 4 times, for the 4 display	
	movia 	r13, 9000000		#delay of 9 million cycles?
	 	

LOOP:

#	add 	r6, r6, r9		#add r9 (H) to the r6 register.

	#mov		r6, r9			#copy r9 into r6 #REDUNDENT and poor use of memory /registers. delete
	#erase previous display to get scroll. done automatically by the shift left logical imiidiate (SLLI), fills with 0
	stwio	r9, 0(r5)		#display newest thing to screen, display r6 contents to hex
	slli	r9, r9, 8		#shift the H now
	#get next letter: increment array index, add to r9
	addi 	r6, r6, 4		#increment the index/ increment the address.
	ldw		r7, 0(r6)		#load value at that address at r6, load into r7, for keeping, add to r9
	add		r9, r7, r9

		

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
	movia r6, LetterArray
	movia r11, LetterArraySize
	br LOOP

Delay:
	addi r12, r12, 1
	beq r12, r13, LOOP
	br Delay
	



.data
#HEX_INDEX:	.word	4	#counter so we know to loop 4 times
#WAIT_DELAY: .word 	9000000	# simple counter based delay. 
LetterArray: 
	.word  0x00, 0x76, 0x79, 0x38, 0x38,0x3F, 0x00, 0x7F, 0x3E, 0x71, 0x71, 0x6D, 0x40, 0x40,0x40, 0x00, 0x00, 0x00 
		# off, H	, E ,	L,		L,   0,		_, B, U, F, F, S, _, _

.end #put this at the end!
