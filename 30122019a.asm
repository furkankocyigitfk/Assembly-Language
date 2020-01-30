;tek ve ciftlerin ortalamasını ayrı ayrı bulan exe tipi asm
myds SEGMENT PARA 'data'
n 			DW 10
dizi		DW 10,12,13,53,15,64,76,54,31,133
cift_top	DD 0
tek_top		DD 0
tek_sayi	DW 0
cift_sayi	DW 0
tek_ort		DW ?
cift_ort	DW ?
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
		LEA SI,dizi
		
	L1:
		MOV AX,[SI]
		TEST AX,1
		JZ cift_label
		ADD WORD PTR[tek_top],AX
		ADC WORD PTR[tek_top+2],0
		INC tek_sayi
		JMP arttir
		
	cift_label:
		ADD WORD PTR[cift_top],AX
		ADC WORD PTR[cift_top+2],0
		INC cift_sayi
		
	arttir:
		ADD SI,2
		LOOP L1
		
		
		MOV DX,WORD PTR[cift_top+2]
		MOV AX,WORD PTR[cift_top]
		DIV cift_sayi
		MOV cift_ort,AX
		
		MOV DX,WORD PTR[tek_top+2]
		MOV AX,WORD PTR[tek_top]
		DIV tek_sayi
		MOV tek_ort,AX
		
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN
		
		
	