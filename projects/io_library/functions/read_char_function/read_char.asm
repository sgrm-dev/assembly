global _start

section .text
read_char:

	mov rax, 0x0
	mov rdi, 0x0
	mov rsi, byte_pointer
	mov rdx, 0x1
	syscall

	cmp rax, -1
	je .eof
	jmp .not_eof

	.eof:
		mov rax, 0
		jmp .end

	.not_eof:	
		mov rax, [rsi]

	.end:
		ret

_start:

	call read_char 

	mov rax, 0x3c
	xor rdi, rdi
	syscall

section .data
byte_pointer: db 0x0