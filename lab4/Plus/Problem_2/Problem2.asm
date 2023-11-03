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
    ;d-(a+b+c)-(a+a)  --- signed
    a db 2
    b dw 3
    c dd 4
    d dq 10
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EBX, dword[d]
        mov ECX, dword[d+4] ;ECX:EBX = d
        mov AL, [a]  ;AL = a
        CBW          ;AX = a
        add AX, [b]  ;AX = a+b
        CWDE         ;EAX = a+b
        add EAX, [c] ;EAX = a+b+c
        sub EBX, EAX
        sbb ECX, 0   ;ECX:EBX = d-(a+b+c)
        mov Al, [a]  ;AL = a
        add AL, [a]  ;AL = a+a
        CBW
        CWDE         ;EAX = a+a
        sub EBX, EAX
        sbb ECX, 0   ;ECX:EBX = d-(a+b+c)-(a+a)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
