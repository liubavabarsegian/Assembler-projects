%include "lib64.asm"
; Дана матрица B(5,6). 
;В каждой строке поменять местами 1-й и 2-й элементы, 
;3-й и четвёртый и т. д. Полученную матрицу вывести на экран.
section .data
    B dd    1, 2, 3, 4, 5, 6, \
            7, 8, 9, 10, 11, 12, \
            13, 14, 15, 16, 17, 18, \
            19, 20, 21, 22, 23, 24, \
            25, 26, 27, 28, 29, 30
section .bss
    Buf resd 1
section .text

global _start
_start:
    mov ecx, 5 ;количество строк
    mov ebx, 0 ;для строк
    cycle1:
        push rcx;
        mov ecx, 3
        mov edx, 0 ;для столбцов
        cycle2:
            push rcx
            push rdx
            mov eax, ebx
            mov edi, 6
            mul edi
            mov edi, 4
            mul edi
            mov edi, eax

            pop rdx
            push rdi
            mov eax, edx
            push rdx
            mov edi, 4
            mul edi
            pop rdx
            pop rdi
            add edi, eax

            push rdx
            mov eax, [B + edi]
            mov  edx, [B + edi + 4]
            mov [B + edi], edx
            mov [B + edi + 4], eax
            pop rdx

            pop rcx
            add edx, 2  
            loop cycle2
        pop rcx
        inc ebx
        loop cycle1


    mov ecx, 5 ;количество строк
    mov ebx, 0 ;для строк
    print_cycle1:
        push rcx;
        mov ecx, 6
        mov edx, 0 ;для столбцов
        print_cycle2:
            push rcx
            mov esi, Buf

            push rsi
            push rdx
            mov eax, ebx
            mov edi, 6
            mul edi
            mov edi, 4
            mul edi
            mov edi, eax

            pop rdx
            push rdi
            mov eax, edx
            push rdx
            mov edi, 4
            mul edi
            pop rdx
            pop rdi
            add edi, eax
            pop rsi

            mov eax, [B + edi]
            call IntToStr64
            
            push rdx
            mov edx, eax ; длина строки
            mov eax, 1;write
            mov edi, 1;stdout=1
            mov esi, Buf 
            syscall 

            pop rdx
            pop rcx
            inc edx
            loop print_cycle2
        pop rcx
        inc ebx
        loop print_cycle1
exit:
    mov rax, 60;
    xor rdi, rdi; return code 0
    syscall

