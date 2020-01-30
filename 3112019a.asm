myds SEGMENT PARA 'data'
n	DW	15
GIRIS	DW 1,2,0,7,8,7,0,3,9,6,4,5,2,3,5;15 elemanlı
arr	DW	10 DUP(0)
myds ENDS

myss SEGMENT PARA STACK 'stack'
	DW	12	DUP(?)
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
		MOV CX,n
		DEC CX
		
	L1:	MOV BX,GIRIS[SI]
		ADD BX,BX
		INC arr[BX]
		ADD SI,2
		LOOP L1
		
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN