; ========================================
; FIGURAS Y DIBUJOS EN MODO VIDEO
; Formato COM - Ensamblador 8086
; ========================================

ORG 100h

SECTION .text

    ; Inicializar modo video
    CALL IniciarModoVideo
    
    ; Dibujar diferentes figuras
    CALL DibujarPixel
    CALL DibujarLineaHorizontal
    CALL DibujarLineaVertical
    CALL DibujarRectangulo
    CALL DibujarRectanguloRelleno
    CALL DibujarTriangulo
    CALL DibujarCuadrado
    CALL DibujarCasa
    
    ; Esperar tecla y terminar
    CALL EsperarTecla
    
    ; Volver a modo texto
    MOV AH, 00h
    MOV AL, 03h
    INT 10h
    
    INT 20h     ; Terminar programa

; ========================================
; PROCEDIMIENTO: Iniciar modo video
; ========================================
IniciarModoVideo:
    MOV AH, 00h
    MOV AL, 12h     ; Modo 12h (640x480, 16 colores)
    INT 10h
    RET

; ========================================
; PROCEDIMIENTO: Dibujar un pixel
; ========================================
DibujarPixel:
    MOV AH, 0Ch     ; Función dibujar pixel
    MOV AL, 0Fh     ; Color blanco
    MOV BH, 0       ; Página 0
    MOV CX, 100     ; Columna
    MOV DX, 50      ; Fila
    INT 10h
    RET

; ========================================
; PROCEDIMIENTO: Línea horizontal
; ========================================
DibujarLineaHorizontal:
    MOV SI, 50      ; Columna inicial
    MOV DI, 100     ; Fila
    
LineaH_Loop:
    MOV AH, 0Ch
    MOV AL, 02h     ; Color verde
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 200     ; Longitud de 150 píxeles
    JNE LineaH_Loop
    RET

; ========================================
; PROCEDIMIENTO: Línea vertical
; ========================================
DibujarLineaVertical:
    MOV SI, 250     ; Columna
    MOV DI, 50      ; Fila inicial
    
LineaV_Loop:
    MOV AH, 0Ch
    MOV AL, 03h     ; Color cyan
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC DI
    CMP DI, 150     ; Altura de 100 píxeles
    JNE LineaV_Loop
    RET

; ========================================
; PROCEDIMIENTO: Rectángulo (solo bordes)
; ========================================
DibujarRectangulo:
    ; Línea superior
    MOV SI, 300     ; Columna inicial
    MOV DI, 50      ; Fila
RectTop:
    MOV AH, 0Ch
    MOV AL, 0Eh     ; Color amarillo
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    INC SI
    CMP SI, 400
    JNE RectTop
    
    ; Línea inferior
    MOV SI, 300
    MOV DI, 150
RectBottom:
    MOV AH, 0Ch
    MOV AL, 0Eh
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    INC SI
    CMP SI, 400
    JNE RectBottom
    
    ; Línea izquierda
    MOV SI, 300
    MOV DI, 50
RectLeft:
    MOV AH, 0Ch
    MOV AL, 0Eh
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    INC DI
    CMP DI, 150
    JNE RectLeft
    
    ; Línea derecha
    MOV SI, 399
    MOV DI, 50
RectRight:
    MOV AH, 0Ch
    MOV AL, 0Eh
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    INC DI
    CMP DI, 150
    JNE RectRight
    
    RET

; ========================================
; PROCEDIMIENTO: Rectángulo relleno
; ========================================
DibujarRectanguloRelleno:
    MOV SI, 450     ; Columna inicial
    MOV DI, 50      ; Fila inicial
    
RectRellenoFila:
    MOV SI, 450     ; Reiniciar columna
    
RectRellenoCol:
    MOV AH, 0Ch
    MOV AL, 05h     ; Color magenta
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 550     ; Ancho de 100
    JNE RectRellenoCol
    
    INC DI
    CMP DI, 120     ; Alto de 70
    JNE RectRellenoFila
    
    RET

; ========================================
; PROCEDIMIENTO: Triángulo
; ========================================
DibujarTriangulo:
    MOV SI, 100     ; Columna base
    MOV DI, 250     ; Fila base
    MOV BP, 0       ; Contador para altura
    
TrianguloLoop:
    PUSH SI         ; Guardar columna inicial
    PUSH BP         ; Guardar contador
    
    ; Calcular columna inicial para centrar
    MOV AX, BP
    ADD SI, AX      ; Desplazar a la derecha
    
    ; Calcular ancho de la línea
    MOV AX, BP
    SHL AX, 1       ; Multiplicar por 2
    MOV BX, 60      ; Ancho base
    SUB BX, AX      ; Reducir ancho
    
    CMP BX, 0
    JLE TrianguloFin
    
TrianguloLinea:
    MOV AH, 0Ch
    MOV AL, 0Ch     ; Color rojo claro
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    DEC BX
    JNZ TrianguloLinea
    
    POP BP
    POP SI
    
    DEC DI          ; Subir una fila
    INC BP          ; Incrementar contador
    CMP BP, 30      ; Altura del triángulo
    JNE TrianguloLoop
    
TrianguloFin:
    RET

; ========================================
; PROCEDIMIENTO: Cuadrado
; ========================================
DibujarCuadrado:
    MOV SI, 300     ; Columna inicial
    MOV DI, 200     ; Fila inicial
    
CuadradoFila:
    MOV SI, 300     ; Reiniciar columna
    
CuadradoCol:
    MOV AH, 0Ch
    MOV AL, 09h     ; Color azul claro
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 360     ; Lado de 60 píxeles
    JNE CuadradoCol
    
    INC DI
    CMP DI, 260     ; Lado de 60 píxeles
    JNE CuadradoFila
    
    RET

; ========================================
; PROCEDIMIENTO: Casa simple
; ========================================
DibujarCasa:
    ; Base de la casa (rectángulo)
    MOV SI, 400     ; Columna inicial
    MOV DI, 300     ; Fila inicial
    
CasaBaseFila:
    MOV SI, 400     ; Reiniciar columna
    
CasaBaseCol:
    MOV AH, 0Ch
    MOV AL, 06h     ; Color marrón
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 480     ; Ancho de 80
    JNE CasaBaseCol
    
    INC DI
    CMP DI, 360     ; Alto de 60
    JNE CasaBaseFila
    
    ; Techo (triángulo)
    MOV SI, 380     ; Columna inicial (más a la izquierda)
    MOV DI, 300     ; Fila inicial
    MOV BP, 0       ; Contador
    
TechoLoop:
    PUSH SI
    PUSH BP
    
    ; Ajustar posición inicial
    MOV AX, BP
    ADD SI, AX
    
    ; Calcular ancho
    MOV AX, BP
    SHL AX, 1
    MOV BX, 120     ; Ancho base del techo
    SUB BX, AX
    
    CMP BX, 0
    JLE TechoFin
    
TechoLinea:
    MOV AH, 0Ch
    MOV AL, 04h     ; Color rojo
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    DEC BX
    JNZ TechoLinea
    
    POP BP
    POP SI
    
    DEC DI
    INC BP
    CMP BP, 40      ; Altura del techo
    JNE TechoLoop
    
TechoFin:
    ; Puerta
    MOV SI, 430     ; Columna inicial
    MOV DI, 330     ; Fila inicial
    
PuertaFila:
    MOV SI, 430
    
PuertaCol:
    MOV AH, 0Ch
    MOV AL, 08h     ; Color gris oscuro
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 450     ; Ancho de 20
    JNE PuertaCol
    
    INC DI
    CMP DI, 360     ; Hasta el piso
    JNE PuertaFila
    
    ; Ventana
    MOV SI, 410     ; Columna inicial
    MOV DI, 310     ; Fila inicial
    
VentanaFila:
    MOV SI, 410
    
VentanaCol:
    MOV AH, 0Ch
    MOV AL, 0Bh     ; Color cyan claro
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 425     ; Ancho de 15
    JNE VentanaCol
    
    INC DI
    CMP DI, 325     ; Alto de 15
    JNE VentanaFila
    
    RET

; ========================================
; PROCEDIMIENTO: Esperar tecla
; ========================================
EsperarTecla:
    MOV AH, 00h
    INT 16h
    RET

; ========================================
; COLORES EN MODO 12h (640x480, 16 colores):
; 00h = Negro        08h = Gris oscuro
; 01h = Azul         09h = Azul claro
; 02h = Verde        0Ah = Verde claro
; 03h = Cyan         0Bh = Cyan claro
; 04h = Rojo         0Ch = Rojo claro
; 05h = Magenta      0Dh = Magenta claro
; 06h = Marrón       0Eh = Amarillo
; 07h = Gris claro   0Fh = Blanco
; ========================================

; ========================================
; TIPS PARA EL PARCIAL:
; 1. Siempre usar INT 10h con AH=0Ch para dibujar píxeles
; 2. CX = columna (X), DX = fila (Y)
; 3. AL = color, BH = página (generalmente 0)
; 4. Para figuras complejas, usar loops anidados
; 5. Guardar registros importantes con PUSH/POP
; ========================================