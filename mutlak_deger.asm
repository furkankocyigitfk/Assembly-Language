myds SEGMENT PARA 'data'
a	DW	5
b	DW	7
myds ENDS

myss SEGMENT PARA STACK 'stack'
	DW	12 DUP(?)
myss ENDS

mycs SEGMENT PARA 'code'
	ASSUME CS:mycs,DS:myds,SS:myss
	
	mutlak_fark PROC NEAR
		POP BX
		POP AX
		
		CMP AX,BX
		JB L1;ax<bx  ise
		SUB AX,BX;ax>bx ise
		JMP L2
	
	L1:
		SUB AX,BX
		NOT AX
	L2:
		PUSH AX
		RET
	mutlak_fark ENDP
	
	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX,myds
		MOV DS,AX
		
		MOV AX,a
		MOV BX,b
		
		XOR AX,AX
		XOR BX,BX
		
		PUSH AX
		PUSH BX
		
		CALL mutlak_fark
		POP AX
		
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN
		