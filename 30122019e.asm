;MACRO ornek dizi min bulma
mycs SEGMENT PARA 'code'
	ORG 100H
	ASSUME CS:mycs,SS:mycs,DS:mycs
	BASLA:JMP MAIN

n		DW 8
dizi	DB 11,9,3,21,56,78,98,90
min		DB ?
x		DB 1

	ENKCK MACRO dizi,n
		LOCAL L1
		XOR SI,SI
		MOV AL,dizi[SI]
		MOV CX,n
		DEC CX
		INC SI
		
	L1:
		CMP AL,dizi[SI]
		JB don
		MOV AL,dizi[SI]
	don:
		INC SI
		LOOP L1
		ENDM

	MAIN PROC NEAR
		XOR SI,SI
		MOV CX,n
		
	L1:
		SHR dizi[SI],1
		INC SI
		LOOP L1
		
		ENKCK dizi,n
		MOV min,AL
		
		RETN
	MAIN ENDP
mycs ENDS
	END BASLA
		