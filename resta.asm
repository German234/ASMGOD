org 100h 

    section .text
        XOR BX,BX
        XOR AX,AX
        XOR CX,CX
        XOR DX,DX

        restando:
            mov bl, 0d        ; BL = 0x00
    mov al, 1d       ; AL = 0x01

    sub bl, al       ; 
                     ; 
    sbb cx, cx       
                     

int 20h