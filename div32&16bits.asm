org 200h

section .txt
    XOR AX, AX
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX
    XOR SI, SI
    XOR DI, DI
    XOR SP, SP
    XOR BP, BP

;JMP div16

div32:
    MOV DX, 1d
    MOV AX, 0FFFFh
    MOV BX, 3d
    DIV BX ; DX:AX/BX

;DIVIDENDO en DX:AX
;DIVISOR en BX
;AX cociente (resultado)
;DX residuo
;resultado AAAA en AX
;JMP end

div16:
    MOV AX, 0FFh
    MOV BH, 3d
    DIV BH ; AH/BH

;DIVIDENDO en AX pero solo 8 bits AH
;DIVISOR en BH
;AL cociente (resultado)
;AH residuo
;resultado 55 en AL

end:
    int 20h
