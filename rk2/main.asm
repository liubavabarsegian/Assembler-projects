%include "lib64.asm"
section .data
    X dd    1, 2, 3, 4, 5, \
            6, 7, 8, 9, 10, \
            11, 12, 13, 14, 15, \
            16, 17, 18, 19, 20,\
            21, 22, 23, 24, 25

section .bss
    H resd 5
    a resd 1
    b resd 1
    Buf resb 1

section .text
global _start
_start:
    mov ecx, 5
    mov edx, 4
    mov ebx, 0
    cycle:
        push rdx
        mov eax, ebx
        mov esi, 4
        mul esi
        mov esi, 5
        mul esi
        mov esi, eax

        mov eax, ebx
        mov edi, 4
        mul edi 

        add eax, esi
        mov ebp, [X + eax]
        mov [a], ebp

        pop rdx
        mov eax, edx
        mov esi, 4
        push rdx
        mul esi
        mov esi, 5
        mul esi
        mov esi, eax

        mov eax, ebx
        mov edi, 4
        mul edi
        
        add eax, esi
        mov ebp, [X + eax]
        mov [b], ebp

        mov eax, [a]
        mov ebp, [b]
        mul ebp
        pop rdx ;; эта строчка была на пару строк выше, но должна быть тут

        mov [H + ebx * 4], eax
        inc ebx
        dec edx
        loop cycle

    mov ebp, 0
    mov ecx, 5
    print_cycle:
        push rcx ;; забыла, что функция IntToStr меняет ecx и надо было ecx положить в стек
        mov eax, [H + ebp * 4]
        mov esi, Buf
        call IntToStr64

        mov edx, eax
        mov eax, 1
        mov edi, 1
        mov esi, Buf
        syscall

        inc ebp
        pop rcx ;; к исправлению выше
        loop print_cycle
    exit:
        mov rax, 60
        xor rdi, rdi
        syscall