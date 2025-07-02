ORG 100h

SECTION .data
    msgmenu db "MENU:$"
    msg01   db "1. Para ver fig 1$"
    msg02   db "2. Para salir$"
    msg03   db "S. Para regresar al menu$"
    fin     db "Fin$"

SECTION .text
Main:
    call Menu
    INT 20h                 ; Termina programa

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Menu:
    ; --- Texto en página 1 ---
    call ModoTexto          ; AH=00h/AL=03h → modo texto 80×25
    mov al, 1
    call CambiarPagina      ; INT 10h AH=05h → activa página 1

    ; Imprime las líneas del menú
    mov dl, 25h             ; columna 25
    mov dh, 05h             ; fila 5
    mov bh, 1          ; página 1
    call PosicionCursorCadena
    mov si, msgmenu
    call ImprimirCadena

    mov dl, 25h
    mov dh, 06h
    mov bh, 1          ; página 1
    call PosicionCursorCadena
    mov si, msg01
    call ImprimirCadena

    mov dl, 25h
    mov dh, 07h
    mov bh, 1          ; página 1
    call PosicionCursorCadena
    mov si, msg02
    call ImprimirCadena

    mov dl, 25h
    mov dh, 08h
    mov bh, 1          ; página 1
    call PosicionCursorCadena
    mov si, msg03
    call ImprimirCadena

    call BucleTecladoOpciones
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PaginaUno:
    ; --- Texto en página 2 ---
    call ModoTexto
    mov al, 2
    call CambiarPagina

    mov dl, 25h
    mov dh, 05h
    mov bh, 2          ; página 2
    call PosicionCursorCadena
    mov si, msgmenu
    call ImprimirCadena

    call BucleTecladoOpciones
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PaginaDos:
    ; --- Texto en página 3 ---
    call ModoTexto
    mov al, 3
    call CambiarPagina
    mov bh, 3          ; página 3
    mov dl, 25h
    mov dh, 05h
    call PosicionCursorCadena
    mov si, msg02
    call ImprimirCadena

    call FinaldelPrograma
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FinaldelPrograma:
    INT 20h
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BucleTecladoOpciones:
    call ModoTeclado        ; AH=00h INT 16h → espera tecla
    cmp al, "1"
    je PaginaUno
    cmp al, "2"
    je PaginaDos
    cmp al, "S"
    je Menu
    jmp BucleTecladoOpciones
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Rutinas BIOS / DOS

ModoTeclado:                ; Lee una tecla
    mov ah, 00h
    int 16h
    ret

ModoTexto:                  ; Modo texto 80×25
    mov ah, 00h
    mov al, 03h
    int 10h
    ret

PosicionCursorCadena:       ; DL=columna, DH=fila, BH=página (0)
    mov ah, 02h
    
    int 10h
    ret

ImprimirCadena:             ; DS:SI apunta a "texto$", usa AH=09h
    mov ah, 09h
    mov dx, si
    int 21h
    ret

CambiarPagina:              ; AL = página deseada
    mov ah, 05h
    int 10h
    ret
