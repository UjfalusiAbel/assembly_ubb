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
    ;Two byte strings A and B are given. 
    ;Obtain the string R by concatenating the elements of B in reverse order and the negative elements of A. 
    
    a db 2,1,-3,3,-4,2,6
    lena equ $-a
    b db 4,5,7,6,2,1
    lenb equ $-b
    r times lena+lenb db 1
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ECX, lenb
        mov ESI, b+lenb-1
        mov EDI, r
        jecxz endloop1
        loop1:
            mov AL, [ESI]
            mov [EDI], AL
            dec ESI
            inc EDI
        loop loop1
        endloop1:
        
        mov ECX, lena
        mov ESI, a
        
        jecxz endloop2
        loop2:
            mov AL, [ESI]
            CMP AL, 0
            jge skip
                mov [EDI], AL
                inc EDI
            skip:
            inc ESI
        loop loop2
        endloop2:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
