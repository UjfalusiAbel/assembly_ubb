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
    ;a+b/c-d*2-e
    a DD 1
    b DB 2
    c DW 3
    d DB 4
    e DQ 4
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov AL, [b]
        mov AH, 0   ;AX = b
        mov DX, 0
        div word[c] ;AX = b/c DX = b%c
        mov BX, AX
        mov AL, 2
        mul byte[d] ;AX = d*2 
        mov CX, 0
        add BX, word[a]
        adc CX, word[a+2] ;CX:BX = a + b/c
        mov DX, 0
        sub BX, AX
        sbb CX, DX  ;CX:BX = a+b/c-d*2
        push CX
        push BX
        pop EBX     ;EBX = a+b/c-d*2
        mov ECX, 0
        add EBX, dword[e]
        adc ECX, dword[e+4] ; ECX:EBX = a+b/c-d*2-e
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
