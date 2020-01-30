;verilen dizide max alanlı ucgen
;kenarlara stack uzerinden AX ten donduren
	EXTRN ALAN_BUL:FAR
myds SEGMENT PARA 'data'
kenar	DW 6,8,5,9,4,8,2,2,3
n		DW 3
maxA	DW 0
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
		
		MOV CX,n
		LEA SI,kenar
		
	L1:	
		PUSH [SI]
		PUSH [SI+2]
		PUSH [SI+4]
		CALL ALAN_BUL
		CMP AX,maxA
		JBE L2
		MOV maxA,AX
	L2:
		ADD SI,6
		LOOP L1
	
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN