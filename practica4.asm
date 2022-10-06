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
MSG DB " de $"
BLANCO DB " $" 
HORARIO DB 15 DUP(?)
DIVI DB 10 

DIVS DW ?
divis DB 10

ANIO DB 5 DUP(?)
MESe DB ?
DIAe DB ?
MES DB 3 DUP(?)
DIA DB 3 DUP(?)
NUMDIA DB ?
Menu DB "Escoje una opcion", 0AH, 0DH, "1: Ver la hora", 0AH, 0DH,"2: Ver la fecha", 0AH, 0DH,"Cualquier otra tecla para salir", 0AH, 0DH,"$"
LUNES DB "Lunes$"
MARTES DB "Martes$"
MIERCOLES DB "Miercoles$"
JUEVES DB "Jueves$"
VIERNES DB "Viernes$"
SABADO DB "Sabado$"
DOMINGO DB "Domingo$"
MSG2 DB " Hrs$"
ENERO DB "Enero$"
FEBRERO DB "Febrero$"
MARZO DB "Marzo$"
ABRIL DB "Abril$"
MAYO DB "Mayo$"
JUNIO DB "Junio$"
JULIO DB "Julio$"
AGOSTO DB "Agosto$"
SEPTIEMBRE DB "Septiembre$"
OCTUBRE DB "Octubre$"
NOVIEMBRE DB "Noviembre$"
DICIEMBRE DB "Diciembre$"


;Declaraciones (variables, constantes, etc...)

.CODE

inicio:

       MOV AX, @DATA
       MOV DS, AX
       
       ;My code
       MOV AH,09h
       MOV DX, Offset Menu
       INT 21h
       MOV AH,08h
       INT 21h
       CMP AL, 31h
       JE obtenerHora
       CMP AL, 32h
       JE obtenerFecha
       JMP Salir
       
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
         MOV HORARIO[DI], 24h
         
         MOV DI,0
         CICLO:
            CMP DI,11
            JAE ImprimirHora
            
            ADD HORARIO[DI],30h
            INC DI
            JMP CICLO
            
         obtenerFecha:
            XOR AX,AX
            MOV AH,02Ah
            INT 21h
            MOV NUMDIA, AL
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
            ADD ANIO[DI],30h
            INC DI
            MOV AX,DIVS
            DIV divis
            MOV DIVS,AX
            MOV CX,DX
            XOR DX,DX
            
            CMP DIVS,256
            JE FinalCaracter
            JMP LlenarVectorAnio
         
         FinalCaracter:
         MOV ANIO[DI], 024h
         
            
         obtenerMes:
            XOR AX,AX
            XOR DX,DX
            MOV AL,MESe
            DIV divis
            MOV DI,0
            MOV MES[DI],AL
            ADD MES[DI],30h
            INC DI
            MOV MES[DI],AH
            ADD MES[DI],30h
            INC DI
            MOV MES[DI], 024h
            
         obtenerDia:
            XOR AX,AX
            XOR DX,DX
            MOV AL,DIAe
            DIV divis
            MOV DI,0
            MOV DIA[DI],AL
            ADD DIA[DI],30h
            INC DI
            MOV DIA[DI],AH
            ADD DIA[DI],30h
            INC DI
            MOV DIA[DI], 024h
        
        CMP NUMDIA, 0h
        JE ImpDomingo
        CMP NUMDIA, 1h
        JE ImpLunes
        CMP NUMDIA, 2h
        JE ImpMartes
        CMP NUMDIA, 3h
        JE ImpMiercoles
        CMP NUMDIA, 4h
        JE ImpJueves
        CMP NUMDIA, 5h
        JE ImpViernes
        CMP NUMDIA, 6h
        JE ImpSabado    
         
        ImpLunes:
            MOV DX, Offset LUNES
            MOV AH,09h
            INT 21h
            MOV DX, Offset BLANCO
            INT 21h
            MOV DX, Offset DIA
            INT 21h
            JMP ChecarMes
         
        ImpMartes:
            MOV DX, Offset MARTES
            MOV AH,09h
            INT 21h
            MOV DX, Offset BLANCO
            INT 21h
            MOV DX, Offset DIA
            INT 21h
            JMP ChecarMes
            
        ImpMiercoles:
            MOV DX, Offset MIERCOLES
            MOV AH,09h
            INT 21h
            MOV DX, Offset BLANCO
            INT 21h
            MOV DX, Offset DIA
            INT 21h  
            JMP ChecarMes
        
        ImpJueves:
            MOV DX, Offset JUEVES
            MOV AH,09h
            INT 21h
            MOV DX, Offset BLANCO
            INT 21h
            MOV DX, Offset DIA
            INT 21h 
            JMP ChecarMes
        
        ImpViernes:
            MOV DX, Offset VIERNES
            MOV AH,09h
            INT 21h
            MOV DX, Offset BLANCO
            INT 21h
            MOV DX, Offset DIA
            INT 21h 
            JMP ChecarMes
        
        ImpSabado:
            MOV DX, Offset SABADO
            MOV AH,09h
            INT 21h
            MOV DX, Offset BLANCO
            INT 21h
            MOV DX, Offset DIA
            INT 21h  
            JMP ChecarMes
        
        ImpDomingo:
            MOV DX, Offset DOMINGO
            MOV AH,09h
            INT 21h
            MOV DX, Offset BLANCO
            INT 21h
            MOV DX, Offset DIA
            INT 21h    
            JMP ChecarMes                  
        
        ChecarMes:
            CMP MESe, 1h
            JE ImpEnero
            CMP MESe, 2h
            JE ImpFebrero 
            CMP MESe, 3h
            JE ImpMarzo
            CMP MESe, 4h
            JE ImpAbril 
            CMP MESe, 5h
            JE ImpMayo 
            CMP MESe, 6h
            JE ImpJunio 
            CMP MESe, 7h
            JE ImpJulio 
            CMP MESe, 8h
            JE ImpAgosto 
            CMP MESe, 9h
            JE ImpSeptiembre 
            CMP MESe, 0Ah
            JE ImpOctubre 
            CMP MESe, 0Bh
            JE ImpNoviembre 
            CMP MESe, 0Ch
            JE ImpDiciembre
        
         ImpEnero:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset ENERO
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir
         ImpFebrero:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset FEBRERO
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir
         ImpMarzo:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset MARZO
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir
         ImpAbril:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset ABRIL
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir
         ImpMayo:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset MAYO
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir
         ImpJunio:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset JUNIO
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir
         ImpJulio:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset JULIO
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir
         ImpAgosto:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset AGOSTO
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir
            
         ImpSeptiembre:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset SEPTIEMBRE
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir
         ImpOctubre:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset OCTUBRE
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir
         ImpNoviembre:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset NOVIEMBRE
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir
         ImpDiciembre:
            MOV DX, Offset MSG
            MOV AH,09h
            INT 21h
            MOV DX, Offset DICIEMBRE
            INT 21h
            MOV DX, Offset MSG
            INT 21h
            MOV DX, Offset ANIO
            INT 21h
            JMP Salir      
          
         ImprimirHora:    
            MOV DX, Offset HORARIO
            MOV AH,09h
            INT 21h 
            MOV DX, Offset MSG2
            INT 21h   
         
         
         SALIR:
         
         
         
         ;Terminador de programa
       MOV AH, 4Ch ;Llama al sercivio 09h de
       INT 21h     ;la interrupcion del programa
       
END inicio
END 