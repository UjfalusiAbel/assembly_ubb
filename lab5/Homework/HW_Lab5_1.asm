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
    ;Problem 21.
    ;Given the words A and B, compute the doubleword C as follows:
    ;the bits 0-3 of C are the same as the bits 5-8 of B
    ;the bits 4-10 of C are the invert of the bits 0-6 of B
    ;the bits 11-18 of C have the value 1
    ;the bits 19-31 of C are the same as the bits 3-15 of B 
    
    a dw 1100110011001100b
    b dw 1001100110011001b
    c dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov BX, [b] ;BX = 1001100110011001b
        shr BX, 5   ;BX = 0000010011001100b
        and BX, 0000000000001111b
        or word[c], BX
        mov BX, [b]
        not BX
        shl BX, 4
        and BX, 0000011111110000b
        mov ECX, 0
        mov CX, BX
        or [c], ECX
        or dword[c], 0007F800h
        mov BX, [b]
        and BX, 1111111111111000b
        or word[c+2], BX
        mov EAX, [c]
        ;final result : EAX = 1001 1001 1001 1111 1111 1110 0110 1100
        ;EAX = 999FFE6C
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
