org 200h

section .text
    XOR AX, AX
    XOR BX, BX

    main:
        MOV DI, 200h
        MOV AH, "9"
        MOV BX, 0h
        CALL bucle

    bucle:
        MOV [DI], AH
        INC DI
        DEC AH
        CALL comparacion
        LOOP bucle
        RET

    comparacion:
        CMP AH, "0"
        JE fin
        RET

    fin:
        INT 20h
        RET