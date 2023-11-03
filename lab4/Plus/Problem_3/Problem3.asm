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
    b DB 1
    c DB 1
    x DQ 2
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov AX, [a]
        mov DX, [a+2]  ;DX:AX = a
        mov CL, [b]    ;CL = b
        mov CH, 0      ;CX = b
        add AX, CX
        adc DX, 0      ;DX:AX = a+b
        mov BX, AX     ;DX:BX = a+b
        mov CX, 2      ;CX = 2
        mov AL, [b]    ;AL = b
        mul byte[b]    ;AX = b*b
        sub CX, AX     ;CX = 2-b*b
        mov AX, 0
        mov AL, [b]    ;AX = b
        div byte[c]    ;AL = b/c
        add CL, Al
        adc CH, 0      ;CX = 2-b*b+b/c
        mov AX, BX     ;DX:AX = a+b
        div CX         ;AX = (a+b)/(2-b*b+b/c)
        mov EBX, 0
        mov BX, AX     ;EBX = (a+b)/(2-b*b+b/c)
        mov ECX, 0     ;ECX:EBX = (a+b)/(2-b*b+b/c)
        sub EBX, dword[x]
        sbb ECX, dword[x+4] ;ECX:EBX = (a+b)/(2-b*b+b/c)-x
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
