;../nasm.exe -f bin ./tarea.asm -o a.com
;../dosbox.exe .

org 100h
section .data
    cadena DB "Cristofer$"
    color DB 01h,02h,03h,04h,05h,06h,08h,09h,0Ah,0Bh,0Ch,0Dh,0Eh,0Fh
section .text
    ; Mas o menos centrado
    mov dl, 25h ; pos cursor col
    mov dh, 0bh ; pos cursor fila
    call modo_texto
    mov si, 0d ; Inicializamos SI para recorrer la cadena

bucle:
    call pos_cursor
    mov al, [cadena+SI]
    CMP al, "$"
    je end ; Si encontramos el carácter de fin de cadena, saltamos al final
    call escribir_cadena
    inc si ; Incrementamos SI para la siguiente letra
    inc dl ; Incrementamos la columna para la siguiente letra
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
    ;mov dx, cadena con int 21h
    int 10h
    ret

pos_cursor:
    mov ah, 02h
    mov bh, 00h
    int 10h
    ret
