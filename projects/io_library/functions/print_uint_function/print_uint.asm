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


print_uint:

	; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ;
	;																			;
	; Function args														;
	;	RDI - an unsigned value											;
	;																			;
	; Function return value(in RAX)									;
	;	this is still undefined											;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	push rbx ; becuse RBX is callee-saved

	xor rax, rax ; RAX = 0
	xor rbx, rbx ; RBX = 0
	xor rcx, rcx ; RCX = 0
	xor rdx, rdx ; RDX = 0

	mov rax, rdi ; dividend
	mov rbx, 0xA ; divisor

	.loopA:

		inc rcx       ; how many digits was written in the stack?
		div rbx       ; RAX = RAX / RBX 
		push rdx      ; the remainder is stored in RDX
		xor rdx, rdx  ; RDX = 0
		cmp rax, 0x0  ; verify if RAX is equal to 0
		jne .loopA    ; continue executing the loop
	
	.loopB:

		add qword [rsp], 48 ; this should be performed to get the ASCII
		                    ; code of the digit in the stack

		mov rdi, rsp        ; pointer to the digit in the stack
		push rcx            ; because print_char changes RCX by executing
								  ; the 'write' syscall

		call print_char     ; invoke the function 'print_char'
		pop rcx             ; get RCX value from the stack
		pop rax             ; remove the digit in the top of the stack
		dec rcx             ; RCX = RCX - 1
		cmp rcx, 0x0        ; verify if RCX is equal to 0
		jne .loopB          ; continue executing the loop 

	pop rbx ; get the last rbx value from the stack
	ret

_start:

	; test cases

	mov rdi, 1844
	call print_uint
	call print_newline

	mov rdi, 2555
	call print_uint
	call print_newline

	mov rdi, 0
	call print_uint
	call print_newline

	mov rdi, 255587398236826
	call print_uint
	call print_newline

	mov rdi, 2555222
	call print_uint
	call print_newline

	mov rdi, 9
	call print_uint
	call print_newline

	mov rdi, 777
	call print_uint
	call print_newline

	mov rdi, 1221278755
	call print_uint
	call print_newline

	mov rdi, 271627
	call print_uint
	call print_newline

	mov rdi, 89796752292
	call print_uint
	call print_newline

	call exit

section .data
newline_char: db 0xA