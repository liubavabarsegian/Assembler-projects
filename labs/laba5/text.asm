global MAX_SIZE
global EXPAND_LINE
section .text

MAX_SIZE:
        ;rdi sizes
        ;rsi n
        ;rdx max
        push RBP
        mov RBP,RSP
        mov rcx, rsi
        sub rcx, 1

        mov eax, [rdi]
        mov [rdx], eax
        find_max:
            cmp rcx, 0
                je MAX_SIZE.exit
            mov ebx, eax
            add rdi, 4
            mov eax, [rdi]
            cmp eax, ebx
                jg new_max
            after:
                dec rcx
                jmp find_max

    new_max:
        mov [rdx], eax
        jmp after
    MAX_SIZE.exit:
        mov rsp, rbp
        pop rbp
        ret

add:
    inc ebx
    jmp after_add

count_spaces:
    mov rcx, rsi
    push rsi
    mov rsi, rdi
    mov rbx, 0
    iterate:
        lodsb
        cmp al, ' '
        je add
        after_add:
        loop iterate
    pop rsi
    ret

add_spaces:
    mov rcx, r9
    add rcx, 1
    spaces:
        mov al, ' '
        mov BYTE[r10], al
        add r10, 1
        loop spaces
    jmp after_adding_spaces

fill_equally:
    push rdx
    add rdi, r11
    mov r10, rcx
    push rcx
    mov rcx, rsi
    push rsi
    mov rsi, rdi
    find_space:
        lodsb
        cmp al, ' '
        push rcx
        je add_spaces
        mov BYTE[r10], al
        add r10, 1
        after_adding_spaces:
        pop rcx
        loop find_space
    mov BYTE[r10], 0
    pop rcx
    mov rcx, r10
    pop rsi
    pop rdx
    ret

add_spaces_left:
    mov rcx, r9
    add rcx, 1
    add rcx, rbx
    .spaces:
        mov al, ' '
        mov BYTE[r10], al
        add r10, 1
        loop .spaces
    mov BYTE[r10], 0
    jmp fill_left_first.after_adding_spaces

fill_left_first:
    push rdx
    mov r10, rcx
    push rcx
    mov rcx, rsi
    push rsi
    mov rsi, rdi
    mov r11, 0
    find_space_left:
        lodsb
        push rcx
        cmp al, ' '
        je add_spaces_left
        mov BYTE[r10], al
        add r10, 1
        pop rcx
        inc r11
        loop find_space_left
    fill_left_first.after_adding_spaces:

    pop rsi
    pop rcx
    mov rcx, r10

;    sub rsi, r11
    add rsi, 1
    pop rdx
    inc rdi
    call fill_equally
    jmp exit

;fill_spaces_left_for_one_word:
;    mov r10, rcx
;    push rcx
;    mov rcx, r8
;    .spaces:
;        mov al, ' '
;        mov BYTE[r10], al
;        add r10, 1
;        loop .spaces
;    pop rcx
;    ret

maths:
    mov r8, rdx ;max
    push rdx
    mov rdx, 0
    sub r8, rsi ; max - size
    cmp r8, 0
    je exit
    cmp rbx, 0 ; if zero spaces
    je exit
;    je fill_spaces_left_for_one_word
    mov rax, r8
    div rbx
    mov r9, rax ; division result
    mov rbx, rdx
    pop rdx
    mov r11, 0
    cmp rbx, 0;  rdх - остаток
    je fill_equally
    jne fill_left_first

    ret
EXPAND_LINE:
    push RBP
    mov RBP,RSP
    ;rdi buffer
    ;rsi len
    ;rdx max
    ;rcx new
    push rcx
    call count_spaces
    pop rcx
    call maths
    exit:
        mov rsp, rbp
        pop rbp
        ret
