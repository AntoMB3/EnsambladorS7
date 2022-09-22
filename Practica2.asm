;Inicializamos la plantilla reducida
.MODEL SMALL                        

;Esto es una pila :), defaul 25 pesos de tortilla
.STACK                                           

;segmento de datos
.DATA

vector DB 05h,02h,01h,09h,03h 
mult DW 10000
divi DW 10
numero DW 0

;Declaraciones (variables, constantes, etc...)

.CODE

inicio:

       MOV AX, @DATA
       MOV DS, AX
       
       ;My code
           CICLO:
              XOR AX,AX
              MOV AL,vector[DI]
              INC DI
              MUL mult
              ADD numero,AX
              MOV Ax,mult
              DIV divi
              MOV mult,Ax
              CMP DI,5
              JBE CICLO
              
       ;Terminador de programa
       MOV AH, 4Ch ;Llama al sercivio 09h de
       INT 21h     ;la interrupcion del programa
       
END inicio
END 