; ---------------------------------Modo grafico---------------------------------
; Dibujar rectangulo y linea
org 100h
section .text
    
    MOV CX, 240d ;columna
    MOV DX, 320d ;fila
    CALL modoVideo
    CALL dibRectangulo
    MOV DX, 440d
    MOV CX, 240d
    CALL printLine

end:
    int 20h

; Funciones

dibRectangulo:
    CALL printPoint
    INC CX
    CMP CX, 419 ; hasta donde llega el rectangulo de largo
    JE printRec
    JMP dibRectangulo

printRec:
    INC DX
    MOV CX, 240 ;reinicio al inicio del rectangulo 
    CMP DX, 400 ;hasta donde llega el rectangulo de alto
    JE retornar
    JMP dibRectangulo

printLine:
    call printPoint
    INC CX
    CMP CX, 419 ; hasta donde llega la linea
    JE retornar
    JMP printLine

retornar:
    RET

modoVideo:
    MOV AH, 00H
    MOV AL, 12H
    INT 10H
    RET

printPoint:
    MOV AH, 0CH ; para que empieze a pintar
    MOV AL, 7H ; color
    MOV BH, 00H ;num pagina
    ;MOV CX, 320D ;columna
    ;MOV DX, 240D ;fila
    int 10h;
    RET