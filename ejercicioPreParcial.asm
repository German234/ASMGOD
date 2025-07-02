org 100h
section .data
    cadena db "1. Para ver fig"
    cadena2 db "2. Para salir"
    cadena3 db "S. Para regresar"
    cadena4 db "         Fin"

section .text
call pantallaGrafica
int 20h

pantallaTexto:
    call establecerModoTexto
    mov bh,01h
    mov al, 01h
    call CambiarPagina
    mov dh, 0Ah
    mov si,cadena
    mov di, 15d
    call escibirLinea
    inc dh
    mov si,cadena2
    mov di, 13d
    call escibirLinea
    inc dh
    mov si,cadena3
    mov di, 16d
    call escibirLinea
    bucleT:  
    mov ah, 00h
    int 16h
    cmp al,"1"
    je pantallaGrafica
    cmp al,"2"
    je pantallaFin
    cmp al, "S"
    je pantallaGrafica
    jmp bucleT
    ret

pantallaGrafica:
call activarModoGrafico
call pintarTriangulo
call rectangulo
bucleG:  
    mov ah, 00h
    int 16h
    cmp al,"S"
    je pantallaTexto
    cmp al,0Dh
    je pantallaFin
    jmp bucleG
    ret
pantallaFin:
    call establecerModoTexto
    mov bh, 02h
    mov al, 02h
    call CambiarPagina
    mov dh, 0Eh
    mov si,cadena4
    mov di, 12d
    call escibirLinea
    ret
activarModoGrafico:
    mov ah, 00h
    mov al, 12h
    int 10h 
    ret
pintarPixel:
    mov ah,0ch ;interrupcion
    mov al, 07h ;color
    mov bh, 00h ;pagina
    int 10h
    ret
pintarLinea:
    bucle:
    call pintarPixel
    cmp bp,bx
    je fin
    inc bp
    inc cx
    jmp bucle
    fin:
    ret
rectangulo:
    mov si, 0d
    mov dx, 128h ;fila
    mov bx, 150d
    BucleColumna:
        mov cx, 50h ;columna
        mov bp,00d
    call pintarLinea
    inc dx
    inc si
    cmp si,100d;
    je finFila
    jmp BucleColumna;
finFila:
    ret

pintarTriangulo:
    mov si, 0d
    mov dx, 128h ;fila
    mov bx, 150d
    BucleColumna2:
        mov cx, 128h ;columna
        mov bp,00d
    call pintarLinea
    dec bx
    dec dx
    inc si
    cmp si,150d;
    je finFila2
    jmp BucleColumna2;
finFila2:
    ret
establecerModoTexto:
        mov ah,00h
        mov al,03h
        int 10h
        ret
posicionamiento:
        mov ah, 02h
        int 10h
        ret
escribirTexto:
        mov ah,09h ;activar funcion 09h
        mov bl,7h
        mov cx, 01h ;repetir 
        int 10h
        ret
escibirLinea:
    mov dl, 20h ;columnas
    mov bp,01h
    bucleL:
    mov al,[si] ; caracter de la primera posicion de la cadena
    call posicionamiento
    call escribirTexto
    inc dl
    inc al
    cmp bp,di
    jge finL
    inc bp
    inc si
    jmp bucleL
    finL:
    ret
CambiarPagina: ;int 10h / 05h
    mov ah, 05h
    int 10h 
    ret 