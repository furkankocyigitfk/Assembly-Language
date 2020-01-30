;u=(a+b+c)/2 ve Alan(ABC)^2=u(u-a)(u-b)(u-c)
;stack in durumu dizi[i],dizi[i+1],dizi[i+2],OFFSET,BX,CX,DI,DX,BP
;dizi[i]=BP+16
;dizi[i+1]=BP+14
;dizi[i+2]=BP+12
	PUBLIC ALAN_BUL
mycs SEGMENT PARA 'code'
	ASSUME CS:mycs
	ALAN_BUL PROC FAR
		PUSH BX
		PUSH CX
		PUSH DI
		PUSH DX
		PUSH BP
		
		MOV BP,SP
		XOR AX,AX
		ADD AX,[BP+18]
		ADD AX,[BP+16]
		ADD AX,[BP+14]
		SHR AX,1
		
		MOV BX,AX;u
		SUB BX,[BP+18];u-a
		MOV CX,AX
		SUB CX,[BP+16];u-b
		MOV DI,AX
		SUB DI,[BP+14];u-c
		
		MUL BX
		MUL CX
		MUL DI
		
		POP BP
		POP DX
		POP DI
		POP CX
		POP BX
		
		RETF 6
	ALAN_BUL ENDP
mycs ENDS
	END