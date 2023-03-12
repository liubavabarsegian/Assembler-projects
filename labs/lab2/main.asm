%include "lib64.asm"

section .data ; сегмент инициализированных переменных
    Input_A db "Input A: ",10 ; выводимое сообщение
    lenA equ $-Input_A
    Input_B db "Input B: ",10 ;
    lenB equ $-Input_B
    Input_Y db "Input Y: ",10 ;
    lenY equ $-Input_Y
    
    A_text db "Your A: ", 10
    B_text db "Your B: ", 10
    Y_text db "Your Y: ", 10
    X_text db "The result is: ", 10
    
 section .bss ; сегмент неинициализированных переменных
    A resd 1
    B resd 1
    Y resd 1
    X resd 1;
    Buf_A resb 10 ; буфер для вводимой строки
    Buf_B resb 10 ; буфер для вводимой строки
    Buf_Y resb 10 ; буфер для вводимой строки
    Buf_X resb 10 ;
   
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
    
     ; write B
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Input_B ; адрес выводимой строки
    mov rdx, lenB ; длина строки
    ; вызов системной функции
    syscall
    
    ; read
    mov rax, 0; системная функция 0 (read)
    mov rdi, 0; дескриптор файла stdin=0
    mov rsi, Buf_B; адрес вводимой строки
    mov rdx, 10; длина строки
    ; вызов системной функции
    syscall
    
    mov rsi, Buf_B
    call StrToInt64
    mov [B], eax
    
      ; write Y
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Input_Y ; адрес выводимой строки
    mov rdx, lenY ; длина строки
    ; вызов системной функции
    syscall
    
    ; read
    mov rax, 0; системная функция 0 (read)
    mov rdi, 0; дескриптор файла stdin=0
    mov rsi, Buf_Y; адрес вводимой строки
    mov rdx, 10; длина строки
    ; вызов системной функции
    syscall
    
    mov rsi, Buf_Y
    call StrToInt64
    mov [Y], eax   
    
    
     ;calculate X
     mov EAX, [B]
     mov ESI, 4
     sub EAX, [A]
     imul DWORD[Y]
     imul DWORD[A]
     idiv ESI
     mov ECX, EAX
     mov EAX, [A]
     imul DWORD[A]
     add EAX, ECX
     sub EAX, 2
     mov [X], EAX;
    
    ;int to str for a    
    mov rsi, Buf_A
    mov eax, [A]
    call IntToStr64
    
    ;int to str for B
    mov rsi, Buf_B
    mov eax, [B]
    call IntToStr64
   
     
    ;int to str for B
    mov rsi, Buf_Y
    mov eax, [Y]
    call IntToStr64
    
    ;int to str for B
    mov rsi, Buf_X
    mov eax, [X]
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
    mov rsi, B_text ; адрес выводимой строки
    mov rdx, 8 ; длина строки
    ; вызов системной функции
    syscall  
        
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Buf_B ; адрес выводимой строки
    mov rdx, 4 ; длина строки
    ; вызов системной функции
    syscall


    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Y_text ; адрес выводимой строки
    mov rdx, 8 ; длина строки
    ; вызов системной функции
    syscall  
    
    
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Buf_Y ; адрес выводимой строки
    mov rdx, 4 ; длина строки
    ; вызов системной функции
    syscall

    
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, X_text ; адрес выводимой строки
    mov rdx, 15 ; длина строки
    ; вызов системной функции
    syscall  
    
                            
    mov rax, 1; системная функция 1 (write)
    mov rdi, 1; дескриптор файла stdout=1
    mov rsi, Buf_X ; адрес выводимой строки
    mov rdx, 5 ; длина строки
    ; вызов системной функции
    syscall    
    
    mov rax, 60; системная функция 60 (exit)
    xor rdi, rdi; return code 0
    syscall