;word tipindeki bir dizide ciftlerin ve teklerin ortalamasini ayri ayri bulan exe tipi asm programını yazın.Dizi boyutu maximum 300 elemanlı
myds SEGMENT	PARA 'data'
	cift_top	DD	0
	tek_top		DD	0
	cift_sayi	DW	0
	tek_sayi	DW	0
	cift_ort	DW	?
	tek_ort		DW	?
	n			DW	10
	dizi		DW	1,2,3,4,5,6,7,8,9,10;7FFFH,7A82H,70B2H,7111H,71FAH,7232H,7AF8H,78C6H,7530H,70E0H
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
		
		XOR SI,SI
		MOV CX,n
		DEC CX
		
	L1:	MOV AX,dizi[SI]
		TEST AX,0001H
		JZ LABELCIFT
		ADD WORD PTR[tek_top],AX
		ADC WORD PTR[tek_top + 2],0
		INC tek_sayi
		JMP arttirLabel
	LABELCIFT:
		ADD WORD PTR[cift_top],AX
		ADC WORD PTR[cift_top + 2],0
		INC cift_sayi
	arttirLabel:
		ADD SI,2
		LOOP L1
		MOV AX,WORD PTR[tek_top]
		MOV DX,WORD PTR[tek_top + 2]
		DIV tek_sayi
		MOV tek_ort,AX
		
		MOV AX,WORD PTR[cift_top]
		MOV DX,WORD PTR[cift_top + 2]
		DIV cift_sayi
		MOV cift_ort,AX

		RETF
	MAIN ENDP
mycs ENDS
		END MAIN
	
