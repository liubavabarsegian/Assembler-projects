; %include "lib64.asm"
;Вводится строка, содержащая несколько слов, 
;разделенных пробелом.определить слова короче 4-х символов, 
;содержащие цифры, и количество таких слов.
section .data
section .bss
    string resb 255
section .text
global _start
_start:
    input_str:
        mov eax, 0; read
        mov edi, 0; stdin=0
        mov esi, string; адрес вводимой строки
        mov edx, 255; buf len
        syscall
    main:
        mov edi, string
        mov al, 10
        mov ecx, 255
        repne scasb
        mov byte[edi-1], 32
        mov byte[edi], 10

        mov ecx, 255
        mov ebx, 0 ;for counting current index
        mov ebp, 0
        read_by_byte:
            mov edi, [string + ebx]
            lodsb
            cmp eax, 10
                je exit
            cmp eax, 32
                je check_size
            inc ebx
            inc ebp
            loop read_by_byte
        check_size:
            cmp ebp, 4
                jge go_to_next_word
                jl check_for_digits
        check_for_digits:
                mov ecx, ebp
                mov eax, ebx
                sub eax, ebp
                lea rsi, [string + eax]
                word_loop:
                    cmp ecx, 0
                        je go_to_next_word
                    mov esp, 0 ;for countring ifs
                    lodsb
                    cmp eax, 48
                        jge inc_esp1
                    cmp2:
                    cmp eax, 57
                        jle inc_esp2
                    after_cmp:
                    cmp esp, 2
                        je print_current_word
                    dec ecx
                    jmp word_loop
        inc_esp1:
            inc esp
            jmp cmp2
        inc_esp2:
            inc esp
            jmp after_cmp
        print_current_word:
            mov edx, ebp ; длина строки
            mov eax, 1;write
            mov edi, 1;stdout=1
            mov esi, string
            syscall 
            jmp go_to_next_word
        go_to_next_word:
            add ebx, 1
            mov ebp, 0 ;for countring number of letters in a word
            jmp read_by_byte
    output_str:
        mov edx, 255 ; длина строки
        mov eax, 1;write
        mov edi, 1;stdout=1
        mov esi, string 
        syscall 
exit:
    mov rax, 60;
    xor rdi, rdi; return code 0
    syscall

