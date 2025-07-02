org 100h
section .data
    cadena DB 'Cristofer Diaz$'
section .text
    ; Mas o menos centrado
    mov dl, 25h ; pos cursor col
    mov dh, 0bh
    call modo_texto

bucle:
    call pos_cursor
    call escribir_cadena
end: 
    int 20h

modo_texto:
    mov ah, 00h
    mov al, 03h
    int 10h
    ret

escribir_cadena:
    mov ah, 09h
    mov dx, cadena
    int 21h
    ret

pos_cursor:
    mov ah, 02h
    mov bh, 00h
    int 10h
    ret