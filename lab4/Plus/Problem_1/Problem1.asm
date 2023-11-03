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
    ;11. problem (d-c)+(b-a)-(b+b+b) - unsigned
    a db 1
    b dw 2
    c dd 3
    d dq 8
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EAX, dword[d]
        mov EDX, dword[d+4] ;EDX:EAX = d
        sub EAX, [c]
        sbb EDX, 0   ;EDX:EAX = d-c
        mov BX, [b]  ;BX = b
        mov CX, 0    
        mov CL, [a]  ;CX = a
        sub BX, CX   ;BX = b-a
        mov ECX, 0   
        mov CX, BX   ;ECX = b-a
        add EAX, ECX 
        adc EDX, 0   ;EDX:EAX = (d-c)+(b-a)
        mov EBX, 0
        mov BX, [b]  ;EBX = b
        add BX, [b]  ;EBX = b+b
        add BX, [b]  ;EBX = b+b+b
        sub EAX, EBX 
        adc EDX, 0   ;EDX:EAX = (d-c)+(b-a)-(b+b+b)
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
