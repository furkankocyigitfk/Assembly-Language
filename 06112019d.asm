;Celcius to Fahrenheit	F=((C*9)/5)+32
myds SEGMENT PARA 'data'
Cderece	DW	100
Fderece DW 	?
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
		
		XOR DX,DX
		MOV AX,Cderece
		MOV BX,9
		IMUL BX
		MOV BX,5
		IDIV BX
		ADD AX,32
		
		MOV Fderece,AX
		CALL ANA
		RETF
	MAIN ENDP
	
	ANA PROC NEAR
		RET
	ANA ENDP
	
mycs ENDS
	END MAIN
		
		
		
		