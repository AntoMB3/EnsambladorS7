;Inicializamos la plantilla reducida

.MODEL SMALL

;Segmento de pila, defaull 1K

.STACK

;Segmento de datos
.DATA
numero DW 2599
unidades DB ?
decenas DB ?
centenas DB ?
divisor DW 1000
arreglo DB 4 DUP(?)
comodin DB 10
;Declaraciones (variables, constantes, etc)
.CODE

inicio:

    MOV AX, @DATA
    MOV DS, AX
    
    ;My code
    XOR AX,AX
    MOV AX, numero
    ciclo:        
        DIV divisor
        MOV arreglo[DI], AL
        MOV AX, divisor
        DIV comodin
        MOV divisor, AX
        INC DI
        MOV AX, DX
        XOR DX, DX
        CMP DI, 04h
    JL ciclo
    
    
    
    ;Terminador de programa
    MOV AH,4CH ;Llama al servicio 09h
    INT 21H    ; de la interrupcion 21h
    
END inicio
END    