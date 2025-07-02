org 100h
section .text
    mov dl, 01h
    mov dh, 00h
    mov si, 0d
    call modo_texto

bucle:
    call pos_cursor
    call teclado
    call interfaz
    call escribir_cadena
    inc dl ; Incrementamos la columna para la siguiente letra
    jmp bucle

interfaz:
    CMP AL, 13 ;ENTER
    JE saltarFila ; Saltar fila
    CMP AL, 27 ;ESC
    JE end ; Salir
    CMP AL, 08 ;BACKSPACE
    JE borrar ; Borrar caracter
    CMP AL, "N" ;
    JE cambiarPaginaUno ; Cambiar de pagina 1
    CMP AL, "M" ;
    JE cambiarPaginaDos ; Cambiar de pagina 1
    RET

saltarFila:
    inc dh
    MOV dl, 00h
    call pos_cursor
    MOV AL, ""
    RET

borrar:
    dec dl
    MOV AL, ""
    CALL pos_cursor
    RET

cambiarPaginaDos:
    INC bh
    MOV AL, ""
    RET

cambiarPaginaUno:
    DEC bh
    MOV AL, ""
    RET

end:
    int 20h

modo_texto:
    mov ah, 00h
    mov al, 03h
    int 10h
    ret

escribir_cadena:
    mov ah, 09h
    mov bl, 0fh ; Color de fondo blanco
    mov bh, 00h
    mov cx, 1h
    int 10h
    ret

pos_cursor:
    mov ah, 02h
    mov bh, 00h
    int 10h
    ret

teclado:
    mov ah, 00h
    int 16h
    ret
    
    