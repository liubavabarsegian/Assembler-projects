%include "../lib64.asm"

section .data
    InputText db "Input 28 elements by ENTER", 10, 13;
    TextLen equ $-InputText;
    
    OutputText dw "Result:", 10, 13
    OutputLen equ $-OutputText

    array_size db 28

section .bss
    array resd 28
    new_array resd 28
    Input_buf resd 1
    buf_len resd 1
    output_buf resd 1
section .text

global _start


read_cycle:
    cmp ebp, [array_size]
        je return
    mov eax, 0; read
    mov edi, 0; stdin=0
    mov esi, Input_buf; адрес вводимой строки
    mov edx, 10; buf len
    syscall
    
    mov esi, Input_buf
    call StrToInt64
    mov [array + ebp * 4], eax  
    
    inc ebp
    loop read_cycle
    ret


write_cycle:
    cmp ebp, [array_size]
        je return
    mov esi, Input_buf
    mov eax, [new_array + ebp * 4]
    call IntToStr64
    
    mov edx, eax ; длина строки
    mov eax, 1;write
    mov edi, 1;stdout=1
    mov esi, Input_buf 
    syscall 
    
    inc ebp
    loop write_cycle
    ret


modify:   
    mov ebp, 0
    mov edx, 0
    call negative
    mov ebp, 0
    call positive
    mov ebp, 0
    call zero
    ret


negative:
    cmp ebp, [array_size]
        je return
    mov eax, [array + ebp * 4]
    cmp eax, 0
        jl call_write_neg
    after_write_neg:
        inc ebp
        loop negative
        ret

positive:
    cmp ebp, [array_size]
        je return
    mov eax, [array + ebp * 4]
    cmp eax, 0
        jg call_write_pos
    after_write_pos:
        inc ebp
        loop positive
        ret

zero:
    cmp ebp, [array_size]
        je return
    mov eax, [array + ebp * 4]
    cmp eax, 0
        je call_write_zero
    after_write_zero:
        inc ebp
        loop zero
        ret
write:
    mov eax, [array + ebp * 4]
    mov [new_array + edx * 4], eax
    inc edx
    ret

call_write_neg:
    call write
    jmp after_write_neg

call_write_pos:
    call write
    jmp after_write_pos

call_write_zero:
    call write
    jmp after_write_zero

return:
    ret
_start:
    ;input text:
    mov eax, 1; write
    mov edi, 1; stdout = 1
    mov esi, InputText
    mov edx, TextLen
    syscall
    
    mov ebp, 0
    mov ecx, [array_size]
    call read_cycle

    mov ecx, [array_size]
    call modify


    ;output text:
    mov eax, 1; write
    mov edi, 1; stdout = 1
    mov esi, OutputText
    mov edx, OutputLen
    syscall

    mov ebp, 0
    mov ecx, [array_size]
    call write_cycle
    jmp exit

exit:
    mov rax, 60;
    xor rdi, rdi; return code 0
    syscall