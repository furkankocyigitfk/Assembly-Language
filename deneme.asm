codesg SEGMENT PARA 'kod'
	ORG 100H
	ASSUME CS:codesg,DS:codesg,SS:codesg
BASLA: JMP L7
N	DW 11
ESIK DW 19,47,64h,011dh,01cah
SONUC DB 67h
SONUC2 DW 072bh
DIZI DW 7 DUP(0)
A DB 0
SONUC3 DW 0FEE2h
ANA PROC NEAR
	PUSH BP
	PUSH AX
	MOV BP,SP
	MOV AX,[BP+6]
	
	;MOV AX,WORD PTR[BP]
	CMP AX,1
	JZ L1
	PUSH AX
	SHR AX,1
	PUSH AX
	CALL ANA
	POP [BP+6]
	SHL WORD PTR [BP+6],1
	POP AX
	TEST AX,1
	JZ L2
	JMP SON
L2: DEC WORD PTR [BP+6]
	JMP L1
SON:INC WORD PTR [BP+6]
L1:	POP AX
	POP BP
	RET
L5:	LOOP L5
L7:	XOR SI,SI
	MOV CX,SONUC2
L3:	PUSH [SI+0103h]
	CALL ANA
	POP [SI+0113h]
	ADD SI,2
	LOOP L3
	RET
L4:	LOOP L4
	SBB [BX+SI],AL
	ADD [BX+SI],AL
	ADD [BX+SI],AL
	ADD AL,0E0h
	CLC	
ANA ENDP
codesg ENDS
	END BASLA