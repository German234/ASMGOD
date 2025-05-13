org 100h

    section .text
        XOR AX,AX
        XOR BX,BX
        XOR CX,CX
        XOR DX,DX
        jmp div
        multiplicando:
            mov bl,02d 
            mov al,-02d
            imul bl 
        
        div:
             mov al, -10      ; AL = 0xF6 (−10)
            mov bl, 3
            idiv bl          ; AL = cociente, AH = residuo
                            ; tras IDIV:
                            ;   AL = 0xFD  → −3
                            ;   AH = 0xFF  → −1

int 20