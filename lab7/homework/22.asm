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
    input db 2, 3, 5, 7
    len equ $ - input
    src db 4, 1, 7, 2,
    N equ $ - src
    dst db 7, 0, 9, 8
    output times len db 1
    i dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ECX, len
        mov ESI, input
        mov EDI, output
        replace_loop:
            LODSB
            mov EBX, ESI
            mov ESI, src
            mov DL, AL
            mov byte[i], 0
            src_loop:
                LODSB
                CMP AL, DL
                je found
                inc dword[i]
                CMP dword[i], N
                jb src_loop
                je not_found
            found:
                mov ESI, dst
                add ESI, [i]
                MOVSB
                XCHG EBX, ESI
                jmp found_end
            not_found:
                XCHG EBX, ESI
                dec ESI
                MOVSB
            found_end:
            loop replace_loop
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
