    ;Inicializamos la plantilla reducida
.MODEL SMALL                        

;Esto es una pila :), defaul 25 pesos de tortilla
.STACK                                           

;segmento de datos
.DATA


;Declaraciones (variables, constantes, etc...)                
MSG DB 0AH, 0DH, "Ingresa 20 numeros separados por comas: $"
MSG2 DB 0AH, 0DH, "Numeros ordenados: $"
STRINGNUMS DB 80, ?, 80 DUP(?)
NUMS DB 20, ?, 20 DUP(?)
Count DB ?
Numbers DB 0
Changes DW 0
X10 DB 10   
NumbersD DW 0
.CODE

inicio:

       MOV AX, @DATA
       MOV DS, AX
       XOR SI,SI
       
      ;My code
        Input:
           MOV Count, 0h
           MOV AH, 09h
           MOV DX, OFFSET MSG
           INT 21h
           MOV AH, 0Ah                 
           MOV DX, OFFSET STRINGNUMS
           INT 21h
           MOV DI, 1h
           MOV BL,STRINGNUMS[DI] 
           INC BL
           INC DI 
       
        Verificacion:
  
            ;Validar comas
            CMP STRINGNUMS[DI], 2Ch
            JE Aux
            
            ;Convertir el ascii a numero
            SUB STRINGNUMS[DI], 30h
            
            ;Validacion de numeros   
            CMP STRINGNUMS[DI], 0h
            JB Input 
            CMP STRINGNUMS[DI], 9h
            JA Input
            
            ;Validacion de numeros con hasta dos digitos
            INC Count
            CMP Count, 2h
            JA Input
            
            INC DI
            CMP DI, BX
            JA  A
            JMP Verificacion
       
        Aux:
            INC DI
            CMP STRINGNUMS[DI], 2Ch
            JE Input
            MOV Count, 0h
            JMP Verificacion
            
        A:
            XOR CX,CX
            MOV CX,2h
            MOV DI,2h
            MOV Count, 0h
            
        
        Touring:
            CMP STRINGNUMS[DI],2Ch
            JE DecisionDigits
            CMP STRINGNUMS[DI],0Dh
            JE DecisionDigits
            INC DI
            INC Count
            CMP DI, BX  
            JA Reset2 
            JMP Touring
        
        DecisionDigits:
            INC Numbers
            CMP Count,2h
            JE  TwoDigits
            JMP OneDigit
                    
        TwoDigits:
            MOV BX,DI
            MOV DI,CX
            MOV AL, STRINGNUMS[DI]
            MUL X10
            MOV NUMS[SI], AL
            INC DI
            MOV AL, STRINGNUMS[DI]
            ADD NUMS[SI], AL
            JMP Reset
            
        
        OneDigit:
            MOV BX,DI
            MOV DI,CX
            MOV AL, STRINGNUMS[DI]
            MOV NUMS[SI],AL
            JMP Reset
          
        Reset:
            INC SI
            MOV DI,BX
            INC DI
            MOV CX,DI
            MOV Count, 0h
            XOR BX,BX
            MOV BL, STRINGNUMS[1h]
            ADD BL, 2h    
            JMP Touring
        
        Reset2:
            MOV Changes, 0h
            MOV DI, 0h
            MOV SI, DI
            INC SI
            XOR AX,AX
            XOR BX,BX
            XOR CX,CX
            MOV CL, Numbers
            
        BubbleSort:
            MOV AH, NUMS[DI]
            MOV AL, NUMS[SI]
            CMP AH,AL
            JA Greather
            JMP INCDISI
        
        Greather:
            MOV BL, NUMS[SI]
            MOV BH, NUMS[DI]
            MOV NUMS[SI], BH
            MOV NUMS[DI], BL
            INC Changes
            JMP INCDISI
                
        
        INCDISI:
            MOV DI, SI
            INC SI
            CMP SI, CX
            JE While
            JMP BubbleSort
        
        While:
            CMP Changes, 0h
            JE Reset3
            JMP Reset2
        
        Reset3:
            XOR AX,AX
            XOR DX,DX
            XOR BX,BX
            MOV DI, 0
            MOV DX, OFFSET MSG2
            MOV AH,09h
            INT 21h
            XOR AX,AX
            XOR DX,DX
            MOV AL, Numbers
            MOV NumbersD, AX
            DEC NumbersD
            XOR AX,AX
        
        Print:  
            XOR BX,BX
            XOR AX,AX
            MOV AL, NUMS[DI]
            DIV X10
            CMP AL, 0h
            JE PDigit
            MOV Count, AL
            MOV BL,AH
            MOV AH, 02h
            MOV DL, Count
            ADD DX,30h
            INT 21h
            MOV Count, BL
            MOV DL, Count
            ADD DX,30h
            INT 21h
            INC DI
            JMP PComa
        
        PDigit:
            MOV Count, AH
            MOV AH, 02h
            MOV DL, Count
            ADD DX,30h
            INT 21h  
            INC DI
            JMP PComa     
        
        PComa:
            CMP DI,NumbersD
            JA Salir
            MOV DX, 2Ch
            INT 21h
            JMP Print    
            
            
        
        Salir:
            
            
            
        
       ;Terminador de programa
       MOV AH, 4Ch ;Llama al sercivio 09h de
       INT 21h     ;la interrupcion del programa
       
END inicio
END 