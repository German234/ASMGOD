; ========================================
; TIPS Y TÉCNICAS PARA MODO VIDEO
; Centrado y Posicionamiento
; ========================================

ORG 100h

SECTION .text

    ; Inicializar modo video
    CALL IniciarModoVideo
    
    ; Demostrar diferentes técnicas
    CALL DemostrarCentrado
    CALL DibujarGuiasPantalla
    CALL DibujarCuadriculaReferencia
    CALL DemostrarPosicionamiento
    
    ; Esperar tecla y terminar
    CALL EsperarTecla
    
    ; Volver a modo texto
    MOV AH, 00h
    MOV AL, 03h
    INT 10h
    
    INT 20h

; ========================================
; DATOS IMPORTANTES SOBRE LA PANTALLA
; ========================================
; Modo 12h: 640x480 píxeles, 16 colores
; Centro de pantalla: X=320, Y=240
; 
; Para centrar un objeto:
; X_inicial = 320 - (ancho_objeto / 2)
; Y_inicial = 240 - (alto_objeto / 2)
; ========================================

IniciarModoVideo:
    MOV AH, 00h
    MOV AL, 12h
    INT 10h
    RET

; ========================================
; TÉCNICA 1: Centrar un cuadrado
; ========================================
DemostrarCentrado:
    ; Cuadrado de 40x40 píxeles
    ; Centro: (320, 240)
    ; X inicial = 320 - 20 = 300
    ; Y inicial = 240 - 20 = 220
    
    MOV SI, 300     ; X inicial
    MOV DI, 220     ; Y inicial
    
CuadradoCentradoFila:
    MOV SI, 300
    
CuadradoCentradoCol:
    MOV AH, 0Ch
    MOV AL, 0Eh     ; Amarillo
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 340     ; 300 + 40
    JNE CuadradoCentradoCol
    
    INC DI
    CMP DI, 260     ; 220 + 40
    JNE CuadradoCentradoFila
    
    ; Marcar el centro exacto
    MOV AH, 0Ch
    MOV AL, 04h     ; Rojo
    MOV CX, 320
    MOV DX, 240
    INT 10h
    
    RET

; ========================================
; TÉCNICA 2: Líneas guía de pantalla
; ========================================
DibujarGuiasPantalla:
    ; Línea vertical central
    MOV SI, 320
    MOV DI, 0
    
GuiaVertical:
    MOV AH, 0Ch
    MOV AL, 03h     ; Cyan
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    ADD DI, 5       ; Línea punteada
    CMP DI, 480
    JB GuiaVertical
    
    ; Línea horizontal central
    MOV SI, 0
    MOV DI, 240
    
GuiaHorizontal:
    MOV AH, 0Ch
    MOV AL, 03h     ; Cyan
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    ADD SI, 5       ; Línea punteada
    CMP SI, 640
    JB GuiaHorizontal
    
    RET

; ========================================
; TÉCNICA 3: Cuadrícula de referencia
; ========================================
DibujarCuadriculaReferencia:
    ; Dibujar marcas cada 100 píxeles
    ; Verticales
    MOV SI, 100
    
CuadriculaVert:
    MOV DI, 0
    
CuadVertLinea:
    MOV AH, 0Ch
    MOV AL, 08h     ; Gris oscuro
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    ADD DI, 20      ; Línea muy punteada
    CMP DI, 480
    JB CuadVertLinea
    
    ADD SI, 100
    CMP SI, 640
    JB CuadriculaVert
    
    ; Horizontales
    MOV DI, 100
    
CuadriculaHoriz:
    MOV SI, 0
    
CuadHorizLinea:
    MOV AH, 0Ch
    MOV AL, 08h     ; Gris oscuro
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    ADD SI, 20      ; Línea muy punteada
    CMP SI, 640
    JB CuadHorizLinea
    
    ADD DI, 100
    CMP DI, 480
    JB CuadriculaHoriz
    
    RET

; ========================================
; TÉCNICA 4: Posicionamiento relativo
; ========================================
DemostrarPosicionamiento:
    ; Esquina superior izquierda
    CALL DibujarMarcador
    MOV SI, 10
    MOV DI, 10
    CALL DibujarPequenoCuadro
    
    ; Esquina superior derecha
    MOV SI, 620     ; 640 - 20
    MOV DI, 10
    CALL DibujarPequenoCuadro
    
    ; Esquina inferior izquierda
    MOV SI, 10
    MOV DI, 460     ; 480 - 20
    CALL DibujarPequenoCuadro
    
    ; Esquina inferior derecha
    MOV SI, 620
    MOV DI, 460
    CALL DibujarPequenoCuadro
    
    ; Punto medio superior
    MOV SI, 310     ; 320 - 10
    MOV DI, 10
    CALL DibujarPequenoCuadro
    
    ; Punto medio inferior
    MOV SI, 310
    MOV DI, 460
    CALL DibujarPequenoCuadro
    
    ; Punto medio izquierdo
    MOV SI, 10
    MOV DI, 230     ; 240 - 10
    CALL DibujarPequenoCuadro
    
    ; Punto medio derecho
    MOV SI, 620
    MOV DI, 230
    CALL DibujarPequenoCuadro
    
    RET

; ========================================
; Procedimiento auxiliar: Pequeño cuadro
; ========================================
DibujarPequenoCuadro:
    PUSH SI
    PUSH DI
    
    MOV BP, 20      ; Tamaño 20x20
    
PCuadroFila:
    MOV CX, 20
    PUSH SI
    
PCuadroCol:
    MOV AH, 0Ch
    MOV AL, 0Fh     ; Blanco
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP PCuadroCol
    
    POP SI
    INC DI
    DEC BP
    JNZ PCuadroFila
    
    POP DI
    POP SI
    RET

; ========================================
; Marcador de coordenadas
; ========================================
DibujarMarcador:
    ; Dibujar texto simulado con píxeles
    ; mostrando las coordenadas importantes
    RET

EsperarTecla:
    MOV AH, 00h
    INT 16h
    RET

; ========================================
; FÓRMULAS ÚTILES PARA CENTRAR:
; ========================================
; 1. CENTRAR HORIZONTALMENTE:
;    X_inicial = 320 - (ancho / 2)
;
; 2. CENTRAR VERTICALMENTE:
;    Y_inicial = 240 - (alto / 2)
;
; 3. CENTRAR EN CUADRANTE:
;    Cuadrante 1 (sup-izq): X=160, Y=120
;    Cuadrante 2 (sup-der): X=480, Y=120
;    Cuadrante 3 (inf-izq): X=160, Y=360
;    Cuadrante 4 (inf-der): X=480, Y=360
;
; 4. ALINEACIÓN:
;    Derecha: X = 640 - ancho - margen
;    Abajo: Y = 480 - alto - margen
;
; 5. ESPACIADO UNIFORME:
;    Si tienes N objetos de ancho W:
;    Espacio = (640 - (N * W)) / (N + 1)
;    X del objeto i = Espacio + i * (W + Espacio)
;
; 6. CÍRCULO CENTRADO:
;    Para un círculo de radio R:
;    X_centro = 320
;    Y_centro = 240
;    X_pixel = X_centro + R * cos(ángulo)
;    Y_pixel = Y_centro + R * sin(ángulo)
; ========================================

; ========================================
; EJEMPLO DE CÁLCULO PARA EL PARCIAL:
; ========================================
; Problema: Centrar un rectángulo de 80x60
; 
; Solución:
; X_inicial = 320 - (80 / 2) = 320 - 40 = 280
; Y_inicial = 240 - (60 / 2) = 240 - 30 = 210
; X_final = 280 + 80 = 360
; Y_final = 210 + 60 = 270
;
; Código:
; MOV SI, 280    ; X inicial
; MOV DI, 210    ; Y inicial
; ... (loop hasta SI=360, DI=270)
; ========================================