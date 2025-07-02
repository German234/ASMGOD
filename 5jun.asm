org 100h
section .text
    mov dl, 00h
    mov dh, 00h
    call modo_texto

bucle:
    call pos_cursor
    call teclado
    call escribir_cadena
    inc dl ; Incrementamos la columna para la siguiente letra
    CMP AL, "Q" ;salir
    JE end
    jmp bucle
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