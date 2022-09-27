;Inicializamos la plantilla reducida

.MODEL SMALL

;Segmento de pila, defaull 1K

.STACK

;Segmento de datos
.DATA

BUF DB 10, ?, 10 DUP(?)  

entero DW 0
decimal DW 0
 
sign DB 0

posinicial DW ?
posfinal DW ?
potencia DW ?

mult DW 10
contador DW 0
maxpotencia DW 1
divi DW 10
salto DB 0               
error DB 0
msg DB "Escribe un numero: $"

;Declaraciones (variables, constantes, etc)
.CODE 


inicio:

    MOV AX, @DATA
    MOV DS, AX
    
    getNum:
        MOV AH,09h
        MOV DX,Offset msg
        INT 21h
        
        MOV AH,0Ah
        XOR CX,CX
        MOV DX, Offset BUF
        
        INT 21h
        INC DI
        MOV CL,BUF[DI]
        ADD CL, 1
        INC DI
        
        ;Obtener el signo
        CMP BUF[DI],45
        JE Minus
        CMP BUF[DI], 2Bh
        JE Plus
        XOR AX, AX
        MOV AL,BUF[DI]
        SUB AL, 30h
        
        CMP AL, 0h
        JAE a 

     
    Integers:        
        CMP DI,CX
        JA seAcabo2
        
        ;Checa si es un punto
        CMP BUF[DI],46
        JE rellenarDecimal
        
        SUB BUF[DI], 30h
        INC DI
        JMP Integers
    
    Minus:
        MOV sign,1
        INC DI
        MOV posinicial,DI
        JMP Integers  
    
    Plus:
        MOV sign, 0
        INC DI
        MOV posinicial,DI
        JMP Integers
     
    rellenarDecimal:
        MOV posfinal, DI
    
        MOV AX,posfinal
        SUB AX,posinicial
        MOV potencia,AX
        
        MOV DI,posinicial
        JMP generarpotencia
                   
    generarpotencia:
        MOV AX,contador
        MOV BX,potencia
        SUB BX,1 
        
        CMP AX,BX
        JAE ELEGIRSALTO
    
        MOV AX,maxpotencia
        MUL mult
        ADD contador,1
        MOV maxpotencia,AX
        JMP generarpotencia
        
    ELEGIRSALTO:
        CMP salto,0
        JE convertirnumero
        
        CMP salto,1
        JE rellenardecimales
    
    convertirnumero:
        XOR AX,AX
        MOV AL, BUF[DI]
        MUL maxpotencia
        ADD entero,AX
        INC DI 
        
        MOV Ax,maxpotencia
        DIV divi
        MOV maxpotencia, AX
        
        CMP DI,posfinal
        JA decimales
        
        JMP convertirnumero
        
    decimales:
        INC DI
        MOV AX,posfinal
        MOV posinicial, AX
        MOV posfinal, CX
        MOV contador,0
        MOV maxpotencia,1
        
        MOV AX,posfinal
        SUB AX,posinicial
        MOV potencia,AX
        MOV salto,1
        MOV DI,posinicial
        
        JMP generarpotencia
        
        
     rellenardecimales:
        INC DI
        XOR AX,AX
        SUB BUF[DI],30h
        MOV AL, BUF[DI]
        MUL maxpotencia
        ADD decimal,AX
         
        
        MOV Ax,maxpotencia
        DIV divi
        MOV maxpotencia, AX
        
        CMP DI,posfinal
        JA seAcabo
        
        JMP rellenardecimales
    a:
        CMP AL, 9h
        JBE b
        MOV error,1
        JMP getNum
    b:
        MOV sign, 0
        MOV posinicial,DI
        JMP integers         
        
        
    
    
        
    seAcabo:

    ;Terminador de programa
    MOV AH,4CH ;Llama al servicio 09h
    INT 21H    ; de la interrupcion 21h
    
END inicio
END    