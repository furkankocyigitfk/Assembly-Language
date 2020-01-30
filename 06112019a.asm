;Word tanımlı işaretli sayılardan oluşan 300 elemanlı bir dizide neg,poz,0 sayılarını tutmak
myds SEGMENT PARA 'data'
negative	DW	?
positive	DW	?
zero		DW	?
n			DW	10;normalde 300
dizi		DW	-1,2,4,0,-10,20,0,5,0,-3
myds	ENDS

myss SEGMENT PARA STACK'stack'
	DW	20	DUP(?)
myss ENDS

mycs SEGMENT PARA 'code'
	ASSUME CS:mycs,DS:myds,SS:myss
	
	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX,myds
		MOV DS,AX
		
		LEA SI,dizi
		MOV CX,n
		MOV negative,0
		MOV positive,0
		MOV zero,0
		
	L1:	MOV AX,[SI]
		CMP AX,0
		JE Lzero
		JG Lpoz
		INC negative
		JMP L4
	
	Lzero:
		INC zero
		JMP L4
	Lpoz:
		INC positive
	L4:
		ADD SI,2
		LOOP L1
	
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN
	
