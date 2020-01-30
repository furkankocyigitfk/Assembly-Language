;soru 4,5,6
myds SEGMENT PARA 'data'
dizi	DB	25,45,79,89,65,23
n		DW	6
ort		DB	?;soru4
min		DB	?;soru5

m		DW	6;soru6
dizi1	DB	-1,10,0,23,45,1
dizi2	DB	2,23,12,5,-2,1
dizi3	DW	6	DUP(?)
myds ENDS

myss SEGMENT PARA STACK 'stack'
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
		
		XOR AX,AX;toplam tutulacak
		MOV CX,n
		XOR SI,SI
		
	L1:
		ADD AL,dizi[SI]
		ADC	AH,0
		INC SI
		LOOP L1
		
		DIV n
		MOV ort,AL
		
		;soru5
		MOV CX,n
		LEA SI,dizi
		MOV AL,[SI]
		INC SI
		DEC CX;donguyu bir azalt
		
	L2:	
		MOV AH,[SI]	
		CMP AL,AH; if arr[i] > arr[i+1]
		JB L3;kücükse sadece i++
		MOV AL,AH;degilse min guncelle ve l3 ü de yap.
	L3:	
		INC SI
		LOOP L2
	
		MOV min,AL
		;SORU6
		
		XOR SI,SI;dizi1 ve dizi2 icin iterasyon
		XOR DI,DI;dizi3 icin iterasyon
		XOR AX,AX
		MOV CX,m
		
	L4:	MOV AL,dizi1[SI]
		MOV BL,dizi2[SI]
		
		IMUL BL;carpma
		
		MOV dizi3[DI],AX
		INC SI
		ADD DI,2
		LOOP L4
		
		RETF 
	MAIN ENDP
mycs ENDS
	END MAIN