;Inicializamos la plantilla reducida
.MODEL SMALL                        

;Esto es una pila :), defaul 25 pesos de tortilla
.STACK                                           

;segmento de datos
.DATA

;Declaraciones (variables, constantes, etc...)
array DB 10 DUP(?)

.CODE

inicio:

       MOV AX, @DATA
       MOV DS, AX
       
       ;My code    
       ;
       ;   ;Direccionamiento inmediato
           MOV Ax,100 ;copiar 100 decimal a Ax
           MOV Bx, 0FFFH ;Copiar el 6000 no se que a Bx
           MOV Cx, 0011001111001100b ;Copiar 33cch
                      
           ;Direccionamiento Por registro
           MOV Dx, Ax 
       
           ;Direccionamiento por dato
           
       ;Terminador de programa
       MOV AH, 4Ch ;Llama al sercivio 09h de
       INT 21h     ;la interrupcion del programa
       
END inicio
END 