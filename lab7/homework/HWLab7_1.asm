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
    ;Being given a string of words, obtain the string (of bytes) of the digits in base 10 of each word from this string. 
    s DW 12345, 20778, 4596
    lens equ $-s
    r times 5 db 1
    a times 5*lens db 0
    helper dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ECX, lens/2
        mov ESI, s
        mov EDI, a
        jecxz endloop
        loop1:
            CLD
            mov EAX, 0
            mov EBX, EDI
            LODSW
            mov EDI, r
            divide:
                mov EDX, 0 ;EDX:EAX = [ESI]
                mov dword[helper], 10
                div dword[helper]
                mov [helper], EAX
                mov EAX, EDX
                STOSB 
                mov EAX, [helper]
                CMP EAX,0
            ja divide
            mov EAX, EDI ;address r+len of number-1
            mov EDI, EBX ;address a
            mov EBX, ESI ;address s
            mov ESI, EAX ;address r+len of number-1
            dec ESI
            invert:
                STD
                LODSB   
                CLD
                STOSB
                CMP ESI, r
            jnb invert
            mov ESI, EBX    
        loop loop1
        endloop:

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
