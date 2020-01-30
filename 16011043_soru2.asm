myds SEGMENT PARA 'data'
CR	EQU	13
LF	EQU	10
MSG1 DB CR, LF,'Dizinin boyutunu veriniz: ',0
MSG2 DB CR, LF, 'Dizinin elemanini giriniz: ',0
MSG3 DB CR, LF,'Verilen dizide ucgen olusturabilecek eleman yok !',0
MSG4 DB CR, LF,'KENAR: ',0
HATA DB CR, LF, 'HATA !!! LUTFEN SAYI GIRINIZ ',0
HATA1 DB CR, LF, 'HATA !!! KENAR NEGATIF OLAMAZ ',0
HATA2 DB CR, LF, 'HATA !!! KENAR 1-1000 ARASI OLMALIDIR. ',0

N		DW	?
dizi 	DW  100 DUP(?)
x		DW	?
y		DW	?
z		DW	?
cevre	DW	3001
myds ENDS

myss SEGMENT PARA STACK 'stack'
	DW	40 DUP(?)
myss ENDS

mycs SEGMENT PARA 'code'
	ASSUME CS:mycs,DS:myds,SS:myss		
	
	MAIN PROC FAR
		PUSH DS			;EXE’yi çağıran kodun kesim değeri DS’de,offset değeri 0,
		XOR AX,AX		;dönüş için bu değerler stack’e atılır.
		PUSH AX		
		MOV AX,myds		;EXE’nin kendi data segmenti DS’ye yazılır
		MOV DS,AX
		
					
		MOV AX,OFFSET MSG1;
		CALL PUT_STR	;ekrana "Dizinin boyutunu veriniz:" yazdırılır.
		CALL GETN		;dizinin eleman sayisini okuma
		MOV N,AX		;okunan eleman sayısını N degerine yazma
		
		XOR SI,SI		;eleman sayısı verilen diziyi okumak için dizi[i] indisini temsil ediyor
		MOV CX,N		;for döngüsünün dönme sayısının ayarlanması
		
	L_OKUMA:			
		MOV AX,OFFSET MSG2;
		CALL PUT_STR	;ekrana "Dizinin elemanini giriniz:" yazdırılır.
		CALL GETN		;dizinin eleman değeri okunur.
		MOV dizi[SI],AX	;okunan değer dizi nin i. elemanına kaydedilir
		ADD SI,2		;dizinin elemanları word tipi olduğundan 2 şer arttırılır.
		LOOP L_OKUMA
		
	
	;Sıralama için selection sort kullanılmıştır.
		XOR SI,SI		;SI(i) indisi için kullanılacak o yüzden sıfırlanıyor.
		MOV CX,N		;for döngüsünün dönme sayısının ayarlanması
		DEC CX;N-1		;for döngüsü N-1 defa dönecek.
		
		
	L3:
		MOV DI,SI		;DI(min) minimum olan elemanın indisi olarak kullanılacaktır.
		PUSH CX			;iki tane iç içe döngü olduğu için CX değeri korunmalıdır.Stack e atılır.
		
		MOV BX,SI		;j(BX)=i(SI). BX(j) indisi için kullanılacaktır. 
		ADD BX,2		;j=j+1
		MOV CX,N		;içerdeki for döngüsünün dönme sayısının ayarlanması
		SHR SI,1		;SI(i) değeri 2 şer arttırıldığından döngünün ayarlanması için 2 ye bölünmeli.
		SUB CX,SI		;N=N-i
		SHL SI,1		;SI(i) değeri eski haline getirilir.
		DEC CX			;N=N-1 for döngü N-i-1 defa dönecek
		
	L2:	
		MOV AX,dizi[BX]	;AX register ına dizi[j] değeri atılır.
		CMP AX,dizi[DI]	;dizi[j] elemanı ile dizi[min] elemanı karşılaştırılır.
		JA L1			;dizi[j] > dizi[min] ise herhangi bir değer güncellenmez.
		MOV DI,BX		;dizi[j] < dizi[min] ise min değeri güncellenir min = j olur
		
	L1:
		ADD BX,2		;j=j+1
		LOOP L2
		
		MOV AX,dizi[DI]	;AX register ına dizi[min] değeri atılır.
		XCHG AX,dizi[SI];AX registerındaki değer ile dizi[i] değeri swap edilir.
		MOV dizi[DI],AX	;dizi[min]=dizi[i] olur. Bu sayede dizi[min] ile dizi[i] swap edilir.
		
		POP CX			;korunan CX değeri stackten çekilir.
		
		ADD SI,2		;i=i+1
		LOOP L3
	
	;Sıralama bitti, minimum çevreli üçgen bulunması
		MOV CX,N		;en dışardaki for döngüsünün dönme sayısının ayarlanması
		SUB CX,2		;N - 2 defa dönecek
		XOR SI,SI		;SI(i) 
		
	LI:
		PUSH CX			;dış döngündeki CX değerinin korunması için stack e atılır.
		MOV DI,SI		;DI(j)=SI(i). DI(j) değeri ortadaki for döngüsünde iterasyon için kullanılıyor.
		ADD DI,2		;j=j+1
		
	LJ:
		PUSH CX			;ortadaki döngündeki CX değerinin korunması için stack e atılır.
		MOV BX,DI		;BX(k)=DI(j). BX(k) değeri en içerdeki for döngüsünde iterasyon için kullanılıyor.
		ADD BX,2		;k=k+1
		
	LK:
		MOV AX,dizi[BX]	;AX register ına dizi[k] değeri atılıyor
		SUB AX,dizi[SI]	;AX registerında dizi[k]-dizi[i] değeri var
		CMP AX,dizi[DI] ;dizi[k]-dizi[i] ile dizi[j] değerleri karşılaştırılıyor.
		JAE L5			;eğer dizi[k]-dizi[i] >= dizi[j] ise üçgen olamaz. Bu yüzden BX(k) değeri
						;arttırılır ve döngü devam eder.
						;dizi[k]-dizi[i] < dizi[j] ise üçgen olma şartını sağlar
		MOV AX,dizi[SI]	;AX register ına dizi[i] değeri atanır.
		ADD AX,dizi[DI]	;AX register ında dizi[i]+dizi[j] değeri vardır.
		ADD AX,dizi[BX]	;AX register ında dizi[i]+dizi[j]+dizi[k] değeri yani çevre vardır.
		CMP AX,cevre	;minimum çevreyi bulmak için cevre değeri ile karşılaştırılır.
		JAE L5			;eğer AX register ındaki değer cevre değişkenindeki değerden büyükse 
						;BX(k) değeri arttırılır ve döngü devam eder.
		MOV cevre,AX	;dizi[i]+dizi[j]+dizi[k]<cevre ise cevre=dizi[i]+dizi[j]+dizi[k] olarak guncellenir
		MOV AX,dizi[SI]	;x değişkenine dizinin i. elemanı bir kenarı olarak atanması için
						;AX registerına dizi[i] atanır.
		MOV x,AX		;x değeri dizi[i] olarak bir kenarı belirtir.
		MOV AX,dizi[DI]	;y değişkenine dizinin j. elemanı bir kenarı olarak atanması için
						;AX registerına dizi[j] atanır.
		MOV y,AX		;y değeri dizi[j] olarak bir kenarı belirtir.
		MOV AX,dizi[BX]	;z değişkenine dizinin k. elemanı bir kenarı olarak atanması için
						;AX registerına dizi[k] atanır.
		MOV z,AX		;z değeri dizi[k] olarak bir kenarı belirtir.
		
	L5:
		ADD BX,2		;BX(k) değeri dizide dolaşmak için arttırılır. k=k+1
		LOOP LK
		
		POP CX			;orta döngü için korunan CX değeri stackten çekilir.
		ADD DI,2		;DI(j) değeri dizide dolaşmak için arttırılır. j=j+1
		LOOP LJ	
		
		POP CX			;dış döngü için korunan CX değeri stackten çekilir.
		ADD SI,2		;SI(i) değeri dizide dolaşmak için arttırılır. i=i+1
		LOOP LI
				
		CMP cevre,3001	;cevre degiskeni ilk atanan değer ile kontrol edilir.
		JNE L4			;eğer aynı değilse uygun üçgen bulunmuştur.
		MOV AX,OFFSET MSG3;aynı ise uygun bir üçgen bulunamamıştır
		CALL PUT_STR	;"Verilen dizide ucgen olusturabilecek eleman yok !" mesajı kullanıcıya döndürülür.
		JMP L6			;program kapanır.
					
	L4:					;uygun kenarlar bulunduysa
		MOV AX,OFFSET MSG4;
		CALL PUT_STR	;"KENAR:" mesajı yazdırılır ve
		MOV AX,x		
		CALL PUTN		
		
		MOV AX,OFFSET MSG4
		CALL PUT_STR	;"KENAR:" mesajı yazdırılır ve
		MOV AX,y		;ikinci kenar değeri kullanıcıya gösterilir.
		CALL PUTN		
		
		MOV AX,OFFSET MSG4
		CALL PUT_STR	;"KENAR:" mesajı yazdırılır ve
		MOV AX,z		;üçüncü kenar değeri kullanıcıya gösterilir.
		CALL PUTN		
		
	L6:
		RETF

	MAIN ENDP
	
	
	GETC PROC NEAR
		;Klavyeden basılan karakteri AL registerına alır.Sadece AL registerı etkilenir.
		MOV AH,1H
		INT 21H
		RET
	GETC ENDP
	
	PUTC PROC NEAR
		;AL registerındaki değer kullanıcıya gösterilir.AX ve DX registerlarındaki değerleri korumak
		;için PUSH&POP işlemleri yapılır.
		PUSH AX
		PUSH DX
		MOV DL,AL
		MOV AH,2
		INT 21H
		POP DX
		POP AX
		RET
	PUTC ENDP
	
	GETN PROC NEAR
		;Klavyeden basılan sayıyı okur, sonucu AX registerı üzerinden döndürür.
		;DX sayının negatif olup olmadığını kontrol eder.
		;CX okunan sayının işlenmesi için ara değeri tutar.
		;AL klavyeden okunan karakter değerini tutar.
		;BL hane bilgisini tutar.
		;AX okunan sayı için dönüş değeridir.
		;Registerların önceki değerleri korunur.
		PUSH BX
		PUSH CX
		PUSH DX
		
	GETN_START:
		MOV DX,1	;sayı pozitif varsayılır.
		XOR BX,BX	;okuma yapılmadıysa hane sıfırdır.
		XOR CX,CX	;ara toplam değeri başta sıfırdır.
	
	NEW:
		CALL GETC	;klavyeden okunan karakter AL registerındadır.
		CMP AL,CR	
		JE FIN_READ	;eğer AL registerındaki değer '\n' ise okuma bitmiştir.
		CMP AL, '-'	
		JNE CTRL_NUM;eğer AL registerındaki değer '-' ,değil ise sayı 0-9 arası mı kontrol edilir. 
	
	NEGATIVE:		;AL registerındaki değer '-' ise hata mesajı döndürülür
		MOV AX,OFFSET HATA1
		CALL PUT_STR;"HATA !!! KENAR NEGATIF OLAMAZ " mesajı kullanıcıya gösterilir.
		MOV AX,OFFSET MSG2
		CALL PUT_STR;"Dizinin elemanini giriniz:" mesajı kullanıcıya döndürülür
		JMP NEW		;yeni değer için kullanıcıdan yeni değer beklenir.
	
	CTRL_NUM:		
		CMP AL, '0'	;sayının 0-9 arası olup olmadığı kontrol edilir.
		JB error	
		CMP AL, '9'
		JA error	;sayı 0-9 arası değilse hata mesajı gösterilir.
		SUB AL,'0'	;rakam alınır,hane toplama dahil edilir.
		MOV BL,AL	;BL registerına okunan hane değeri koyulur.
		MOV AX,10	;hane eklenirken *10 yapılacak
		PUSH DX		;MUL komutu DX değeri bozacağı için stack e atılır.
		MUL CX		;AX ile CX değeri çarpılır.
		POP DX		;DX in korunan değeri stackten çekilir.
		MOV CX,AX	;CX deki ara değer *10 yapılır.
		ADD CX,BX	;Okunan hane ara değere eklenir.
		JMP NEW		;yeni değer için kullanıcıdan yeni değer beklenir.
	
	ERROR:
		MOV AX,OFFSET HATA
		CALL PUT_STR;"HATA !!! LUTFEN SAYI GIRINIZ " mesajı kullanıcıya döndürülür.
		MOV AX,OFFSET MSG2
		CALL PUT_STR;"Dizinin elemanini giriniz: " mesajı kullanıcıya döndürülür.
		JMP GETN_START;kullanıcıdan yeni değer beklenir.
		
	ERROR1:
		MOV AX,OFFSET HATA2
		CALL PUT_STR;"HATA !!! KENAR NEGATIF OLAMAZ " mesajı kullanıcıya döndürülür.
		MOV AX,OFFSET MSG2
		CALL PUT_STR;"Dizinin elemanini giriniz: " mesajı kullanıcıya döndürülür.
		JMP GETN_START;kullanıcıdan yeni değer beklenir.
		
	FIN_READ:
		CMP CX,0		;sayi 0 mı kontrol ediliyor.
		JE ERROR1		;0 ise hata mesajı gösterilir
		CMP CX,1001		;sayı 1001 den büyük mü kontrol ediliyor
		JAE ERROR1		;büyükse  hata mesajı gösterilir
		MOV AX,CX		;sayı döndürlmek üzere AX registerına koyulur.
	
	FIN_GETN:			;korunan değerler stackten çekilir.
		POP DX
		POP CX
		POP DX
		RET
	GETN ENDP

	
	PUTN PROC NEAR
		;AL registerında bulunan sayıyı onluk tabanda hane hane yazdırır.
		;CX haneleri 10 bölmek için tutulan ara değer.
		;DX bölmede kullanılacak.
		;Registerların önceki değerleri korunur.
		PUSH CX
		PUSH DX
		XOR DX,DX	;bölme işleminin etkilenmemesi için 0 lanır.
		PUSH DX		;sona gelindiginin kontrolü için
		MOV CX,10	
		
	CALC_DIGITS:
		DIV CX		;DX:AX =AX/CX DX-->kalan ,AX --> bölüm
		ADD DX,'0'	;kalan değeri ascii olarak tutuluyor
		PUSH DX		;kalan değeri stackte saklanıyor.
		XOR DX,DX	;DX=0
		CMP AX,0	;bölme işleminin sonucu 0 ise bölüm tamamlanmıştır.
		JNE CALC_DIGITS; 0 değilse bölme işlemi devam eder.
		
	DISP_LOOP:
		;yazılacak tüm haneler stackte saklı onluk tabanda en değerli sayı stack in en üstünde
		;onluk tabanda en az değerli sayı stack in en altında. o değerin altında da sona vardığımızı
		;anlamak için 0 değeri var.
		POP AX		;değerler sırayla stackten alınır.
		CMP AX,0	;AX=0 ise stackten alınacak sayı kalmamıştır.
		JE END_DISP_LOOP
		CALL PUTC	;değerler yazdırılır.
		JMP DISP_LOOP
		
	END_DISP_LOOP:
		;stackte korunan değerler stackten çekilir
		POP DX
		POP CX
		RET 
	PUTN ENDP
	
	PUT_STR PROC NEAR
		;AX de adresi verilen sonunda '\0' değeri olan stringi karakter karakter yazdırır.
		;BX string te indis olarak kullanılmıştır. Önceki değeri saklanır.
		PUSH BX
		MOV BX,AX			;adres BX e alınıyor.
		MOV AL,BYTE PTR[BX]	;AL de ilk karakter bulunuyor.
	
	PUT_LOOP:				;AL deki değer '\0' ise yazdırma işlemi sonlanır. 
		CMP AL,0
		JE PUT_FIN
		CALL PUTC			;değil ise yazdırma işlemi karakter karakter yapılır.
		INC BX				;bir sonraki karaktere geçilir.
		MOV AL,BYTE PTR[BX]
		JMP PUT_LOOP		;yazdırma işlemi devam eder.
	
	PUT_FIN:				;stackte korunan BX değeri stackten çekilir
		POP BX
		RET
	PUT_STR ENDP
	
mycs ENDS
	END MAIN
	