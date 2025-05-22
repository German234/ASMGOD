org 200h

section .text
    XOR AX, AX
    XOR BX, BX

    main:
    MOV byte[200h],1d
    MOV AH, [200h]
    CMP AH, 1d
    JE suma
    CMP AH, 2d
    JE multiplicacion
    CALL fin

    suma:
        MOV AX, 10d
        MOV BX, 5d
        ADD AX, BX
        CALL fin

    multiplicacion:
        MOV AX, 8d
        MOV BX, 5d
        MUL BX
        CALL comparacion

    comparacion:
        CMP AX, 60d
        JL bucle
        JG fin
        RET

    bucle:
        INC BX
        MOV AX, 8d
        MUL BX
        CALL comparacion
        LOOP bucle

    fin:
        MOV byte[220h], "F"
        MOV byte[221h], "I"
        MOV byte[222h], "N"
        INT 20h
        RET
    ; Fin del programa


    ;Saltos condicionales sin considerar signo
    ;JA Salto si es Mayor (Above)
    ;Sin considerar el signo, destino > fuente
    ;JAE
    ;Salto si es Mayor o Igual (Above or Equal)
    ;Sin considerar el signo, destino ≥ fuente
    ;JB
    ;Salto si es Menor (Below)
    ;Sin considerar el signo, destino < fuente
    ;JBE
    ;Salto si es Menor o Igual (Below or Equal)
    ;Sin considerar el signo, destino ≤ fuente
    ;JE
    ;Salto si es Igual (Equal)
    ;Destino = fuente

    ;Saltos condicionales considerando signo
    ;JG
    ;Salto si es Mayor (Greater)
    ;Considerando el signo, destino > fuente
    ;JGE
    ;Salto si es Mayor o Igual (Greater or Equal)
    ;Considerando el signo, destino ≥ fuente
    ;JL
    ;Salto si es Menor (Less)
    ;Considerando el signo, destino < fuente
    ;JLE
    ;Salto si es Menor o Igual (Less or Equal)
    ;Considerando el signo, destino ≤ fuente

    ;Salto Incondicional
    ;JMP
    ;Siempre salta, sin condición
    ;CALL
    ;Llama a Subrutina
    ;Siempre llama, guarda dirección de retorno
    ;RET
    ;Retorna de Subrutina
    ;Retorna al punto guardado por CALL

    ;Banderas de estado
    ;JC
    ;Salto si hay Acarreo (Carry)
    ;Bandera de acarreo (CF) está activada
    ;JNC
    ;Salto si no hay Acarreo (No Carry)
    ;Bandera de acarreo (CF) no está activada
    ;JZ
    ;Salto si es Cero (Zero)
    ;Bandera de cero (ZF) está activada
    ;JNZ
    ;Salto si no es Cero (Not Zero)
    ;Bandera de cero (ZF) no está activada

    ;Instrucción de Limpieza de Acarreo CLC 1 a 0
    ;Instrucción de Complemento de Acarreo CMC 0 a 1 y de 1 a 0

    ;.\nasm -f bin .\20mayA.asm -o exam.com
    ;.\dosbox .