;code segment ortak
	EXTERN SAY1:FAR
myss SEGMENT PARA STACK 'stack'
	DW 20 DUP(?)
myss ENDS

myds SEGMENT PARA 'data'
n		DW 12
dizi	DB 12,12,12,12,12,12,12,13,14,15,16,12
aranan	DB 12
sonuc	DW ?
myds ENDS

mycs SEGMENT PARA PUBLIC 'cde'
	ASSUME CS:mycs,SS:myss,DS:myds
	
	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX,myds
		MOV DS,AX
		
		XOR AX,AX
		MOV AL,aranan
		PUSH AX
		PUSH n
		LEA AX,dizi
		PUSH AX
		CALL SAY1
		MOV sonuc,AX
		
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN