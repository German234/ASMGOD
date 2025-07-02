; ---------------------------------Modo grafico---------------------------------
org 100h

section .data
    msgOpcionUno db '1. Para ver figura$'
    msgOpcionDos db '2. Para salir$'
    msgSalir db 'S. Para regresar$'
    msgFin db 'Fin!!!$'

section .text

menu:    
    call initModoTexto
    mov dh, 10d
    call posCursor
    mov dx, msgOpcionUno
    call imprimirMsg

    mov dh, 11d
    call posCursor
    mov dx, msgOpcionDos
    call imprimirMsg

    mov dh, 12d
    call posCursor
    mov dx, msgSalir
    call imprimirMsg
    
    CALL detectar_teclado
    cmp al, 49d
    je figuras
    cmp al, 50d
    je salir
    jmp menu

salir:
    int 20h

figuras:  
    CALL modoVideo
    mov al, 1
    CALL cambiarPagina

    MOV word[0200h], 91d ; incrementador
    MOV word[220h], 90d ; Columna inicial
    MOV word[210h], 180d ; Fila tope
    MOV SI, word[220h] 
    MOV DI, 10d ; Fila inicial

    CALL DibujarTriangulo

    MOV word[0200h], 340d ; col inicial
    MOV word[220h], 440d ; col tope
    MOV word[210h], 460d ; fila tope
    MOV SI, word[0200h]
    MOV DI, 180d ; Fila inicial

    CALL DibujarRectangulo
    CALL esperarTecla

    mov al, 0
    CALL cambiarPagina
end:    
    jmp menu

imprimirMsg:
    ; Antes de llamarla, mover msg a dx
    mov ah, 09h
    int 21h
    ret

posCursor:
    xor bx,bx
    xor ax,ax
    xor cx,cx

    mov ah, 02h
    mov dl, 30d ;col
    ;mov dh, 12d ;fila
    int 10h
    xor dx,dx
    ret

detectar_teclado:
    mov ah, 00
    int 16h
    ret

esperarTecla:
    mov ah, 00h
    int 16h   
    cmp al, 'S'
    jne esperarTecla
    ret   

initModoTexto:
    mov ah, 00h
    mov al, 03h; 80x25
    int 10h
    ret        
;--------------------- Funcion para imprimir un Rectangulo ---------------------; 
DibujarRectangulo:
    ;Iniciar modo video antes
    ;colocar en [200h] col inicio
    ;colocar en [210h] la fila limite
    ;colocar en [220h] la col limite
  MOV AH, 0Ch           ; Función del BIOS para poner un píxel
  MOV AL, 01h           ; Color del píxel 
  MOV BH, 1             ; Página de video 0
  MOV CX, SI            ; Coordenada X
  MOV DX, DI            ; Coordenada Y
  INT 10h               ; Enciende el píxel    

  INC SI                ; Incrementa la columna
  CMP SI, [220h]        ; Compara la columna actual con el límite
  JNE DibujarRectangulo ; Continúa en la misma fila si no se alcanza el límite

  ; Al alcanzar el límite de la fila, prepara la siguiente fila
  INC DI                ; Incrementa la fila
  MOV SI, [200h]        ; Reinicia la columna al inicio para la nueva fila

  CMP DI, [210h]        ; Compara la fila actual con el límite de
  JNE DibujarRectangulo ; Si no se alcanza el límite, continúa dibujando la fila
  RET                   ; Termina la función cuando el rectángulo está completo

;--------------------- Funcion para imprimir un triangulo ---------------------; 
DibujarTriangulo:
    ;Iniciar modo video antes  
    ;Colocar en [200h] el incrementador
    ;colocar en [210h] la fila limite
    ;colocar en [220h] la col limite
  MOV AH, 0Ch           ; Función del BIOS para poner un píxel
  MOV AL, 01h           ; Color del píxel 
  MOV BH, 1             ; Página de video 0
  MOV CX, SI            ; Coordenada X
  MOV DX, DI            ; Coordenada Y
  INT 10h               ; Enciende el píxel    

  INC SI                ; Incrementa la columna
  CMP SI, [0200h]          ; Compara la columna actual con el límite
  JNE DibujarTriangulo ; Continúa en la misma fila si no se alcanza el límite

  ; Al alcanzar el límite de la fila, prepara la siguiente fila
  INC DI
  INC word[0200h]       ; Incrementa la fila
  MOV SI, [220h]           ; Reinicia la columna al inicio para la nueva fila

  CMP DI, [210h]          ; Compara la fila actual con el límite
  JNE DibujarTriangulo ; Si no se alcanza el límite, continúa dibujando la fila
  RET                   ; Termina la función cuando el rectángulo está completo


modoVideo:
    MOV AH, 00H
    MOV AL, 12H
    INT 10H
    RET

cambiarPagina:
    mov ah, 05h
    ; conf numero de pagina con al
    int 10h    
    ret