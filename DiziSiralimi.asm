;BYTE atanımlı bir dizinin sıralı olup olmadığını bulan asm
myds SEGMENT PARA 'data'
dizi 	DB 1,2,3,4,5
n 	 	DW 5
durum	DB ?
myds	ENDS

myss SEGMENT PARA 'stack'
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
		
		XOR BX,BX;kontrol degiskenini sifirlama
		XOR SI,SI;i -> iterasyon
		MOV CX,n
		DEC CX
		
	CONTROL_AREA:
		CMP BX,0
		JNE L1
		CMP SI,CX
		JAE L1
	
	LTEST:
		MOV AL,dizi[SI] 
		CMP AL,dizi[SI+1]
		JLE L2
		MOV BX,1
	L2:	
		INC SI
		
		JMP CONTROL_AREA
	L1:
		CMP BX,0
		JE L3
		MOV durum,1
	L3:
		MOV durum,0
		
		RETF
		
	MAIN ENDP
mycs ENDS
	END MAIN