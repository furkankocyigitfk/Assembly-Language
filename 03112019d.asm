;16 BİT İKİ SAYIYI TOPLAMA
myds SEGMENT PARA 'data'
	toplam	DD	0
	sayi1	DW	0FFFFH
	sayi2	DW	0FFFFH
myds ENDS

myss SEGMENT PARA STACK 'stack'
	DW 12 DUP(?)
myss ENDS

mycs SEGMENT PARA 'code'
	ASSUME CS:mycs,DS:myds,SS:myss
	
	MAIN PROC FAR 
		PUSH DS
		XOR AX,AX
		PUSH AX
		MOV AX,myds
		MOV DS,AX
		
		MOV AX,sayi1
		ADD WORD PTR[toplam],AX
		MOV AX,sayi2
		ADD WORD PTR[toplam],AX
		ADC WORD PTR[toplam+2],0
		
		RETF
	MAIN ENDP
mycs ENDS
	END MAIN