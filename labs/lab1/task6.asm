%include "lib.asm"

section .data
    inputA db "Input A: ",10;
    message_len equ $-inputA
    inputB db "Input B: ",10;
section .bss
    A resb 10 ; буфер для вводимой строки
    B resb 10 ;
    buf_len equ $-A;
    C resb 10;
section .text

global _start
_start:
     ; input A
     Mov eax, 4 ; системная функция 4 (write)
     mov ebx, 1 ; дескриптор файла stdout=1
     mov ecx, inputA ; адрес выводимой строки
     mov edx, message_len ; длина выводимой строки
     int 80h ; вызов системной функции
 
     ; read A
     mov eax, 3 ; системная функция 3 (read)
     mov ebx, 0 ; дескриптор файла stdin=0
     mov ecx, A ; адрес буфера ввода
     mov edx, buf_len ; размер буфера
     int 80h ; вызов системной функции
     
     ; input B
     Mov eax, 4 ; системная функция 4 (write)
     mov ebx, 1 ; дескриптор файла stdout=1
     mov ecx, inputB ; адрес выводимой строки
     mov edx, message_len ; длина выводимой строки
     int 80h ; вызов системной функции
 
     ; read B
     mov eax, 3 ; системная функция 3 (read)
     mov ebx, 0 ; дескриптор файла stdin=0
     mov ecx, B ; адрес буфера ввода
     mov edx, buf_len ; размер буфера
     int 80h ; вызов системной функции   
 
     ;calc C
 
     mov esi, A
     call StrToInt
     cmp EBX, 0
     jne Error
     mov [A], ax
     
     ;sub esi, '0'
     ;add esi, [B]
     ;mov [C], esi
     
     ;output C
     Mov eax, 4 ; системная функция 4 (write)
     mov ebx, 1 ; дескриптор файла stdout=1
     mov ecx, A ; адрес выводимой строки
     mov edx, 1 ; длина выводимой строки
     int 80h ; вызов системной функции
     ; exit
     mov eax, 1 ; системная функция 1 (exit)
     xor ebx, ebx ; код возврата 0
     int 80h ; вызов системной функции