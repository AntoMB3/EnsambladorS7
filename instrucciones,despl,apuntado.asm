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
       
        ;Operaciones logicas
        ;Not
        MOV Ax, 0FF00h
        NOT Ax
        
        ;Or mascara de encendido
        MOV Bx, 0CC00h
        OR Ax,Bx
        
        ;And mascara de apagado
        MOV Bx, 0FF33h
        AND Ax,Bx
        
        ;XOR      Clean o selectiva
        XOR Bx, Bx                 
        MOV Bx, 0FFFFh
        XOR Ax,Bx  
        
        ;Desplazamiento logico
        
        SHL Ax, 02
        
        SAR Ax, 02
        
        MOV Bx, 00FFh
        SAR Bx, 02h
        
        ;Rotaciones
        
        ROL Ax,01h
        ROR Bx,02h
        
        ;Rotaciones con carry
        RCR Ax, 01h
        RCL Bx, 01h
        
        
       
       ;Terminador de programa
       MOV AH, 4Ch ;Llama al sercivio 09h de
       INT 21h     ;la interrupcion del programa
       
END inicio
END 