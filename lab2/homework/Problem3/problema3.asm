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
    ;21. a-c+d-7+b-(2+d) // 1-3+4-7+2-(2+4)=-9
    a DW 1
    b DW 2
    c DW 3
    d DW 4
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov AX, [a]
        sub AX, [c] ;AX = a-c
        add AX, [d] ;AX = a-c+d
        sub AX, 7   ;AX = a-c+d-7
        add AX, [b] ;AX = a-c+d-7+b
        mov BX, 2   ;BX = 2
        add BX, [d] ;BX = 2+d
        sub AX, BX  ;AX = a-c+d-7+b-(2+d)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
