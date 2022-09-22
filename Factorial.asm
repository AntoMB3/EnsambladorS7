;Inicializamos la plantilla reducida
.MODEL SMALL                        

;Esto es una pila :), defaul 25 pesos de tortilla
.STACK                                           

;segmento de datos
.DATA
number DW 9
actual DW ?

;Declaraciones (variables, constantes, etc...)

.CODE

inicio:

       MOV AX, @DATA
       MOV DS, AX
       
       ;My code
             XOR Ax,Ax
             XOR Bx,Bx
             MOV AX,number
             MOV Bx,Ax
           ciclo:
            CMP Bx,01
            JE fuera
            SUB Bx,01h
            MUL Bx
            JMP ciclo
           
       fuera:
        MOV actual,Ax
             
       ;Terminador de programa
       MOV AH, 4Ch ;Llama al sercivio 09h de
       INT 21h     ;la interrupcion del programa
       
END inicio
END 