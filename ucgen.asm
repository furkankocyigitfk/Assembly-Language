myds SEGMENT PARA 'data';3 kenarı verilen ücgenin tipini bulan exe uzantılı asm
	a	DB	12
	b	DB	17
	c	DB	12
	tip DB	?
myds ENDS

myss SEGMENT PARA 'yigin'
	DW 12 DUP(?)
myss ENDS

mycs SEGMENT PARA 'code'
	ASSUME CS:mycs,SS:myss,DS:myds
MAIN PROC FAR
	PUSH DS
	XOR AX,AX
	PUSH AX
	MOV AX,myds
	MOV DS,AX
	
	MOV AL,a
	MOV BL,b
	MOV CL,c
	
	CMP AL,BL
	JE L1
	CMP BL,CL
	JE L2
	CMP AL,CL
	JE L2
	MOV tip,3
	JMP son

L1:
	CMP AL,CL
	JNE L2
	MOV tip,1
	JMP son
L2:
	MOV tip,2
son:
	RETF
	
MAIN ENDP
mycs ENDS
	END MAIN
	
	
	
	