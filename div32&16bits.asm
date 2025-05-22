org 200h

section .text
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

;se guardan en el destino
;ADD destino, fuente
;ADC destino, fuente
;SUB destino, fuente
;SBB destino, fuente
;MUL fuente
;IMUL fuente
;DIV fuente
;IDIV fuente

;MUL IMUL 8 bits AL 16 bits AX
;DIV IDIV 8 bits AX 16 bits DX:AX

;.\nasm -f bin .\div.asm -o a.com
;.\dosbox .

;Bandera	Nombre	Explicación breve	Ejemplo cuando se activa
;CF	Carry (Acarreo)	Indica desbordamiento en operaciones sin signo.	FFh + 01h → CF = 1
;OF	Overflow (Desborde)	Indica desbordamiento en operaciones con signo.	127 + 1 (operación con signo)
;ZF	Zero (Cero)	El resultado es cero.	AL = 1; SUB AL,1 → ZF = 1
;SF	Sign (Signo)	Indica resultado negativo (bit más significativo = 1).	AL = 0; SUB AL,1 → SF = 1
;AF	Auxiliary Carry	Indica acarreo en el bit 3 al bit 4 (BCD).	Suma BCD: 09h + 01h → AF=1
;PF	Parity (Paridad)	Indica número par de bits encendidos en el resultado.	Resultado: AL= 03h → PF=1
;DF	Direction (Dirección)	Controla dirección en operaciones con cadenas (MOVSB).	CLD (0)=incrementa; STD(1)=decrementa