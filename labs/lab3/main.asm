%include "../lib64.asm"

section .data ; сегмент инициализированных переменных
    Input_A db "Input A: ",10 ; выводимое сообщение
    lenA equ $-Input_A
    Input_R db "Input R: ",10 ;
    lenR equ $-Input_R
    Input_K db "Input K: ",10 ;
    lenK equ $-Input_K
    
    A_text db "Your A: ", 10
    R_text db "Your R: ", 10
    K_text db "Your K: ", 10
    F_text db "The result is: ", 10
    
 section .bss ; сегмент неинициализированных переменных
    A resd 1
    R resd 1
    K resd 1
    F resd 1;
    Buf_A resb 10 ; буфер для вводимой строки
    Buf_R resb 10 ; буфер для вводимой строки
    Buf_K resb 10 ; буфер для вводимой строки
    Buf_F resb 10 ;
   
 section .text ; сегмент кода

 global _start
_start:
    ; write A
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Input_A ; адрес выводимой строки
    mov rdx, lenA ; длина строки
    ; вызов системной функции
    syscall
    
    ; read
    mov rax, 0; системная функция 0 (read)
    mov rdi, 0; дескриптор файла stdin=0
    mov rsi, Buf_A; адрес вводимой строки
    mov rdx, 10; длина строки
    ; вызов системной функции
    syscall
    
    mov rsi, Buf_A
    call StrToInt64
    mov [A], eax
    
     ; write R
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Input_R ; адрес выводимой строки
    mov rdx, lenR ; длина строки
    ; вызов системной функции
    syscall
    
    ; read
    mov rax, 0; системная функция 0 (read)
    mov rdi, 0; дескриптор файла stdin=0
    mov rsi, Buf_R; адрес вводимой строки
    mov rdx, 10; длина строки
    ; вызов системной функции
    syscall
    
    mov rsi, Buf_R
    call StrToInt64
    mov [R], eax
    
      ; write K
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Input_K ; адрес выводимой строки
    mov rdx, lenK ; длина строки
    ; вызов системной функции
    syscall
    
    ; read
    mov rax, 0; системная функция 0 (read)
    mov rdi, 0; дескриптор файла stdin=0
    mov rsi, Buf_K; адрес вводимой строки
    mov rdx, 10; длина строки
    ; вызов системной функции
    syscall
    
    mov rsi, Buf_K
    call StrToInt64
    mov [K], eax   
    
    ;calculate F
    mov eax, [K]
    imul DWORD[A]
    cmp eax, 5
    jg greater
    jle less
greater:
    mov eax, [K]
    sub eax, 5
    mov esi, [R]
    imul eax
    idiv esi   
    mov [F], eax
    jmp continue
less:
    mov edi, 8
    sub edi, [A]
    mov [F], edi
    jmp continue         
continue:
    
    ;int to str for a    
    mov rsi, Buf_A
    mov eax, [A]
    call IntToStr64
    
    ;int to str for R
    mov rsi, Buf_R
    mov eax, [R]
    call IntToStr64
   
     
    ;int to str for K
    mov rsi, Buf_K
    mov eax, [K]
    call IntToStr64
    
    ;int to str for F
    mov rsi, Buf_F
    mov eax, [F]
    call IntToStr64
    
    
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, A_text ; адрес выводимой строки
    mov rdx, 8 ; длина строки
    ; вызов системной функции
    syscall    
    
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Buf_A ; адрес выводимой строки
    mov rdx, 4 ; длина строки
    ; вызов системной функции
    syscall

    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, R_text ; адрес выводимой строки
    mov rdx, 8 ; длина строки
    ; вызов системной функции
    syscall  
        
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Buf_R ; адрес выводимой строки
    mov rdx, 4 ; длина строки
    ; вызов системной функции
    syscall


    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, K_text ; адрес выводимой строки
    mov rdx, 8 ; длина строки
    ; вызов системной функции
    syscall  
    
    
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Buf_K ; адрес выводимой строки
    mov rdx, 4 ; длина строки
    ; вызов системной функции
    syscall

    
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, F_text ; адрес выводимой строки
    mov rdx, 15 ; длина строки
    ; вызов системной функции
    syscall  
    
                            
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Buf_F ; адрес выводимой строки
    mov rdx, 5 ; длина строки
    ; вызов системной функции
    syscall    
    
    mov rax, 60; системная функция 60 (exit)
    xor rdi, rdi; return code 0
    syscall