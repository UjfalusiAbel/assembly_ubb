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
    a DB 1
    b DB 2
    c DB 3
    d DB 4
    ;15-> mindenki saját száma után old problémát a félcsoportból - minden szetből 1, összesen 5

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov AL, [a]
        add AL, Byte[d] ;a+d
        mov DL, [b]
        add DL, byte[d] ;b+d
        mov BL, [c]
        sub BL, AL ;c-(a+b)
        add BL, DL ;c-(a+b)+(b+d)

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        