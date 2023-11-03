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
    ;(a+b)/(2-b*b+b/c)-x --- unsigned
    a DD 5 
    b DB 3
    c DB 1
    x DQ 4
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EBX, [a]  ;EBX = a
        mov AL, [b]   ;AL = b
        CBW           ;AX = b
        CWDE          ;EAX = b
        add EBX, EAX  ;EBX = a+b
        mov CX, 2     ;CX = 2
        mov AL, [b]   ;AL = b
        imul byte[b]  ;AX = b*b
        sub CX, AX    ;CX = 2-b*b
        mov AL, [b]   ;AL = b
        mov AH, 0     ;AX = b
        idiv byte[c]  ;AL = b/c
        add CL, AL
        adc CH, 0     ;CX = 2-b*b+b/c
        mov [a],EBX   ;a = a+b
        mov AX, word[a]
        mov DX, word[a+2] ;DX:AX = a+b
        idiv CX        ;AX = (a+b)/(2-b*b+b/c)
        CWDE          ;EAX = (a+b)/(2-b*b+b/c)
        CDQ           ;EDX:EAX = (a+b)/(2-b*b+b/c)
        sub EAX, dword[x]
        sbb EDX, dword[x+4] ;EDX:EAX = (a+b)/(2-b*b+b/c)-x
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
