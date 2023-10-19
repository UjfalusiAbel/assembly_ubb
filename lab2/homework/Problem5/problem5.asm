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
    ;(f*g-a*b*e)/(h+c*d)
    a db 2
    b db 2
    c db 2
    d db 2
    e dw 4
    f dw 5
    g dw 8
    h dw 2
    helper dd 1
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov AX, [f] ;AX = f
        mul word[g] ;DX:AX = f*g
        push DX
        push AX
        pop dword[helper]  ;helper = f*g
        mov AL, [a] ;AL = a
        mul byte[b] ;AX = a*b
        mul word[e] ;DX:AX = a*b*e
        push DX
        push AX
        pop ECX     ;ECX = a*b*e
        sub dword[helper], ECX;helper = f*g-a*b*e
        mov AL, [c] ;AL = c
        mul byte[d] ;AX = c*d
        add AX, [h] ;AX = h+c*d
        mov BX, AX  ;BX = h+c*d
        mov AX, [helper]
        mov DX, [helper+2] ;DX:AX = f*g-a*b*e
        div BX      ;AX = (f*g-a*b*e)/(h+c*d)
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
