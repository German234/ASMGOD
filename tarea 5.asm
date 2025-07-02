ORG 100h

SECTION .text

setup:
  MOV SI, 90d ; Columna inicial
  MOV DI, 70d ; Fila inicial
  MOV BP, 190d ; Límite de columna

  main:
  CALL IniciarModoVideo
  CALL DibujarTriangulo
  CALL EsperarTecla

  INT 20H

  IniciarModoVideo:
    ;AL:
    ;4H -> 320px200p, 4 colores
    ;0DH -> 320px200p, 16 colores
    ;0EH -> 640px200p, 16 colores
    ;10H -> 640px350p, 16 colores
    ;11H -> 640px480p, 2 colores
    ;12H -> 640px480p, 16 colores
    ;13H -> 40ppx25p, 256 colores m
  MOV AH, 0h
  MOV AL, 12h      ; Modo gráfico 640x480, 16 colores
  INT 10h
  RET

  DibujarTriangulo:
  MOV AH, 0Ch           ; Función del BIOS para poner un píxel
  MOV AL, 04h           ; Color del píxel (rojo)
  MOV BH, 0             ; Página de video 0
  MOV CX, SI            ; Coordenada X
  MOV DX, DI            ; Coordenada Y
  INT 10h               ; Enciende el píxel

  INC SI                ; Incrementa la columna
  CMP SI, BP            ; Compara la columna actual con el límite de 190
  JNE DibujarTriangulo ; Continúa en la misma fila si no se alcanza el límite
  DEC BP           ; Reduce el límite de columna para la siguiente fila
  ; Al alcanzar el límite de la fila, prepara la siguiente fila
  INC DI                ; Incrementa la fila
  MOV SI, 90d           ; Reinicia la columna al inicio para la nueva fila

  CMP DI, 170d          ; Compara la fila actual con el límite de 120
    ;CMP BP, 0d          ; Compara la fila actual con el límite de 120
  JNE DibujarTriangulo ; Si no se alcanza el límite, continúa dibujando la fila
  RET                   ; Termina la función cuando el rectángulo está completo

  EsperarTecla:
  MOV AH, 00h
  INT 16h        ; Lee una tecla del teclado
  RET