global FIND_SUBSTRINGS

.text

FIND_SUBSTRINGS:
    ;пролог
    push RBP
    mov RBP,RSP

    ;[rcx] - n
    ;r8 - i
    ;rdi - str1 /
    ;rsi - str2
    ;rdx - buffer

    mov r9, rcx
    push rcx

    mov rax, r8
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
    inc word[r9]

    cmpsb
    jne exit
    loop substr

    ;эпилог
exit:
    pop rcx
    mov rcx, r9
    mov rsp, rbp
    pop rbp
    ret
