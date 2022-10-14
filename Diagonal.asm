;Inicializamos la plantilla reducida

.MODEL SMALL

;Segmento de pila, defaull 1K

.STACK

;Segmento de datos
.DATA  

color DB 01

;Declaraciones (variables, constantes, etc)
.CODE

inicio:

    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 00h
    MOV AL, 13h
    INT 10h
    
    MOV CX, 00h

Ciclo:
    MOV AL, color ;Color para pintar
    MOV DX, CX
    MOV AH, 0Ch
    INT 10h
    INC CX
    CMP CX,96h
    JE Salir
    INC color
    JMP Ciclo

Salir:        
    
    
    
    ;Terminador de programa
    MOV AH,4CH ;Llama al servicio 09h
    INT 21H    ; de la interrupcion 21h
    
END inicio
END    