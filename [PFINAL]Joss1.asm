; ========================================
; DIBUJOS DE ANIMALES Y MÁS FIGURAS
; Formato COM - Ensamblador 8086
; ========================================

ORG 100h

SECTION .text

    ; Inicializar modo video
    CALL IniciarModoVideo
    
    ; Dibujar diferentes figuras y animales
    CALL DibujarGato
    CALL DibujarCerdo
    CALL DibujarPerro
    CALL DibujarArbol
    CALL DibujarSol
    CALL DibujarNube
    CALL DibujarCoche
    CALL DibujarFlor
    
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
; PROCEDIMIENTO: Dibujar Gato
; ========================================
DibujarGato:
    ; Cuerpo del gato (rectángulo redondeado)
    MOV SI, 50      ; Columna inicial
    MOV DI, 100     ; Fila inicial
    
GatoCuerpoFila:
    MOV SI, 50      ; Reiniciar columna
    
GatoCuerpoCol:
    MOV AH, 0Ch
    MOV AL, 08h     ; Color gris
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 110     ; Ancho de 60
    JNE GatoCuerpoCol
    
    INC DI
    CMP DI, 140     ; Alto de 40
    JNE GatoCuerpoFila
    
    ; Cabeza del gato (círculo aproximado)
    MOV SI, 70      ; Columna inicial
    MOV DI, 80      ; Fila inicial
    
GatoCabezaFila:
    MOV SI, 70      ; Reiniciar columna
    
GatoCabezaCol:
    MOV AH, 0Ch
    MOV AL, 08h     ; Color gris
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 90      ; Ancho de 20
    JNE GatoCabezaCol
    
    INC DI
    CMP DI, 100     ; Alto de 20
    JNE GatoCabezaFila
    
    ; Orejas del gato (triángulos)
    ; Oreja izquierda
    MOV SI, 65
    MOV DI, 80
    MOV BP, 0
    
OrejaIzqLoop:
    PUSH SI
    PUSH BP
    
    MOV AX, BP
    ADD SI, AX
    
    MOV BX, 10
    SUB BX, BP
    
    CMP BX, 0
    JLE OrejaIzqFin
    
OrejaIzqLinea:
    MOV AH, 0Ch
    MOV AL, 08h
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    DEC BX
    JNZ OrejaIzqLinea
    
    POP BP
    POP SI
    
    DEC DI
    INC BP
    CMP BP, 10
    JNE OrejaIzqLoop
    
OrejaIzqFin:
    ; Oreja derecha
    MOV SI, 85
    MOV DI, 80
    MOV BP, 0
    
OrejaDerLoop:
    PUSH SI
    PUSH BP
    
    MOV BX, 10
    SUB BX, BP
    
    CMP BX, 0
    JLE OrejaDerFin
    
OrejaDerLinea:
    MOV AH, 0Ch
    MOV AL, 08h
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    DEC BX
    JNZ OrejaDerLinea
    
    POP BP
    POP SI
    
    DEC DI
    INC BP
    CMP BP, 10
    JNE OrejaDerLoop
    
OrejaDerFin:
    ; Ojos del gato
    MOV AH, 0Ch
    MOV AL, 0Ah     ; Verde claro para ojos
    MOV BH, 0
    MOV CX, 75      ; Ojo izquierdo
    MOV DX, 85
    INT 10h
    
    MOV CX, 85      ; Ojo derecho
    INT 10h
    
    ; Cola del gato
    MOV SI, 110     ; Columna inicial
    MOV DI, 120     ; Fila inicial
    
GatoColaLoop:
    MOV AH, 0Ch
    MOV AL, 08h
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    DEC DI
    CMP SI, 130
    JNE GatoColaLoop
    
    RET

; ========================================
; PROCEDIMIENTO: Dibujar Cerdo
; ========================================
DibujarCerdo:
    ; Cuerpo del cerdo (elipse horizontal)
    MOV SI, 200     ; Columna inicial
    MOV DI, 100     ; Fila inicial
    
CerdoCuerpoFila:
    MOV SI, 200     ; Reiniciar columna
    
CerdoCuerpoCol:
    MOV AH, 0Ch
    MOV AL, 0Dh     ; Color rosa (magenta claro)
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 280     ; Ancho de 80
    JNE CerdoCuerpoCol
    
    INC DI
    CMP DI, 150     ; Alto de 50
    JNE CerdoCuerpoFila
    
    ; Cabeza del cerdo
    MOV SI, 180     ; Columna inicial
    MOV DI, 110     ; Fila inicial
    
CerdoCabezaFila:
    MOV SI, 180
    
CerdoCabezaCol:
    MOV AH, 0Ch
    MOV AL, 0Dh     ; Rosa
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 210     ; Ancho de 30
    JNE CerdoCabezaCol
    
    INC DI
    CMP DI, 130     ; Alto de 20
    JNE CerdoCabezaFila
    
    ; Hocico
    MOV SI, 175     ; Columna inicial
    MOV DI, 118     ; Fila inicial
    
CerdoHocicoFila:
    MOV SI, 175
    
CerdoHocicoCol:
    MOV AH, 0Ch
    MOV AL, 0Ch     ; Rojo claro
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 185     ; Ancho de 10
    JNE CerdoHocicoCol
    
    INC DI
    CMP DI, 123     ; Alto de 5
    JNE CerdoHocicoFila
    
    ; Ojos
    MOV AH, 0Ch
    MOV AL, 00h     ; Negro
    MOV BH, 0
    MOV CX, 190     ; Ojo izquierdo
    MOV DX, 115
    INT 10h
    
    MOV CX, 200     ; Ojo derecho
    INT 10h
    
    ; Patas (4 rectángulos pequeños)
    ; Pata delantera izquierda
    MOV SI, 210
    MOV DI, 150
    CALL DibujarPata
    
    ; Pata delantera derecha
    MOV SI, 225
    MOV DI, 150
    CALL DibujarPata
    
    ; Pata trasera izquierda
    MOV SI, 250
    MOV DI, 150
    CALL DibujarPata
    
    ; Pata trasera derecha
    MOV SI, 265
    MOV DI, 150
    CALL DibujarPata
    
    ; Cola rizada
    MOV SI, 280
    MOV DI, 120
    MOV CX, 10      ; Número de píxeles
    
CerdoColaLoop:
    MOV AH, 0Ch
    MOV AL, 0Dh
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    DEC DI
    LOOP CerdoColaLoop
    
    RET

; ========================================
; PROCEDIMIENTO: Dibujar Pata (auxiliar)
; ========================================
DibujarPata:
    PUSH SI
    PUSH DI
    
    MOV BP, 15      ; Altura de la pata
    
PataLoop:
    MOV AH, 0Ch
    MOV AL, 00h     ; Negro
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC CX
    INT 10h         ; Ancho de 2 píxeles
    
    INC DI
    DEC BP
    JNZ PataLoop
    
    POP DI
    POP SI
    RET

; ========================================
; PROCEDIMIENTO: Dibujar Perro
; ========================================
DibujarPerro:
    ; Cuerpo del perro
    MOV SI, 350     ; Columna inicial
    MOV DI, 100     ; Fila inicial
    
PerroCuerpoFila:
    MOV SI, 350     ; Reiniciar columna
    
PerroCuerpoCol:
    MOV AH, 0Ch
    MOV AL, 06h     ; Color marrón
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 410     ; Ancho de 60
    JNE PerroCuerpoCol
    
    INC DI
    CMP DI, 140     ; Alto de 40
    JNE PerroCuerpoFila
    
    ; Cabeza del perro
    MOV SI, 340     ; Columna inicial
    MOV DI, 90      ; Fila inicial
    
PerroCabezaFila:
    MOV SI, 340
    
PerroCabezaCol:
    MOV AH, 0Ch
    MOV AL, 06h     ; Marrón
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 370     ; Ancho de 30
    JNE PerroCabezaCol
    
    INC DI
    CMP DI, 110     ; Alto de 20
    JNE PerroCabezaFila
    
    ; Orejas caídas
    MOV SI, 335
    MOV DI, 95
    MOV CX, 10
    
OrejaPerroIzq:
    MOV AH, 0Ch
    MOV AL, 06h
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    DEC SI
    INC DI
    LOOP OrejaPerroIzq
    
    ; Oreja derecha
    MOV SI, 370
    MOV DI, 95
    MOV CX, 10
    
OrejaPerroDer:
    MOV AH, 0Ch
    MOV AL, 06h
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    INC DI
    LOOP OrejaPerroDer
    
    ; Ojos
    MOV AH, 0Ch
    MOV AL, 00h     ; Negro
    MOV BH, 0
    MOV CX, 348     ; Ojo izquierdo
    MOV DX, 98
    INT 10h
    
    MOV CX, 358     ; Ojo derecho
    INT 10h
    
    ; Nariz
    MOV AH, 0Ch
    MOV AL, 00h
    MOV CX, 353
    MOV DX, 105
    INT 10h
    
    ; Cola levantada
    MOV SI, 410
    MOV DI, 110
    MOV CX, 15
    
PerroColaLoop:
    MOV AH, 0Ch
    MOV AL, 06h
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    DEC DI
    LOOP PerroColaLoop
    
    RET

; ========================================
; PROCEDIMIENTO: Dibujar Árbol
; ========================================
DibujarArbol:
    ; Tronco
    MOV SI, 500     ; Columna inicial
    MOV DI, 250     ; Fila inicial
    
TroncoFila:
    MOV SI, 500     ; Reiniciar columna
    
TroncoCol:
    MOV AH, 0Ch
    MOV AL, 06h     ; Color marrón
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 520     ; Ancho de 20
    JNE TroncoCol
    
    INC DI
    CMP DI, 300     ; Alto de 50
    JNE TroncoFila
    
    ; Copa del árbol (círculo verde)
    MOV SI, 480     ; Columna inicial
    MOV DI, 220     ; Fila inicial
    
CopaArbolFila:
    MOV SI, 480     ; Reiniciar columna
    
CopaArbolCol:
    MOV AH, 0Ch
    MOV AL, 02h     ; Color verde
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 540     ; Ancho de 60
    JNE CopaArbolCol
    
    INC DI
    CMP DI, 250     ; Alto de 30
    JNE CopaArbolFila
    
    RET

; ========================================
; PROCEDIMIENTO: Dibujar Sol
; ========================================
DibujarSol:
    ; Centro del sol
    MOV SI, 550     ; Columna inicial
    MOV DI, 30      ; Fila inicial
    
SolCentroFila:
    MOV SI, 550     ; Reiniciar columna
    
SolCentroCol:
    MOV AH, 0Ch
    MOV AL, 0Eh     ; Color amarillo
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 580     ; Ancho de 30
    JNE SolCentroCol
    
    INC DI
    CMP DI, 60      ; Alto de 30
    JNE SolCentroFila
    
    ; Rayos del sol (líneas diagonales)
    ; Rayo superior
    MOV SI, 565
    MOV DI, 25
    MOV CX, 5
    
RayoSup:
    MOV AH, 0Ch
    MOV AL, 0Eh
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    DEC DI
    LOOP RayoSup
    
    ; Rayo derecho
    MOV SI, 583
    MOV DI, 45
    MOV CX, 5
    
RayoDer:
    MOV AH, 0Ch
    MOV AL, 0Eh
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    INC SI
    LOOP RayoDer
    
    ; Rayo inferior
    MOV SI, 565
    MOV DI, 63
    MOV CX, 5
    
RayoInf:
    MOV AH, 0Ch
    MOV AL, 0Eh
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    INC DI
    LOOP RayoInf
    
    ; Rayo izquierdo
    MOV SI, 547
    MOV DI, 45
    MOV CX, 5
    
RayoIzq:
    MOV AH, 0Ch
    MOV AL, 0Eh
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    DEC SI
    LOOP RayoIzq
    
    RET

; ========================================
; PROCEDIMIENTO: Dibujar Nube
; ========================================
DibujarNube:
    ; Parte izquierda de la nube
    MOV SI, 100     ; Columna inicial
    MOV DI, 30      ; Fila inicial
    
NubeIzqFila:
    MOV SI, 100
    
NubeIzqCol:
    MOV AH, 0Ch
    MOV AL, 0Fh     ; Color blanco
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 120
    JNE NubeIzqCol
    
    INC DI
    CMP DI, 45
    JNE NubeIzqFila
    
    ; Parte central
    MOV SI, 115
    MOV DI, 25
    
NubeCenFila:
    MOV SI, 115
    
NubeCenCol:
    MOV AH, 0Ch
    MOV AL, 0Fh
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 145
    JNE NubeCenCol
    
    INC DI
    CMP DI, 45
    JNE NubeCenFila
    
    ; Parte derecha
    MOV SI, 140
    MOV DI, 30
    
NubeDerFila:
    MOV SI, 140
    
NubeDerCol:
    MOV AH, 0Ch
    MOV AL, 0Fh
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 160
    JNE NubeDerCol
    
    INC DI
    CMP DI, 45
    JNE NubeDerFila
    
    RET

; ========================================
; PROCEDIMIENTO: Dibujar Coche
; ========================================
DibujarCoche:
    ; Carrocería inferior
    MOV SI, 50      ; Columna inicial
    MOV DI, 350     ; Fila inicial
    
CocheBaseFila:
    MOV SI, 50
    
CocheBaseCol:
    MOV AH, 0Ch
    MOV AL, 04h     ; Color rojo
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 130     ; Ancho de 80
    JNE CocheBaseCol
    
    INC DI
    CMP DI, 370     ; Alto de 20
    JNE CocheBaseFila
    
    ; Cabina
    MOV SI, 70
    MOV DI, 335
    
CocheCabinaFila:
    MOV SI, 70
    
CocheCabinaCol:
    MOV AH, 0Ch
    MOV AL, 04h
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 110
    JNE CocheCabinaCol
    
    INC DI
    CMP DI, 350
    JNE CocheCabinaFila
    
    ; Ventanas
    MOV SI, 75
    MOV DI, 340
    
VentanasFila:
    MOV SI, 75
    
VentanasCol:
    MOV AH, 0Ch
    MOV AL, 0Bh     ; Cyan claro
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 105
    JNE VentanasCol
    
    INC DI
    CMP DI, 345
    JNE VentanasFila
    
    ; Ruedas (círculos negros)
    ; Rueda delantera
    MOV SI, 65
    MOV DI, 370
    CALL DibujarRueda
    
    ; Rueda trasera
    MOV SI, 105
    MOV DI, 370
    CALL DibujarRueda
    
    RET

; ========================================
; PROCEDIMIENTO: Dibujar Rueda (auxiliar)
; ========================================
DibujarRueda:
    PUSH SI
    PUSH DI
    
    MOV BP, 10      ; Tamaño de la rueda
    
RuedaFila:
    MOV CX, 10
    PUSH SI
    
RuedaCol:
    MOV AH, 0Ch
    MOV AL, 00h     ; Negro
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP RuedaCol
    
    POP SI
    INC DI
    DEC BP
    JNZ RuedaFila
    
    POP DI
    POP SI
    RET

; ========================================
; PROCEDIMIENTO: Dibujar Flor
; ========================================
DibujarFlor:
    ; Tallo
    MOV SI, 300
    MOV DI, 380
    
TalloLoop:
    MOV AH, 0Ch
    MOV AL, 02h     ; Verde
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    DEC DI
    CMP DI, 350
    JNE TalloLoop
    
    ; Centro de la flor
    MOV SI, 295
    MOV DI, 345
    
FlorCentroFila:
    MOV SI, 295
    
FlorCentroCol:
    MOV AH, 0Ch
    MOV AL, 0Eh     ; Amarillo
    MOV BH, 0
    MOV CX, SI
    MOV DX, DI
    INT 10h
    
    INC SI
    CMP SI, 305
    JNE FlorCentroCol
    
    INC DI
    CMP DI, 355
    JNE FlorCentroFila
    
    ; Pétalos (4 pequeños rectángulos)
    ; Pétalo superior
    MOV SI, 297
    MOV DI, 340
    CALL DibujarPetalo
    
    ; Pétalo derecho
    MOV SI, 305
    MOV DI, 347
    CALL DibujarPetalo
    
    ; Pétalo inferior
    MOV SI, 297
    MOV DI, 355
    CALL DibujarPetalo
    
    ; Pétalo izquierdo
    MOV SI, 290
    MOV DI, 347
    CALL DibujarPetalo
    
    RET

; ========================================
; PROCEDIMIENTO: Dibujar Pétalo (auxiliar)
; ========================================
DibujarPetalo:
    PUSH SI
    PUSH DI
    
    MOV BP, 5       ; Altura
    
PetaloFila:
    MOV CX, 5       ; Ancho
    PUSH SI
    
PetaloCol:
    MOV AH, 0Ch
    MOV AL, 0Ch     ; Rojo claro
    MOV BH, 0
    PUSH CX
    MOV CX, SI
    MOV DX, DI
    INT 10h
    POP CX
    
    INC SI
    LOOP PetaloCol
    
    POP SI
    INC DI
    DEC BP
    JNZ PetaloFila
    
    POP DI
    POP SI
    RET

; ========================================
; PROCEDIMIENTO: Esperar tecla
; ========================================
EsperarTecla:
    MOV AH, 00h
    INT 16h
    RET

; ========================================
; NOTAS Y TIPS ADICIONALES:
; ========================================
; 1. Para dibujar animales, usa formas básicas:
;    - Círculos/elipses para cuerpos y cabezas
;    - Triángulos para orejas
;    - Líneas para colas y bigotes
;
; 2. Combina colores para dar vida:
;    - Usa colores brillantes para flores
;    - Tonos naturales para animales
;    - Contraste para ojos y detalles
;
; 3. Para el parcial:
;    - Practica dibujar formas básicas primero
;    - Luego combínalas para crear objetos
;    - Usa comentarios para organizarte
;    - Guarda y restaura registros con PUSH/POP
; ========================================