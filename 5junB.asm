org 100h
section .data
    cadena DB "Cristofer"; Tiene que terminar con 0
    color DB 0Fh,71h,72h,73h,74h,75h,76h,78h,79h,80h
section .text
    ; Mas o menos centrado
    mov dl, 00h ; pos cursor col
    mov dh, 00h
    call modo_texto
    mov si, 0d ; Inicializamos SI para recorrer la cadena

bucle:
    call pos_cursor
    call teclado
    call escribir_cadena
    inc dl ; Incrementamos la columna para la siguiente letra
    inc si ; Incrementamos SI para el color
    call reinicio

    CMP AL, "Q" ;shift derecho
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
    mov bl, [color+si]
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
    int 16h          ; Espera a que se pulse una tecla
    ret

reinicio:
    cmp si, 10d
    jb noreinicio
    MOV SI, 0d
    ret
noreinicio:
    ret