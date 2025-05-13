org 100h 

    section .text
        ;sumar dos numeros
        XOR BX,BX
        XOR AX,AX
        XOR CX,CX
        XOR DX,DX

        sumando:
            MOV BL, 255d ; 255 +
            MOV AL, 255d ; 255 = 510 = 1FE
            ADD BL, AL ;  muestra FE y se acarrea
            ADC CL, CL ; CL = 0, solamente se suma el 1 de la bandera de carrera
            ADD BH, CL

int 20h