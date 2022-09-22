;Inicializamos la plantilla reducida
.MODEL SMALL                        

;Esto es una pila :), defaul 25 pesos de tortilla
.STACK                                           

;segmento de datos
.DATA

;Declaraciones (variables, constantes, etc...)

.CODE

inicio:

       MOV AX, @DATA
       MOV DS, AX
       
       ;My code
       MOV Al, 10h
       MOV Bl, 20h
       
       ;Suma
       ADD Al, Bl ;Al = Al + Bl
       
       ;Suma con carry
       ADC Al, Bl ;Al = Al + bl + CF
       
       ;Resta
       SUB Al,Bl ;Al = Al - Bl
       MOV bl, 40h
       SUB Al, Bl
       
       ;Resta con prestamo
       SBB Al, Bl ;Al = Al - Bl - CF
       
       ;Multipliaciones
       
        ; 8 bits
        MOV Al, 0Fh
        MOV Bl, 02h
        
        MUL Bl ;Ax = Al * Bl
        MOV Al, 0FFh
        MOV Bl, 0FFh
        MUL BL
        
        ;16 bits
        MOV Ax,0FFFFh
        MOV Bl, 02h
        MUL Bx  ;Dx = Dx; Ax = Ax + Bx
        MOV Ax, 0FFFFh
        MOV Bx, 0FFFFh
        MUL Bx
        
       ;Division
        
        ; 8 BITS
          MOV Al, 0Bh
          MOV Cl, 02h
          DIV Cl  ;Al = Al / Cl, AH = Al % Cl  
         
        ; 16 BITS
          MOV Ax, 0FFFFh
          XOR CH,CH
          XOR Dx,Dx
          DIV Cx
       
       ;Terminador de programa
       MOV AH, 4Ch ;Llama al sercivio 09h de
       INT 21h     ;la interrupcion del programa
       
END inicio
END 