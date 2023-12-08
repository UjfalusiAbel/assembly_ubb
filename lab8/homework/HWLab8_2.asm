bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit
extern fopen
extern fprintf
extern fclose
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;A file name and a text (defined in the data segment) are given. The text contains lowercase letters, digits and spaces. Replace all the digits on odd positions ;with the character ‘X’. Create the file with the given name and write the generated text to file. 
    
    file_name db "data.txt", 0
    access_mode db "w", 0
    file_descriptor dd -1
    text db "gdf5 7fd8 fh42"
    len equ $-text
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ESI, 0
        mov ECX, len
        mov EBX, 2
        jecxz skip_process
        do:
            mov EAX, ESI
            mov EDX, 0
            div EBX
            CMP EDX, 1
            je check_parity
            CMP byte[text+ESI], "0"
            je number
            CMP byte[text+ESI], "1"
            je number
            CMP byte[text+ESI], "2"
            je number
            CMP byte[text+ESI], "3"
            je number
            CMP byte[text+ESI], "4"
            je number
            CMP byte[text+ESI], "5"
            je number
            CMP byte[text+ESI], "6"
            je number
            CMP byte[text+ESI], "7"
            je number
            CMP byte[text+ESI], "8"
            je number
            CMP byte[text+ESI], "9"
            je number
            jmp not_number
            number:
                mov byte[text+ESI],"X"
            not_number:
            check_parity:
            inc ESI
            loop do
        skip_process:
        push dword access_mode     
        push dword file_name
        call [fopen]
        add ESP, 4*2
        mov [file_descriptor], EAX
        CMP EAX, 0
        je file_error
        push dword text
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2
        push dword [file_descriptor]
        call [fclose]
        file_error:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
