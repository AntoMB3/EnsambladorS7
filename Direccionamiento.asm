;Inicializamos la plantilla reducida
.MODEL SMALL                        

;Esto es una pila :), defaul 25 pesos de tortilla
.STACK                                           

;segmento de datos
.DATA

;Declaraciones (variables, constantes, etc...)
array DB 10 DUP(?)
var DB 'A'
tabla DB 'B' , 'C' , 'D' , 'E'

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
           MOV array,CH         
           
           ;Direccionamiento indirecto por registro
           MOV Bl, [var]   ;Cambiar el formato De x = 16 bits a l = 8 bits para la direccion
           MOV Bx, 0721h
           Mov Bh, [Bx]
           
           ;Direccionamiento por registro base
           MOV Al, [tabla]+1  
           
           ;Direccionamiento Indexado
           MOV Di, 0000h
           MOV Al, tabla[Di]
           INC Di
           MOV Ah, tabla[Di]
           
           ;Direccionamiento indexado por base
           MOV Bx, 0002h
           MOV Cl, tabla[Bx][Di]
           
       ;Terminador de programa
       MOV AH, 4Ch ;Llama al sercivio 09h de
       INT 21h     ;la interrupcion del programa
       
END inicio
END 