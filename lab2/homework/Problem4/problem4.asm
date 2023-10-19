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
    ;21. d-[3*(a+b+2)-5*(c+2)]
    a db 1
    b db 2
    c db 1
    d dw 4
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov AL, [a] ;AL = a
        add AL, [b] ;AL = a+b
        add AL, 2   ;AL = a+b+2
        mov BL, 3   ;BL = 3
        mul BL      ;AX = 3*(a+b+2)
        mov CX, AX  ;CX = 3*(a+b+2)
        mov AL, [c] ;AL = c
        add AL, 2   ;AL = c+2
        mov BL, 5   ;BL = 5
        mul BL      ;AX = 5*(c+2)
        mov BX, [d] ;BX = d
        sub CX, AX  ;CX = 3*(a+b+2)-5*(c+2)
        sub BX, CX  ;BX = d - [3*(a+b+2)-5*(c+2)]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
