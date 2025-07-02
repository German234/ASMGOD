org 100h
section .data
    cadena DB "Cristofer"; Tiene que terminar con 0
    color DB 70h,71h,72h,73h,74h,75h,76h,78h,79h,80h,81h,82h,83h,84h
section .text
    ; Mas o menos centrado
    mov dl, 25h ; pos cursor col
    mov dh, 0bh
    call modo_texto
    mov si, 0d ; Inicializamos SI para recorrer la cadena

bucle:
    call pos_cursor
    mov al, [cadena+SI]
    call escribir_cadena
    inc si ; Incrementamos SI para la siguiente letra
    inc dl ; Incrementamos la columna para la siguiente letra
    CMP si,9
    jb bucle
end: 
    int 20h

modo_texto:
    mov ah, 00h
    mov al, 03h
    int 10h
    ret

escribir_cadena:
    mov ah, 09h
    mov bl, [color+si]
    mov bh, 00h
    mov cx, 1h
    ;mov dx, cadena con int 21h
    int 10h
    ret

pos_cursor:
    mov ah, 02h
    mov bh, 00h
    int 10h
    ret