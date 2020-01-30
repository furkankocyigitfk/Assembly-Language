myds SEGMENT PARA 'data';ayna yapma
n	DW	10
a1	DB	1,2,3,4,5,6,7,8,9,10
a2	DB	10	DUP(?)
myds ENDS

myss SEGMENT PARA STACK 'stack'
	DW 12 DUP(?)
myss ENDS

mycs SEGMENT PARA 'code'
	ASSUME CS:mycs,DS:myds,SS:myss
	
	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX,myds
		MOV DS,AX
		
		MOV CX,n
		MOV BX,n
		DEC BX
		SHR CL,1
		XOR SI,SI
		
	L1:
		MOV AH,a1[BX]
		MOV AL,a1[SI]
		;XCHG a1[SI],a1[BX] YANLIŞ
		XCHG AL,AH
		MOV a1[BX],AH
		MOV a1[SI],AL
		DEC BX
		INC SI
		LOOP L1
	
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN