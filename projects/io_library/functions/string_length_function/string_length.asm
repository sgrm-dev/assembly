global _start

section .text

string_length:

   ; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ;
	;                                                        ;                                                ;
	; Function args                                          ;
	;  RDI - pointer to a string terminated with the byte 0x0;
	;                                                        ; 
	; Function return value (in RAX)                         ;
	;  this function returns the length of the given string  ;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	xor rax, rax ; RAX = 0

	.loop:

		cmp byte [rdi+rax], 0x0 ; verify if a byte from the given string
		                        ; is the byte 0x0
		je .end
		inc rax
		jmp .loop

	.end:

		ret ; return the length of the given string

_start:

	mov rdi, string ; string pointer

	call string_length

	mov rax, 0x3c
	xor rdi, rdi
	syscall

section .data
string: db 0x0