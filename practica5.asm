;Inicializamos la plantilla reducida

.MODEL SMALL

;Segmento de pila, defaull 1K

.STACK

;Segmento de datos
.DATA  

msg DB "Escoge una opcion para dibujar",0Ah,0DH,"1. Cuadrado",0Ah,0DH,"2. Rectangulo",0Ah,0DH,"3. Triangulo",0Ah,0DH,"4.Rombo",0Ah,0DH,,"5. Salir",0Ah,0DH,"$"

;Declaraciones (variables, constantes, etc)
.CODE

inicio:

    MOV AX, @DATA
    MOV DS, AX
    
    
    
    MENU:
    XOR AX,AX
    XOR DX,DX
    MOV AH,09h
    MOV Dx,Offset msg
    INT 21h
    MOV AH,08H
    Int 21h
    
    CMP AL,31h
    JE Cuadrado
    CMP AL, 32h
    JE Rectangulo
    CMP AL, 33h
    JE Triangulo
    CMP AL, 34h
    JE Rombo
    CMP AL,35h
    JE exit
    JMP Clean
        
    ;JMP Cuadrado
    
    ;JMP Rectangulo
    ;JMP Triangulo
    JMP Rombo
    

Cuadrado:
    MOV AH, 00h
    MOV AL, 13h
    INT 10h
    MOV AL,05h
    MOV DX,10h
    MOV CX,10h
    MOV AH,0Ch
    INT 10h
    JMP lado1

lado1:
    CMP CX,50h
    JAE lado2
    INC CX
    INT 10h
    JMP lado1
    
lado2:
     CMP DX,50h
     JAE lado3
     INC DX
     INT 10h
     JMP lado2
lado3:
    CMP CX,10h
    JE lado4
    DEC CX
    INT 10h
    JMP lado3
lado4:
    CMP Dx,10h
    JE Salir
    DEC Dx
    INT 10h
    JMP lado4
    
Rectangulo:
    MOV AH, 00h
    MOV AL, 13h
    INT 10h
    MOV AL,02h
    MOV DX,10h
    MOV CX,10h
    MOV AH,0Ch
    INT 10h
    JMP lado1R

lado1R:
    CMP CX,94h
    JAE lado2R
    INC CX
    INT 10h
    JMP lado1R
lado2R:
     CMP DX,50h
     JAE lado3R
     INC DX
     INT 10h
     JMP lado2R
lado3R:
    CMP CX,10h
    JE lado4R
    DEC CX
    INT 10h
    JMP lado3R
lado4R:
    CMP Dx,10h
    JE Salir
    DEC Dx
    INT 10h
    JMP lado4
    
Triangulo:
    MOV AH, 00h
    MOV AL, 13h
    INT 10h
    MOV AL,0eh
    MOV DX,10h
    MOV CX,25h
    MOV AH,0Ch
    INT 10h
    JMP lado1T

lado1T:
    CMP CX,45h
    JAE lado2T
    INC CX
    INC DX
    INT 10h
    JMP lado1T
lado2T:
    CMP CX,05h
    JE lado3T
    DEC CX
    INT 10h
    JMP lado2T
lado3T:
    CMP dx,10h
    JE Salir
    DEC dx
    INC CX
    INT 10h
    JMP lado3T
Rombo:
    MOV AH, 00h
    MOV AL, 13h
    INT 10h
    MOV AL,0ch
    MOV DX,10h
    MOV CX,25h
    MOV AH,0Ch
    INT 10h
    JMP lado1B
lado1B:
    CMP Cx,45h
    JAE lado2B
    INC cx
    INC dx
    INT 10h
    JMP lado1B
lado2B:
    CMP cx,25h
    JBE lado3B
    INC dx
    DEC cx
    INT 10h
    JMP lado2B
lado3B:
    CMP cx,05h
    JBE lado4B
    DEC cx
    DEC dx
    INT 10h
    jmp lado3B
lado4B:
    CMP dx,10h
    JE Salir
    DEC dx
    INC cx
    INT 10h
    JMP lado4B
        
Salir:
    JMP Clean  
    
Clean:
    MOV AL,08H
    INT 21h
    MOV AH,00h
    MOV AL,13h
    INT 10h
    JMP MENU
exit:  
    ;Terminador de programa
    MOV AH,4CH ;Llama al servicio 09h
    INT 21H    ; de la interrupcion 21h

    
END inicio
END    