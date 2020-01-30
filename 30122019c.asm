;esik degeri -20 den kucuk eleman var mı ona bakan COM tipi asm
mys SEGMENT PARA 'code'
	ORG 100H
	ASSUME CS:mys,SS:mys,DS:mys
	BASLA:JMP MAIN
n 		DW 10
dizi	DB 12,22,13,43,55,-10,0,4,-19,-9
esik	DB -20
sonuc	DB ?
	
	MAIN PROC NEAR
		XOR SI,SI
		MOV CX,n
		MOV AL,esik
		
	L1:
		CMP SI,n
		JAE bulunamadi
		CMP AL,dizi[SI]
		JGE bulundu
		INC SI
		JMP L1
		
	bulunamadi:
		MOV sonuc,0
		JMP son
	bulundu:
		MOV sonuc,1
	
	son:
		RET
	MAIN ENDP
mys ENDS
	END BASLA