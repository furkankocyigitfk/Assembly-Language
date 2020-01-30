;INTRASEGMENT ornegi;ust alma programı EXE tipi
myds SEGMENT PARA 'data'
x	DB	2
y	DW	5
sonuc	DB ?
myds ENDS

myss SEGMENT PARA STACK 'stack'
	DW 20 DUP(?)
myss ENDS


mycs SEGMENT PARA 'code'
	ASSUME CS:mycs,SS:myss,DS:myds
	
	MAIN PROC NEAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX,myds
		MOV DS,AX
		
		XOR BH,BH
		MOV BL,x
		MOV CX,y
		CALL USTAL
		MOV sonuc,AL
		RETF
	MAIN ENDP
	
	USTAL PROC NEAR
		PUSH DX
		MOV AX,1
	L1:
		MUL BX
		LOOP L1
		POP DX
		RETN
	USTAL ENDP
mycs ENDS
	END MAIN
	