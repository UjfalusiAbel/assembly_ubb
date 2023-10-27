bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;(a*a/b+b*b)/(2+b)+e-x --- unsigned
    a DB 4
    b DW 2
    e DD 3
    x DQ 4
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov AL, [a]  ;AL = a
        mul byte[a]  ;AX = a*a
        mov DX, 0    ;DX:AX = a*a
        div word[b]  ;AX = a*a/b
        mov BX, AX   ;BX = a*a/b
        mov AX, [b]  ;AX = b
        mul word[b]  ;DX:AX = b*b
        add AX, BX   
        adc DX, 0    ;DX:AX = a*a/b+b*b
        mov BX, 2    ;BX = 2
        add BX, [b]  ;BX = 2+b
        div BX       ;AX = (a*a/b+b*b)/(2+b)
        mov EBX, 0
        mov BX, AX   ;EBX = (a*a/b+b*b)/(2+b)
        add EBX, [e] ;EBX = (a*a/b+b*b)/(2+b)+e
        mov ECX, 0   ;ECX:EBX = (a*a/b+b*b)/(2+b)+e
        sub EBX, dword[x]  
        sbb ECX, dword[x+4] ;ECX:EBX = (a*a/b+b*b)/(2+b)+e-x
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
