; ---------------------------------------------------------------
; Práctica 04 - Instrucciones de Salto y Comparación
; ---------------------------------------------------------------
; Conceptos Clave:
; ---------------------------------------------------------------
; - CMP: Compara dos operandos (por resta, sin guardar resultado).
; - JMP: Salto incondicional a una etiqueta.
; - JE / JZ: Salto si son iguales (Zero flag = 1).
; - JNE / JNZ: Salto si no son iguales (Zero flag = 0).
; - JL / JB: Salto si menor (Signed/Unsigned).
; - JLE / JBE: Salto si menor o igual.
; - JG / JA: Salto si mayor (Signed/Unsigned).
; - JGE / JAE: Salto si mayor o igual.

; ---------------------------------------------------------------
; Banderas Afectadas por CMP:
; ---------------------------------------------------------------
; - ZF (Zero Flag): Activada si resultado de la comparación es 0.
; - SF (Sign Flag): Muestra si resultado fue negativo.
; - CF (Carry Flag): Usada para comparar números sin signo.
; - OF (Overflow Flag): Importante para números con signo.

; ---------------------------------------------------------------
; Interrupciones usadas:
; ---------------------------------------------------------------
; - INT 10h: Servicios de video
;     AH = 00h → Cambia modo de video
;     AH = 02h → Posicionar cursor
;     AH = 09h → Escribir carácter y atributo en pantalla
;
; - INT 16h: Entrada por teclado
;     AH = 00h → Espera y obtiene código ASCII de tecla presionada


; ---------------------------------------------------------------
; Práctica 05 - Interrupciones en Modo Texto
;---------------------------------------------------------------
; Interrupciones utilizadas:
; ---------------------------------------------------------------

; INT 10h - Servicios de video
; --------------------------------------
; AH = 00h → Cambiar modo de video
;     AL = 03h → Modo texto 80x25, 16 colores (modo estándar)
;
; AH = 02h → Posicionar cursor
;     BH = Página de video (por lo general 0)
;     DH = Fila (Y)
;     DL = Columna (X)
;
; AH = 09h → Escribir carácter con atributo
;     AL = Carácter ASCII
;     BH = Página de video
;     BL = Atributo (color de texto y fondo)
;     CX = Número de repeticiones del carácter

; INT 16h - Entrada por teclado
; --------------------------------------
; AH = 00h → Espera hasta que se presione una tecla y devuelve:
;     AL = Código ASCII de la tecla
;     AH = Código del escaneo (scan code)

; ---------------------------------------------------------------
; Atributos de color (BL):
; --------------------------------------
; - Bits 0-3: color del texto
; - Bits 4-6: color de fondo
; - Bit 7: parpadeo si está en 1

; Colores comunes:
; 0 = Negro      8 = Gris
; 1 = Azul       9 = Azul claro
; 2 = Verde      A = Verde claro
; 3 = Cian       B = Cian claro
; 4 = Rojo       C = Rojo claro
; 5 = Magenta    D = Magenta claro
; 6 = Marrón     E = Amarillo
; 7 = Blanco     F = Blanco brillante

; Ejemplo: BL = 0Fh → Texto blanco sobre fondo negro
;          BL = 1Eh → Texto amarillo sobre fondo azul


; ---------------------------------------------------------------
; Práctica 06 - Interrupciones en Modo Video (Gráfico)
; ---------------------------------------------------------------
; Interrupciones utilizadas:
; ---------------------------------------------------------------

; INT 10h - Servicios de video
; --------------------------------------

; AH = 00h → Cambiar modo de video
;     AL = 13h → Modo gráfico 320x200, 256 colores

; AH = 0Ch → Escribir un píxel en coordenadas (X,Y)
;     AL = Color del píxel
;     BH = Página de video (por lo general 0)
;     CX = Columna (X)
;     DX = Fila (Y)

; AH = 01h → Establecer forma del cursor (opcional si se quiere ocultar)

; ---------------------------------------------------------------
; Detalles del modo 13h:
; ---------------------------------------------------------------

; Resolución: 320 píxeles de ancho x 200 píxeles de alto
; Colores: 256 (8 bits por píxel)
; Memoria de video: segmentada en A000h
; Cada byte representa el color de un píxel
; No hay celdas de texto, por lo que se trabaja todo gráficamente
; ---------------------------------------------------------------
; Colores en modo 13h:
; ---------------------------------------------------------------
; Valores de AL (0 a 255) representan colores definidos por la paleta VGA.
; Algunos colores comunes:
; 00 = Negro       04 = Rojo          0F = Blanco brillante
; 01 = Azul        02 = Verde         0A = Verde claro
; 03 = Cian        05 = Magenta       0C = Rojo claro
; 07 = Gris claro  09 = Azul claro    0E = Amarillo
