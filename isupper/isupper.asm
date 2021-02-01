; Marcos Gabriel Santos Rocha
; x86_64 assembly programming

; this program only implements an 'isupper' function
; that is used to check if a byte into a string is an
; uppercase byte. if yes, returns 1, otherwise, returns 0.

section .text
global _start

isupper:
	mov rax, rdi

	cmp al, 0x41
	jae comparison_two
	jmp false

comparison_two:
	cmp al, 0x5a
	jbe true
	jmp false

true:
	mov rax, 0x01
	jmp end

false:
	mov rax, 0x00

end:	
	ret

_start:
	mov rcx, 0x00
	mov rdx, 0x00
	jmp iterate

increment:
	inc rdx

iterate:
	lea rbx, [demo0+rcx]
	mov rdi, [rbx]

	cmp rdi, 0x00
	je exit

	inc rcx

	call isupper

	cmp rax, 0x01
	je increment
	jmp iterate

exit:
	mov rax, 0x3c
	xor rdi, rdi
	syscall

section .data
demo0: db 'Hello, World', 0