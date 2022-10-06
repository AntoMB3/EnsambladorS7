;Inicializamos la plantilla reducida

.MODEL SMALL

;Segmento de pila, defaull 1K

.STACK

;Segmento de datos
.DATA

BUF DB 10, ?, 10 DUP(?)  
integer DW 0
float DW 0 
sign DB 0
intExponent DW ?
floatExponent DW ?
mult DW 10
counter DB 0
divi DW 10
msg DB "Escribe un numero: $"
pointFlag DB 0 
pointPosition DB ?
initialPosition DB 2


;Declaraciones (variables, constantes, etc)
.CODE 


inicio:

    MOV AX, @DATA
    MOV DS, AX
    GetNum:
        ;Muestra el mensaje
        XOR DI, DI
        MOV pointFlag, 0h
        MOV initialPosition,2h
        MOV sign, 0h
        MOV AH,09h
        MOV DX,Offset msg
        MOV DX, Offset 10h
        INT 21h
        ;Pide una entrada de teclado 
        MOV AH,0Ah
        XOR CX,CX
        MOV DX, Offset BUF        
        INT 21h
        ;El primer espacio del vector guarda el tamanio, el segundo guarda cuantos caracteres tecleados
        ;Guardamos en CL la cantidad de caracteres tecleados
        INC DI
        MOV CL,BUF[DI]
        ADD CL, 1
        ;Comenzamos con el primer caracter
        INC DI ;DI = 2 (Primer caracter)       
        ;Comprobar el si es el caracter '-'
        CMP BUF[DI],45
        JE IfIsMinus
        ;Comprobar el si es el caracter '+'
        CMP BUF[DI], 2Bh
        JE IfIsPlus
        JMP ReadString
        

    IfIsMinus:
        MOV sign,1
        INC DI
        INC initialPosition
        JMP ReadString  
    
    IfIsPlus:
        MOV sign, 0
        INC DI
        INC initialPosition
        JMP ReadString
    
    ReadString:
        ;La etiqueta se repite hasta que se haya comprobado todo la cadena
        CMP DI, CX
        JA PointFix
        ;Comprobar si el caracter actual es un punto 
        CMP BUF[DI],46
        JE PointTrigger
        ;Convertimos de ASCII a valor numerico y validamos que verdaderamente sea un numero
        SUB BUF[DI], 30h
        JMP IsNum?
    
    PointTrigger:
        ;Validamos que no haya mas de un punto
        CMP pointFlag, 0h
        JA GetNum
        ;Incrementamos la pointFlag en uno 
        INC pointFlag
        ;Guardamos la posicion del punto
        XOR BX, BX
        MOV BX, DI
        MOV pointPosition, BL
        XOR BX, BX
        ;Pasamos a leer el siguiente caracter
        INC DI
        JMP ReadString  
    
    IsNum?:
        XOR AX, AX
        MOV AL, BUF[DI]
        ;Validamos que el valor convertido este entre [0,9]   
        CMP AL, 0h
        JB GetNum 
        CMP AL, 9h
        JA GetNum
        ;Pasamos a leer el siguiente caracter
        INC DI
        JMP ReadString
    
    PointFix:
        CMP pointFlag, 0
        JA CreateExponents
        MOV pointPosition, CL
        INC pointPosition
    
    CreateExponents:
        XOR AX,AX
        MOV AL,pointPosition
        SUB AL,initialPosition
        MOV intExponent,AX
        SUB intExponent, 1h
        CMP pointFlag,0
        JE Auxiliar2
        XOR AX, AX
        MOV AL, CL
        SUB AL, pointPosition
        MOV floatExponent, AX
        SUB floatExponent, 1h
        
    Auxiliar2:
        XOR BX, BX
        MOV BX,intExponent
        MOV intExponent, 1
    
    PowerInt:
        XOR AX, AX
        MOV AL,counter
        CMP AX,BX
        JAE Auxiliar
        MOV AX, intExponent
        MUL mult
        INC counter
        MOV intExponent,AX
        JMP PowerInt
    
    Auxiliar:
        XOR BX, BX
        MOV BX, floatExponent
        MOV floatExponent, 1
        MOV counter, 0
        CMP pointFlag, 0
        JE ResetDI
    
    PowerFloat:
        XOR AX, AX
        MOV AL,counter
        CMP AX,BX
        JAE ResetDI
        MOV AX, floatExponent
        MUL mult
        INC counter
        MOV floatExponent,AX
        JMP PowerFloat     
        
    ResetDI:
        XOR AX, AX
        MOV AL, initialPosition
        MOV DI, AX
    
    
    ChooseCase:
        XOR BX, BX
        MOV BX, DI 
        CMP BL, CL
        JA  EndCase
        CMP BL, pointPosition
        JB  IntegerCase
        JA  FloatCase
        INC DI
        JMP ChooseCase
    
    IntegerCase:
        XOR AX,AX
        XOR DX, DX
        MOV AL, BUF[DI]
        MUL intExponent
        ADD integer,AX
        INC DI 
        MOV AX,intExponent
        DIV divi
        MOV intExponent, AX
        JMP ChooseCase
            
    FloatCase:
        XOR AX,AX
        XOR DX, DX
        MOV AL, BUF[DI]
        MUL floatExponent
        ADD float,AX
        INC DI 
        MOV AX,floatExponent
        DIV divi
        MOV floatExponent, AX
        JMP ChooseCase
    
    EndCase:

    ;Terminador de programa
    MOV AH,4CH ;Llama al servicio 09h
    INT 21H    ; de la interrupcion 21h
    
END inicio
END    