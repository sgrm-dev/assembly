global _start

section .text

multiply:

	push rbx
	xor rax, rax
	xor rbx, rbx

	cmp rdi, rsi
	je is_equal
	jg is_max
	jl is_min

is_equal:

	mov rcx, rdi
	mov rax, rdi
	mov rbx, rax
	jmp dec_rcx

is_max:

	mov rcx, rsi ; get the min value
	mov rax, rdi ; get the max value
	mov rbx, rax ; a copy of the max value
	jmp dec_rcx

is_min:

	mov rcx, rdi ; get the min value
	mov rax, rsi ; get the max value
	mov rbx, rax ; a copy of the max value

dec_rcx:

	dec rcx

iterate:

	add rax, rbx
	cmp rcx, 1
	dec rcx
	jne iterate

end:
	
	pop rbx

	ret

; entry point
_start:

	mov rax, 7
	mov rbx, 7

	mov rdi, rax
	mov rsi, rbx

	call multiply

    ; invokes 'exit' syscall
    mov rax, 60
    xor rdi, rdi
    syscall

section .data
demo0: db 0x01
