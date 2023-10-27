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
    ;(c-a) + (b - d) +d unsigned
    a db 1
    b dw 4
    c dd 3
    d dq 2
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EAX, 0
        mov AL, [a]
        sub [c], EAX ;c = c-a
        mov EAX, 0
        mov AX, [b]
        mov EDX, 0
        sub EAX, dword[d]
        sbb EDX, dword[d+4] ;EDX:EAX = b-d
        mov EBX, 0
        mov EBX, [c] ;EBX = c-a
        mov ECX, 0
        add EBX, EAX 
        adc ECX, EDX ;ECX:EBX = (c-a) + (b-d)
        add EBX, dword[d]
        adc ECX, dword[d+4] ;ECX:EBX = (c-a) + (b-d) +d
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
