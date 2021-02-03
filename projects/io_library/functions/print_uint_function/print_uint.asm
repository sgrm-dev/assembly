global _start

section .text
exit:

	; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ;
	;                                                        ;                                                ;
	; Function args                                          ;
	;	1) status_code (in RDI)                               ; 
	; Function return value                                  ;
	;  this function doesn't return any value                ;
	;                                                        ;
	; The 'exit' function terminate the calling proccess and ;
	; returns the 'status_code' in the RDI register to the   ;
	; operating system.                                      ;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	mov rax, 0x3c ; 'exit' syscall identifier
	syscall       ; invoke the 'exit' syscall


print_char:

	; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ; 
	;                                                        ;  	
	; Function args														;
	;	RDI - pointer to a single byte                        ;
	; 																			;
	; Function return value(in RAX)								   ;
	;	This function returns 1 in case of success. Otherwise,;
	;  returns -1.															;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov rdx, 0x1 ; a single byte will be printed
 	mov rsi, rdi ; byte pointer
	mov rdi, 0x1 ; stdout file descriptor

	mov rax, 0x1 ; 'write' syscall identifier
	syscall      ; invoke the 'write' syscall

	ret

print_newline:

	; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ; 
	;                                                        ;  	
	; Function args														;
	;	This function doesn't require any argument            ;
	; 																			;
	; Function return value(in RAX)								   ;
	;	This function returns 1 in case of success. Otherwise,;
	;  returns -1.															;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov rdi, newline_char
	call print_char

	ret

; BUG here!!!

print_uint:

	push rbx

	xor rax, rax
	xor rbx, rbx
	xor rcx, rcx

	mov rax, rdi
	mov rbx, 0xA

	.loopA:

		inc rcx
		div qword rbx
		push rdx
		xor rdx, rdx
		cmp rax, 0x0
		jne .loopA

	xor rax, rax
	
	.loopB:

		add qword [rsp], 48
		mov rdi, rsp
		push rcx
		call print_char
		pop rcx
		pop rax
		dec rcx
		cmp rcx, 0x0
		jne .loopB

	pop rbx
	ret

_start:

	mov rdi, 18446744073709551615
	call print_uint
	call print_newline

	call exit

section .data
newline_char: db 0xA