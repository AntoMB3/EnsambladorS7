;Inicializamos la plantilla reducida
.MODEL SMALL                        

;Esto es una pila :), defaul 25 pesos de tortilla
.STACK                                           

;segmento de datos
.DATA
HORA DB ?
MINUTO DB ?
SEGUNDO DB ?
MILISEGUNDO DB ?
MSG DB "$" 
HORARIO DB 15 DUP(?)
DIVI DB 10 

DIVS DW ?
divis DB 10

ANIO DB 4 DUP(?)
MESe DB ?
DIAe DB ?
MES DB 2 DUP(?)
DIA DB 2 DUP(?)


;Declaraciones (variables, constantes, etc...)

.CODE

inicio:

       MOV AX, @DATA
       MOV DS, AX
       
       ;My code
       JMP obtenerHora
       
       obtenerHora:
         MOV AH,2CH
         INT 21H
         JMP HORAS
       
       HORAS:
         XOR AX,AX
         MOV HORA, CH
         MOV AL,HORA
         DIV DIVI
         MOV HORARIO[DI],AL
         INC DI
         MOV HORARIO[DI],AH
         INC DI
         JMP MINUTOS
         
       MINUTOS:
         XOR AX,AX
         MOV HORARIO[DI],0AH
         INC DI
         MOV MINUTO, CL
         MOV AL,MINUTO
         DIV DIVI
         MOV HORARIO[DI],AL
         INC DI
         MOV HORARIO[DI],AH
         INC DI
         JMP SEGUNDOS
         
         
        SEGUNDOS:
         XOR AX,AX
         MOV HORARIO[DI],0AH
         INC DI
         MOV SEGUNDO, DH
         MOV AL,SEGUNDO
         DIV DIVI
         MOV HORARIO[DI],AL
         INC DI
         MOV HORARIO[DI],AH
         INC DI
         JMP MILISEGUNDOS
         
         MILISEGUNDOS:
         XOR AX,AX
         MOV HORARIO[DI],0AH
         INC DI
         MOV MILISEGUNDO, DL
         MOV AL,MILISEGUNDO
         DIV DIVI
         MOV HORARIO[DI],AL
         INC DI
         MOV HORARIO[DI],AH
         INC DI
         
         
         MOV DI,0
         CICLO:
            CMP DI,11
            JA obtenerFecha
            
            ADD HORARIO[DI],30h
            INC DI
            JMP CICLO
            
         obtenerFecha:
            MOV AH,02Ah
            INT 21h
            MOV MESe,DH
            MOV DIAe,DL
            XOR DX,DX
            JMP obtenerAnio
            
         obtenerAnio:
            XOR DI, DI
            MOV DIVS,1000
            JMP LlenarVectorAnio
         
         LlenarVectorAnio:
            MOV AX,CX
            DIV DIVS
            MOV ANIO[DI],AL
            INC DI
            MOV AX,DIVS
            DIV divis
            MOV DIVS,AX
            MOV CX,DX
            XOR DX,DX
            
            CMP DIVS,256
            JE obtenerMes
            JMP LlenarVectorAnio
            
         obtenerMes:
            XOR AX,AX
            XOR DX,DX
            MOV AL,MESe
            DIV divis
            MOV DI,0
            MOV MES[DI],AL
            INC DI
            MOV MES[DI],AH
            
         obtenerDia:
            XOR AX,AX
            XOR DX,DX
            MOV AL,DIAe
            DIV divis
            MOV DI,0
            MOV DIA[DI],AL
            INC DI
            MOV DIA[DI],AH
            
            
         
         SALIR:
         
         
         
         ;Terminador de programa
       MOV AH, 4Ch ;Llama al sercivio 09h de
       INT 21h     ;la interrupcion del programa
       
END inicio
END 