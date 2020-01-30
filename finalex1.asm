;dizi sirali mi harici yordam
	EXTRN SIRALIMI:FAR
	PUBLIC dizi,n
myds SEGMENT PARA 'data'
n		DW 7
sonuc	DB 0
dizi	DB 12,14,16,18,20,22,24
myds ENDS

myss SEGMENT PARA STACK 'stack'
	DW 20 DUP(?)
myss ENDS

mycs SEGMENT PARA 'code'
	ASSUME CS:mycs,SS:myss,DS:myds
	
	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX,myds
		MOV DS,AX
		
		CALL SIRALIMI
		CMP AL,0
		JZ sirali
		MOV sonuc,1
		
	sirali:
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN
