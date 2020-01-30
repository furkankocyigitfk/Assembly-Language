;iki sirali diziyi merge etme.diziler byte+isaretli sayilar
myds SEGMENT PARA 'data'
	n	DW	4
	m	DW	6
	d1	DB	1,5,8,12
	d2	DB	-7,2,3,4,10,12
	d3	DB	10 DUP(?)
	
myds ENDS

myss SEGMENT PARA STACK 'stack'
	DW 12 DUP(?)
myss	ENDS

mycs SEGMENT PARA 'code'
	ASSUME CS:mycs,SS:myss,DS:myds
	
	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX,myds
		MOV DS,AX
		
		XOR BX,BX;i
		XOR SI,SI;j
		XOR DI,DI;k
		
	dongu:
		CMP BX,n
		JAE L1
		CMP SI,m
		JAE L1
		MOV AL,d1[BX]
		MOV AH,d2[SI]
		CMP AL,AH
		JL L2
		MOV d3[DI],AH
		INC SI
		JMP L3
	
	L2:
		MOV d3[DI],AL
		INC BX
	L3:
		INC DI
		JMP	dongu
	
	L1:;donguden cık
		CMP BX,n
		JE L4;i==n ise d3 e d2 yi kopyala
		MOV CX,n
		SUB CX,BX
	L6:	MOV AL,d1[BX]
		MOV d3[DI],AL
		INC DI
		INC BX
		LOOP L6
		JMP L7
	L4:	
		MOV CX,m
		SUB CX,SI
	L5:	MOV AL,d2[SI]
		MOV d3[DI],AL
		INC DI
		INC SI
		LOOP L5
	
	L7:
		RETF
	MAIN ENDP
mycs ENDS
		END MAIN
		
		
