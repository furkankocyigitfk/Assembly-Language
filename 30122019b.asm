;iki sirali diziyi tek sirali dizi yapma,isaretli sayilar icin,EXE tipi asm
myds SEGMENT PARA 'data'
n1		DW	7
n2		DW	6
d1		DB	7,12,64,98,104,105,125
d2		DB	-70,-10,9,17,68,90
d3		DB 13 DUP(?)
myds ENDS

myss SEGMENT PARA STACK 'stack'
	DW 20 DUP(?)
myss ENDS

mycs SEGMENT PARA 'code'
	ASSUME CS:mycs,DS:myds,SS:myss
	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX,myds
		MOV DS,AX
		
		XOR SI,SI
		XOR DI,DI
		XOR BX,BX
		
	L1:
		CMP SI,n1
		JAE atla
		CMP DI,n2
		JAE atla
		MOV AL,d1[SI]
		MOV AH,d2[DI]
		CMP AL,AH
		JL L2
		MOV d3[BX],AH
		INC DI
		JMP don
	
	L2:
		MOV d3[BX],AL
		INC SI
	
	don:
		INC BX
		JMP L1
	
	atla:
		CMP DI,n2
		JE L3
		MOV CX,n2
		SUB CX,DI
	L4:
		MOV AL,d2[DI]
		MOV d3[BX],AL
		INC BX
		INC DI
		LOOP L4
	L3:
		MOV CX,n1
		SUB CX,SI
	L5:
		MOV AL,d1[SI]
		MOV d3[BX],AL
		INC SI
		INC BX
		LOOP L5
		
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN
		