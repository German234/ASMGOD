ORG 100h

SECTION .data
    msgmenu db "MENU:$"
    msg01 db "1. Para ver fig 1$"
    msg02 db "2. Para salir$"
    msg03 db "S. Para regresar al menu$"
    fin db "Fin$"
SECTION .text

Main:
    Menu:
    CALL ModoTexto ; Activa el modo texto
    mov dl, 25h ; pos cursor columna
    mov dh, 05h ; pos curso fila
    CALL PosicionCursorCadena ; posicion del cursor
    MOV SI, msgmenu ; valor a imprimir en la cadena
    CALL ImprimirCadena ; imprime el texto
    mov dl, 25h ; pos cursor columna
    mov dh, 06h ; pos curso fila
    CALL PosicionCursorCadena ; posicion del cursor
    MOV SI, msg01 ; valor a imprimir en la cadena
    CALL ImprimirCadena ; imprime el texto
    mov dl, 25h ; pos cursor columna
    mov dh, 07h ; pos curso fila
    CALL PosicionCursorCadena ; posicion del cursor
    MOV SI, msg02 ; valor a imprimir en la cadena
    CALL ImprimirCadena ; imprime el texto
    mov dl, 25h ; pos cursor columna
    mov dh, 08h ; pos curso fila
    CALL PosicionCursorCadena ; posicion del cursor
    MOV SI, msg03 ; valor a imprimir en la cadena
    CALL ImprimirCadena ; imprime el texto
    CALL BucleTecladoOpciones ; Espera las opciones del teclado
    INT 20h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; AUXILIARES
BucleTecladoOpciones:
    CALL ModoTeclado
    cmp al,"1"
    je ;Ir a
    cmp al,"2"
    je ;Ir a 
    cmp al,"S"
    je Menu ;Ir al menu
    jmp BucleTecladoOpciones
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MODO DIBUJO
DibujarRectangulo:

DibujarTriangulo:

DibujarLinea:

ModoVideo:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MODO TECLADO
ModoTeclado:
    mov ah, 00h
    int 16h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MODO TEXTO
ModoTexto:
    mov ah, 00h
    mov al, 03h
    int 10h
    ret
PosicionCursorCadena:
    mov ah, 02h
    mov bh, 00h
    int 10h
    ret
ImprimirCadena: ;SI contenido de la cadena
    mov ah, 09h
    mov dx, SI
    int 21h
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;