;500 elemanlı word tipinde dizinin elemanları[0..9] arasında.Frekanslarını bir dizide tut.
myds SEGMENT PARA 'data'
n		DW	15
dizi 	DW	5,4,3,1,7,6,5,9,0,8,1,2,5,4,7
count	DW	10	DUP(0);500 un hesi 0 olabilir.Bu yüzden word tanımlı
myds ENDS

myss SEGMENT PARA STACK 'stack'
	DW 20 dup(?)
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
		
	L1:	MOV BX,dizi[SI]
		INC count[BX]
		ADD SI,2
		LOOP L1
		
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN