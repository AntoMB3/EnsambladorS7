;Inicializamos la plantilla reducida
.MODEL SMALL                        

;Esto es una pila :), defaul 25 pesos de tortilla
.STACK                                           

;segmento de datos
.DATA
number DW ?  
mult DW 2
resultado DB 8 DUP(?)
max DW 60000 
exceso DW 1  
restaMax DW 34464

;Numero maximo 65535

;Declaraciones (variables, constantes, etc...) 
;Antonio Munoz Barrientos y nada mas

.CODE

inicio:

       MOV AX, @DATA
       MOV DS, AX
       
       ;My code
       MOV number, 19253
       
             JMP MAIN
                     
             limpiar:
                SUB exceso,02h
                ADD Ax,31072
                MOV number,Ax
                JMP MAIN
             
             Agregar: ;Si pasa de 100,000 pero no de 131,072
                MOV resultado[DI],01h
                INC DI  
                XOR Dx,Dx ;Borramos el exceso
                SUB exceso,1    ;Quitamos
                SUB Ax,restaMax ;100,000 al valor
                MOV number,Ax
                JMP MAIN  
                
               
             Exe2:
                  MOV resultado[DI],01h
                  INC DI
                  
                  CMP Ax,restaMax
                  JBE limpiar
                  SUB exceso,1
                  SUB Ax,restaMax
                  MOV number,Ax
                  JMP MAIN
                  
             
             
             ;Detecta si paso de 100000
             IFCien:
                CMP exceso,2  ;Checamos si el numero esta por encima de 131072
                JAE Exe2
                CMP Ax,restaMax ;Checamos si pasa de 100,000 del numero
                JA Agregar
                MOV resultado[DI],0h
                INC DI
                MOV number,Ax
                JMP MAIN
                
             
             MAIN:       ;Condicion de salir para que no cicle cuando se llena el exceso
              CMP DI,8
              JA SALIR
              
              MOV Ax,exceso   ;Multiplicar el exceso x2
              MUL mult
              MOV exceso,Ax
              
              MOV Ax,number     ;Multiplicar el numero x2
              MUL mult
              MOV number,Ax 
              
              ADD exceso,Dx     ;Agregar al exceso si llega a ver exceso
              CMP exceso,1
              JAE IFCien ;Brinca si el numero mayor es max
              
              MOV resultado[DI],0h
              INC DI
              CMP DI,8
              JBE MAIN
              
              SALIR:
                
              
       ;Terminador de programa
       MOV AH, 4Ch ;Llama al sercivio 09h de
       INT 21h     ;la interrupcion del programa
       
END inicio
END 