bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
extern scanf
extern printf
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll          
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 0
    b dw 0
    c dd 0
    scan_format db "%u", 0
    print_format db "The constructed number is %x", 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword a
        push dword scan_format
        call [scanf]
        add ESP, 4*2
        
        push dword b
        push dword scan_format
        call [scanf]
        add ESP, 4*2
        
        mov AX, [a]
        add AX, [b]
        mov [c], AX
        
        mov AX, [a]
        sub AX, [b]
        mov [c+2], AX
        
        push dword [c]
        push dword print_format
        call [printf]
        add ESP, 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
