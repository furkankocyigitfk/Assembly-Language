myds SEGMENT PARA 'data'
N		DW	9
dizi 	DW  12, 5, 9, 51, 7, 8, 18, 1, 14
x		DW	?
y		DW	?
z		DW	?
cevre	DW	3001
myds ENDS

myss SEGMENT PARA STACK 'stack'
	DW	110 DUP(?)
myss ENDS

mycs SEGMENT PARA 'code'
	ASSUME CS:mycs,DS:myds,SS:myss
	
	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX,myds
		MOV DS,AX
		
	;SIRALAMA SELECTION SORT
		XOR SI,SI
		MOV CX,N
		DEC CX;N-1
		
	;SI-->i,DI-->min,BX-->j
		
	L3:
		MOV DI,SI;min=i
		PUSH CX
		
		MOV BX,SI;j=i
		ADD BX,2;j=i+1
		MOV CX,N
		ROR SI,1
		SUB CX,SI
		ROL SI,1
		DEC CX;N-i-1
		
	L2:	
		MOV AX,dizi[BX];AX=dizi[j]
		CMP AX,dizi[DI]
		JA L1
		MOV DI,BX
		
	L1:
		ADD BX,2
		LOOP L2
		
		MOV AX,dizi[DI];AX=dizi[min]
		XCHG AX,dizi[SI];AX=dizi[i]
		MOV dizi[DI],AX
		
		POP CX
		
		ADD SI,2
		LOOP L3
	
	;FINISH SORT
	
		MOV CX,N
		SUB CX,2
		XOR SI,SI;i
		
	LI:
		PUSH CX
		MOV DI,SI;j=i+1
		ADD DI,2
		
	LJ:
		PUSH CX
		MOV BX,DI;k=j+1
		ADD BX,2
		
	LK:
		MOV AX,dizi[BX]
		SUB AX,dizi[SI]
		CMP AX,dizi[DI]
		JAE L5
		MOV AX,dizi[SI]
		ADD AX,dizi[DI]
		ADD AX,dizi[BX];dizi[i]+dizi[j]+dizi[k]
		CMP AX,cevre
		JAE L5
		MOV cevre,AX
		MOV AX,dizi[SI]
		MOV x,AX
		MOV AX,dizi[DI]
		MOV y,AX
		MOV AX,dizi[BX]
		MOV z,AX
		
	L5:
		ADD BX,2
		LOOP LK
		
		POP CX
		ADD DI,2
		LOOP LJ
		
		POP CX
		ADD SI,2
		LOOP LI
		
		RETF
		
	MAIN ENDP
mycs ENDS
	END MAIN
	