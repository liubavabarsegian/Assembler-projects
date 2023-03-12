section .data ; сегмент инициализированных переменных
    ExitMsg db "Press Enter to Exit",10 ; выводимое сообщение
    lenExit equ $-ExitMsg
    A dw -30
    B dw 21
    val	db 255
    chart dw 256
    lue3	dw -128
    v5 db 10h
    db 100101B
    beta db 23,23h,0ch
    sdk db "Hello",10
    min dw -32767
    ar dd 12345678h
    valar times 5 db 8
    integer dw 25
    negative_word dd -35
    my_name db "Люба Барсегян", "Liuba Barsegian"
    
    var_1 dw 37
    var_2 dd 37
    var_3 db 37
    var_4 db "%"
    var_5 dw "%"
    var_6 dw 25h
    var_7 dw 100101b
    
    var_8 dw 9472
    var_9 dd 9472
    var_10 dw 10010100000000b
    var_11 dw 2500h
    
    F1 dw 65535
    F2 dd 65535
    
    A_positive dw 5
    A_negative dw -5
 section .bss ; сегмент неинициализированных переменных
    InBuf resb 10 ; буфер для вводимой строки
    lenIn equ $-InBuf
    X resd 1
    alu	resw 10
    f1 resb 5
 section .text ; сегмент кода

 global _start
_start:
     ; write
     Mov eax, 4 ; системная функция 4 (write)
     mov ebx, 1 ; дескриптор файла stdout=1
     mov ecx, ExitMsg ; адрес выводимой строки
     mov edx, lenExit ; длина выводимой строки
     int 80h ; вызов системной функции
     ;calculate X
     mov EAX,[A] ; загрузить число A в регистр EAX
     add EAX,5
     sub EAX,[B] ; вычесть число B, результат в EAX
     mov [X],EAX ;
     ;add f1 + 1
     add WORD[F1],1
     ;add f2 + 1
     add DWORD[F2],1
     ;put 5 to AX
     mov eax, 5
     ;put -5 to AX
     mov eax, -5
     ; read
     mov eax, 3 ; системная функция 3 (read)
     mov ebx, 0 ; дескриптор файла stdin=0
     mov ecx, InBuf ; адрес буфера ввода
     mov edx, lenIn ; размер буфера
     int 80h ; вызов системной функции
     ; exit
     mov eax, 1 ; системная функция 1 (exit)
     xor ebx, ebx ; код возврата 0
     int 80h ; вызов системной функции