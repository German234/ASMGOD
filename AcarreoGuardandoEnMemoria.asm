org 100h
    
section .text
    suma:
        XOR AX,AX
        XOR BX,BX
        XOR CX,CX
        XOR DX,DX

        mov bx,0FFFFh
        mov ax,0FFFFh
        add bx,ax
        mov [202h],bl
        adc cl,cl
        mov [201h],bh
        mov [200h],cl

int 20h

