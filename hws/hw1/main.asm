; Дан текст, состоящий из слов, 
; разделенных несколькими пробелами. Определить количество 
; согласных букв в каждом слове и количество гласных во всем тексте.

%include "../lib64.asm"

section .data
    InputText db "Input string of words, separated by spaces: ", 10, 13;
    TextLen equ $-InputText;
    InWord db "The number of not vowels in each word: ", 10, 13
    InWordLen equ $-InWord
    InText db "The number of vowels in the text: ", 10, 13
    InTextLen equ $-InText
    space db " ", 10
    enter_key db 10, 13
section .bss
    string resb 255
    buf resb 1
    number_of_vowels resb 1
    number_of_not_vowels resb 1
section .text

global _start

_start:
    mov eax, 1;write
    mov edi, 1;stdout=1
    mov esi, InputText 
    mov edx, TextLen ; длина строки
    syscall 

    mov eax, 0; read
    mov edi, 0; stdin=0
    mov esi, string; адрес вводимой строки
    mov edx, 255; buf len
    syscall

    push rsi
    mov eax, 1;write
    mov edi, 1;stdout=1
    mov esi, InWord 
    mov edx, InWordLen ; длина строки
    syscall
    pop rsi

    mov ecx, 255;
    mov edi, 0 ; register for counting vowels
    mov edx, 0; register for counting not vowels
    cycle:
        lodsb ; takes from register esi and puts 1 byte in eax
        push rsi ;rsi is in safe
        cmp eax, 10 ;the byte is in eax
            je print_number_of_vowels
        cmp eax, 32
            je print_number_of_not_vowels
        after_not_vowels:
            mov [buf], eax ;symbol in buf
            push rdx ;because rdx is for counting vowels
            call is_vowel ;here ebx and edx are used, but rdx is in stack
            pop rdx
            add edi, ebx ;adding the result of ebx to edi, which is for counting vowels
            cmp ebx, 0 ;if ebx = 0 (if the symbol is not a vowel)
                je add_not_vowel ;only edx is used here, it increases edx if not vowel
            after_cmp:
                pop rsi ;take rsi from stack
                jmp cycle 

add_not_vowel:
    inc edx ;counts not vowels
    jmp after_cmp

call_vowels:
    call print_number_of_not_vowels
    ret
print_number_of_not_vowels:
    push rdi
    mov esi, number_of_not_vowels
    mov eax, edx
    call IntToStr64

    mov edx, eax ; длина строки
    mov eax, 1;write
    mov edi, 1;stdout=1
    mov esi, number_of_not_vowels 
    syscall 

    pop rdi
    mov edx, 0 
    jmp after_cmp

print_number_of_vowels:
    push rdi
    mov eax, 1;write
    mov edi, 1;stdout=1
    mov esi, InText
    mov edx, InTextLen ; длина строки
    syscall
    pop rdi

    mov esi, number_of_vowels
    mov eax, edi
    call IntToStr64

    mov edx, eax; длина строки
    mov eax, 1;write
    mov edi, 1;stdout=1
    mov esi, number_of_vowels 
    
    syscall 
    
    jmp exit

is_vowel:
    mov ebx, 0
    mov edx, [buf]
    cmp edx, "a"
        je make_true
    cmp edx, "i"
        je make_true
    cmp edx, "o"
        je make_true
    cmp edx, "e"
        je make_true
    cmp edx, "y"
        je make_true
    cmp edx, "u"
        je make_true
    ret

make_true:
    mov ebx, 1
    ret

exit:
    mov rax, 60;
    xor rdi, rdi; return code 0
    syscall
