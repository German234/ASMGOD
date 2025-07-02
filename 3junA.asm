org 100h
section .data
    cadenauno DB 'Cristofer Diaz$'
    cadenados DB "Hola$"
    cadenatres DB "ADIOS$"
    prueba DB "XD$"
section .text
    
menu:
    call modo_texto
    mov dl, 25h ; pos cursor columna
    mov dh, 01h ; pos curso fila
    call pos_cursor
    MOV SI, cadenauno
    call escribir_cadena
    mov dl, 25h ; pos cursor columna
    mov dh, 02h ; pos curso fila
    call pos_cursor
    MOV SI, cadenados
    call escribir_cadena
    mov dl, 25h ; pos cursor columna
    mov dh, 03h ; pos curso fila
    call pos_cursor
    MOV SI, cadenatres
    call escribir_cadena
    mov dl, 25h ; pos cursor columna
    mov dh, 03h ; pos curso fila
    call pos_cursor
    MOV SI, cadenatres
    call escribir_cadena
    int 20h

modo_texto:
    mov ah, 00h
    mov al, 03h
    int 10h
    ret

escribir_cadena:
    mov ah, 09h
    mov dx, SI
    int 21h
    ret

pos_cursor:
    mov ah, 02h
    mov bh, 00h
    int 10h
    ret