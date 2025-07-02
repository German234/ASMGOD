; ========================================
; DIBUJO DE HELLO KITTY (ROSTRO)
; Formato COM - Ensamblador 8086
; ========================================

ORG 100h

SECTION .text

    ; Inicializar modo video
    CALL IniciarModoVideo
    
    ; Dibujar Hello Kitty centrada
    CALL DibujarHelloKitty
    
    ; Esperar tecla y terminar
    CALL EsperarTecla
    
    ; Volver a modo texto
    MOV AH, 00h
    MOV AL, 03h
    INT 10h
    
    INT 20h

IniciarModoVideo:
    MOV AH, 00h
    MOV AL, 12h     ; Modo 12h (640x480, 16 colores)
    INT 10h
    RET

; ========================================
; PROCEDIMIENTO: Dibujar Hello Kitty
; ========================================
DibujarHelloKitty:
    ; La cabeza está centrada en (320, 240)
    ; Tamaño aproximado: 120x100 píxeles
    
    ; ===== CABEZA (forma ovalada) =====
    ; Parte superior de la cabeza
    MOV SI, 260     ; X inicial (320 - 60)
    MOV DI, 190     ; Y inicial (240 - 50)
    
CabezaSuperior:
    MOV SI, 260
    ADD SI, 10      ; Hacer forma redondeada
    
    ; Ajustar ancho según la fila
    MOV AX, DI
    SUB AX, 190
    CMP AX, 20
    JB AjustarAnchoSup
    MOV BX, 100     ; Ancho máximo
    JMP DibujarFilaCabeza
    
AjustarAnchoSup:
    ; Reducir ancho en la parte superior
    MOV BX, 100
    SUB BX, AX
    SUB BX, AX
    
DibujarFilaCabeza:
    MOV CX, BX      ; Ancho de la línea
    PUSH SI
    
LineaCabeza:
    MOV AH, 0Ch
    MOV AL, 0Fh     ; Blanco
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP LineaCabeza
    
    POP SI
    INC DI
    CMP DI, 290     ; Altura total de 100
    JNE CabezaSuperior
    
    ; ===== OREJAS (triángulos) =====
    ; Oreja izquierda
    MOV SI, 250     ; X inicial
    MOV DI, 200     ; Y inicial
    MOV BP, 0       ; Contador
    
OrejaIzquierda:
    PUSH SI
    PUSH BP
    
    ; Calcular posición y ancho
    MOV AX, BP
    ADD SI, AX      ; Desplazar derecha
    
    MOV BX, 25      ; Ancho base
    SUB BX, BP
    
    CMP BX, 0
    JLE OrejaIzqFin
    
    MOV CX, BX
OrejaIzqLinea:
    MOV AH, 0Ch
    MOV AL, 0Fh     ; Blanco
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP OrejaIzqLinea
    
    POP BP
    POP SI
    
    DEC DI
    INC BP
    CMP BP, 25
    JNE OrejaIzquierda
    
OrejaIzqFin:
    ; Oreja derecha
    MOV SI, 365     ; X inicial
    MOV DI, 200     ; Y inicial
    MOV BP, 0
    
OrejaDerecha:
    PUSH SI
    PUSH BP
    
    MOV BX, 25
    SUB BX, BP
    
    CMP BX, 0
    JLE OrejaDerFin
    
    MOV CX, BX
OrejaDerLinea:
    MOV AH, 0Ch
    MOV AL, 0Fh
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP OrejaDerLinea
    
    POP BP
    POP SI
    
    DEC DI
    INC BP
    CMP BP, 25
    JNE OrejaDerecha
    
OrejaDerFin:
    ; ===== OJOS (óvalos negros) =====
    ; Ojo izquierdo
    MOV SI, 290     ; X inicial
    MOV DI, 230     ; Y inicial
    
OjoIzqFila:
    MOV CX, 8       ; Ancho
    MOV SI, 290
    
OjoIzqCol:
    MOV AH, 0Ch
    MOV AL, 00h     ; Negro
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP OjoIzqCol
    
    INC DI
    CMP DI, 245     ; Alto de 15
    JNE OjoIzqFila
    
    ; Ojo derecho
    MOV SI, 342     ; X inicial
    MOV DI, 230     ; Y inicial
    
OjoDerFila:
    MOV CX, 8
    MOV SI, 342
    
OjoDerCol:
    MOV AH, 0Ch
    MOV AL, 00h     ; Negro
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP OjoDerCol
    
    INC DI
    CMP DI, 245
    JNE OjoDerFila
    
    ; ===== NARIZ (óvalo amarillo) =====
    MOV SI, 315     ; X inicial
    MOV DI, 250     ; Y inicial
    
NarizFila:
    MOV CX, 10      ; Ancho
    MOV SI, 315
    
NarizCol:
    MOV AH, 0Ch
    MOV AL, 0Eh     ; Amarillo
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP NarizCol
    
    INC DI
    CMP DI, 256     ; Alto de 6
    JNE NarizFila
    
    ; ===== MOÑO (en oreja derecha) =====
    ; Centro del moño
    MOV SI, 370     ; X inicial
    MOV DI, 195     ; Y inicial
    
MonoCentroFila:
    MOV CX, 20      ; Ancho
    MOV SI, 370
    
MonoCentroCol:
    MOV AH, 0Ch
    MOV AL, 0Ch     ; Rojo claro/Rosa
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP MonoCentroCol
    
    INC DI
    CMP DI, 205     ; Alto de 10
    JNE MonoCentroFila
    
    ; Lado izquierdo del moño
    MOV SI, 355
    MOV DI, 190
    
MonoIzqFila:
    MOV CX, 15
    MOV SI, 355
    
MonoIzqCol:
    MOV AH, 0Ch
    MOV AL, 0Ch
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP MonoIzqCol
    
    INC DI
    CMP DI, 210
    JNE MonoIzqFila
    
    ; Lado derecho del moño
    MOV SI, 390
    MOV DI, 190
    
MonoDerFila:
    MOV CX, 15
    MOV SI, 390
    
MonoDerCol:
    MOV AH, 0Ch
    MOV AL, 0Ch
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP MonoDerCol
    
    INC DI
    CMP DI, 210
    JNE MonoDerFila
    
    ; ===== BIGOTES =====
    ; Bigote izquierdo superior
    MOV SI, 250
    MOV DI, 240
    MOV CX, 30
    
BigoteIzqSup:
    MOV AH, 0Ch
    MOV AL, 00h     ; Negro
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    DEC DI          ; Diagonal hacia arriba
    LOOP BigoteIzqSup
    
    ; Bigote izquierdo inferior
    MOV SI, 250
    MOV DI, 250
    MOV CX, 30
    
BigoteIzqInf:
    MOV AH, 0Ch
    MOV AL, 00h
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    INC DI          ; Diagonal hacia abajo
    LOOP BigoteIzqInf
    
    ; Bigote derecho superior
    MOV SI, 390
    MOV DI, 240
    MOV CX, 30
    
BigoteDerSup:
    MOV AH, 0Ch
    MOV AL, 00h
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    DEC DI
    LOOP BigoteDerSup
    
    ; Bigote derecho inferior
    MOV SI, 390
    MOV DI, 250
    MOV CX, 30
    
BigoteDerInf:
    MOV AH, 0Ch
    MOV AL, 00h
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    INC DI
    LOOP BigoteDerInf
    
    RET

EsperarTecla:
    MOV AH, 00h
    INT 16h
    RET

; ========================================
; COORDENADAS IMPORTANTES DE HELLO KITTY:
; ========================================
; Centro de pantalla: (320, 240)
; Cabeza: 260-380 X, 190-290 Y
; Ojos: (290, 230) y (342, 230)
; Nariz: (315, 250)
; Moño: (370, 195) centro
; Orejas: Triángulos en (250, 200) y (365, 200)
;
; Para mover Hello Kitty:
; - Suma/resta a todas las coordenadas X para mover horizontalmente
; - Suma/resta a todas las coordenadas Y para mover verticalmente
; ========================================