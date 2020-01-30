	PUBLIC SIRALIMI
	EXTRN dizi:BYTE,n:WORD
mycs SEGMENT PARA 'code'
	ASSUME CS:mycs
	SIRALIMI PROC FAR
		PUSH SI
		PUSH CX
	
		MOV CX,n
		XOR SI,SI
		DEC CX
	L1:
		CMP SI,n
		JAE sirali
		MOV AH,dizi[SI]
		CMP AH,dizi[SI+1]
		JG sirasiz
		INC SI
		JMP L1
	
	sirali:
		MOV AL,1
	sirasiz:
		POP CX
		POP SI
		
		RETF
		
	SIRALIMI ENDP
mycs ENDS
	END