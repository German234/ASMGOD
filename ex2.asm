org 100h

    section .text
        XOR AX, AX
        XOR BX, BX
        XOR CX,CX
        XOR DX,DX

    main:
        mov ax, '9'
        mov bx, 0h
        CALL subrutine
        
        

    subrutine:
        CMP ax, '1'
        JB end
        CALL swap
        CALL decrecerAndCrecer
        JMP subrutine
        RET

    decrecerAndCrecer:
        DEC ax
        INC bx
        RET
    swap:
        mov [200h+bx], ax
        RET

    end:
        int 20h

