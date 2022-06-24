SSI0_DR				EQU	0x40008008 ; Clock Prescale
GPIO_PORTA_DATA		EQU	0x400043FC

					AREA	subroutine, READONLY, CODE
					THUMB					
					
					EXTERN 	DELAY10
					EXTERN 	wh_digit
					EXPORT	FREQ_DISP
						
FREQ_DISP		   	PROC
					PUSH	{LR, R0, R1,R2,R3,R4,R8,R6,R10,R12}
					
			
					
					LDR 	R1,=GPIO_PORTA_DATA 
					LDR 	R0,[R1]
					BIC 	R0,R0,#0x40		;DC=0 (command)
					STR 	R0,[R1]					
					LDR 	R1,=SSI0_DR 
					MOV 	R0,#0x20		;H=0
					STR 	R0,[R1]
					BL		DELAY10
					MOV 	R0,#0x44		;5th row
					STR 	R0,[R1]
					MOV 	R0,#0xB2
					STR 	R0,[R1]
					BL		DELAY10
					LDR 	R1,=GPIO_PORTA_DATA 
					LDR 	R0,[R1]
					ORR 	R0,R0,#0x40			;DC=1 (data)
					STR 	R0,[R1]
					
					LDR 	R1,=SSI0_DR						
					
				
					
					LDR 	R1,=GPIO_PORTA_DATA 
					LDR 	R0,[R1]
					BIC 	R0,R0,#0x40			;DC=0 (command)
					STR 	R0,[R1]					
					LDR 	R1,=SSI0_DR 
					MOV 	R0,#0x20		;H=0
					STR 	R0,[R1]
					BL		DELAY10
					MOV 	R0,#0x44		;5th row
					STR 	R0,[R1]
					MOV 	R0,#0xB2
					STR 	R0,[R1]
					BL		DELAY10
					LDR 	R1,=GPIO_PORTA_DATA 
					LDR 	R0,[R1]
					ORR 	R0,R0,#0x40			;DC=1 (data)
					STR 	R0,[R1]
					LDR 	R1,=SSI0_DR	
					
;; R9 keeps the frequency number ---------------------------------------					
					MOV		R8,#100
					UDIV 	R10,R9,R8 	   ;first wh_digit
					BL	 	wh_digit				 
					MOV 	R0,#0x00
					STR 	R0,[R1]
					
					MUL 	R3,R10,R8 
					SUB 	R2,R9,R3					
					MOV 	R6,#10
					UDIV 	R10,R2,R6	   ;second wh_digit				 
					BL	 	wh_digit
					MOV 	R0,#0x00
					STR 	R0,[R1]
					
					MUL 	R12,R10,R6
					SUB 	R10,R2,R12 	   ;third wh_digit								
					BL	 	wh_digit					
					
					POP		{LR, R0, R1,R2,R3,R4,R8,R6,R10,R12}
					BX		LR
					ENDP						
					ALIGN
					END