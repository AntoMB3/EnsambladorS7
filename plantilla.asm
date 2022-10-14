s;Inicializamos la plantilla reducida
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
       ;practica 5
      
       ;Terminador de programa
       MOV AH, 4Ch ;Llama al sercivio 09h de
       INT 21h     ;la interrupcion del programa
       
END inicio
END 