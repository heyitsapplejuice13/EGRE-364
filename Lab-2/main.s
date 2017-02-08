	INCLUDE core_cm4_constants.s		; Load Constant Definitions
	INCLUDE stm32l476xx_constants.s      

	AREA    main, CODE, READONLY
	EXPORT	__main				; make __main visible to linker
	ENTRY			
				
__main	PROC
	
    ; Enable the clock to GPIO Port B	
	LDR r0, =RCC_BASE
	LDR r1, [r0, #RCC_AHB2ENR]
	ORR r1, r1, #RCC_AHB2ENR_GPIOBEN
	STR r1, [r0, #RCC_AHB2ENR]

	; MODE: 00: Input mode, 01: General purpose output mode
    ;       10: Alternate function mode, 11: Analog mode (reset state)
	LDR r0, =GPIOB_BASE
	LDR r1, [r0, #GPIO_MODER]
	BIC r1, r1,  #(0x3<<4)
	ORR r1, r1,  #(0x1<<4)
	STR r1, [r0, #GPIO_MODER]

	LDR r1, [r0, #GPIO_ODR]
	ORR r1, r1,  #(0x1<<2)
	STR r1, [r0, #GPIO_ODR]
  
stop 	B 		stop     		; dead loop & program hangs here

	ENDP

Delay 		PROC 
			push {r1}
			ldr r1, =0x60000   ;initial value for loop counter
again  		NOP  		     ;execute two no-operation instructions
			NOP
			subs r1, #1
			bne again
			pop {r1}
			bx lr
			ENDP


	ALIGN			

	AREA    myData, DATA, READWRITE
	ALIGN
array	DCD   1, 2, 3, 4
	END
