cdseg	SEGMENT PARA 'code'
		ORG 100H
		ASSUME CS:cdseg,DS:cdseg,SS:cdseg
		
	BASLA:
		JMP MAIN
		dizi1 	DW 	0BH,13H,2FH,64H,011DH,01CAH,2B67H
		N		DW	7H
		dizi2	DW	7	DUP(?)
		dizi3	DW	0FEE2H,5055H,0EC8BH,468BH,3D06H,0001H,1F74H,0D150H
		dizi4	DW	50E8H,0EDE8H,8FFFH,0646H,66D1H,5806H,01A9H,7400H
		dizi5	DW	0EB03H,9007H,4EFFH,0EB06H,9004H,46FFH,5806H,0C35DH
		eleman2	DW	0FEE2H
		
		
	MAIN PROC NEAR
		XOR SI,SI
		MOV CX,N	
	L1:
		PUSH dizi1[SI]
		CALL ASSIST
		POP	dizi2[SI]
		ADD SI,2
		LOOP L1
		RET
	MAIN ENDP
	
	ASSIST PROC NEAR
	ASSIST ENDP
cdseg ENDS
	END BASLA
		