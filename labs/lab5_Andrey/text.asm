global FIND_SUBSTRINGS
extern _Z15print_substringPcS_PiS0_

section .text

FIND_SUBSTRINGS:
    ;пролог
    push RBP
    mov RBP,RSP

     mov r9,rsi
     mov r10, rdi
     push r9
     push r10

    ;[rcx] - n
    ;[r8] - i
    ;rdi - str1 /
    ;rsi - str2
    ;rdx - buffer

    mov r9, rcx
    push rcx

    mov rax, [r8]
    add rax, rdi
    mov rdi, rax

    push rsi
    mov rsi, rdi
    ;     считываем текущий символ str1[i]
    lodsb
    ; str1[i] from rax -> to rbx
    mov bl, al
    mov rdi, rsi
    pop rsi

    cmp al, 0
    je exit

    loop1:
        lodsb
        cmp al, 0
        je exit

        cmp bl, al
        je substr
        after_substr:

            loop loop1
substr:
    inc qword[r9]

    cmpsb
    jne exit
    loop substr

    ;эпилог
exit:
    mov rax, r9

    ;[rcx] - i
    pop rcx
    mov rcx, r8

    ;rsi - buffer
    mov rsi, rdx

    pop r9
    ;rdi - str1
    mov rdi, r9
    pop r10

    mov rdx, rax

    call _Z15print_substringPcS_PiS0_
    mov rsp, rbp
    pop rbp
    ret
