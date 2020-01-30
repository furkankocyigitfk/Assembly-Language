;n=10 dizi[i] < 15 || dizi[i]>50 sarti saglamayan indis
mys SEGMENT PARA 'code'
	ORG 100H
	ASSUME CS:mys,SS:mys,DS:mys
	MAIN PROC NEAR
		XOR SI,SI
		MOV AH,esik2
		MOV AL,esik1
		MOV CX,n
		
	L1:
		CMP AL,dizi[SI]
		JA don
		CMP AH,dizi[SI]
		JB don
		JMP son
		
	don:
		INC SI
		JMP L1
	son:
		MOV sonuc,SI
		RETN
	MAIN ENDP
n		DW	10
dizi	DB	11,9,3,21,56,78,98,90,12,14
esik1	DB 15
esik2	DB 50
sonuc	Dw	?
mys ENDS
	END MAIN