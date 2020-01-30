myds SEGMENT PARA 'data';ARR DE ORTALAMA VE MIN BULMA
n 	DW	10
arr DB	20,12,56,76,89,1,34,54,23,17
ort	DB	?
min	DB	?

myds ENDS

myss SEGMENT PARA STACK 'stack'
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
		
		XOR SI,SI
		MOV CX,n
		XOR AX,AX
		
	L1:	ADD AL,arr[SI]
		ADC AH,0
		INC SI
		LOOP L1
		
		DIV n
		MOV ort,AL
		
		XOR SI,SI
		MOV CX,n
		DEC CX
		MOV AL,arr[SI];min
		INC SI
	L3:	
		MOV AH,arr[SI]
		CMP AL,AH
		JA L2
	L4:	INC SI
		LOOP L3
		JMP L5
	L2:
		MOV AL,arr[SI]
		JMP L4
		
	L5:
		MOV min,AL
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN
		