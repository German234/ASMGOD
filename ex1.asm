org 100h

    section .text 
        XOR AX, AX
        XOR BX, BX
        XOR CX,CX
        XOR DX, DX

    main:
        mov byte[200h], 2d  ;Si el valor es 1 realizara suma, si el valor es 2 realizara multiplicacion
    
    comparacion:
        CMP byte[200h], 1d
        JE suma
        CMP byte[200h], 2d
        JE multiplicacion
        int 20h     

    suma:
        mov bx, 10d
        mov ax, 5d
        add bx,ax
        JMP endSum


    
    multiplicacion:
        mov cl , 'F'
        mov ch , 'I'
        mov bh , 'N'

        mov bl, 5d
        mov ax, 8d
        mul bl

    multSubrutine:
        CMP ax, 60d
        JA endMult
        CALL aumentar
        CALL resetRegister
        mul bl
        JMP multSubrutine

    aumentar:
        INC bl
        RET

    resetRegister:  
        mov ax, 8d
        RET

    
    endSum:
        int 20h

    endMult:
        mov [220h], cl
        mov [221h], ch
        mov [222h], bh
        int 20h
        

        