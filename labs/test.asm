section .bss
	;string resb 2

	
section .text
global _start
_start:
	;mov rax, 'c'
    	;mov r10, al
    	
   	mov rax, 60; системная функция 60 (exit)
    	xor rdi, rdi; return code 0
    	syscall
