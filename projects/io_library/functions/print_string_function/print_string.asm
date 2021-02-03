global _start

section .text

exit:

	; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ;
	;                                                        ;                                                ;
	; Function args                                          ;
	;	RDI - status_code                                     ;
	; 																			; 
	; Function return value (in RAX)                         ;
	;  this function doesn't return any value                ;
	;                                                        ;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; The 'exit' function terminate the calling proccess and ;
	; returns the 'status_code' in the RDI register to the   ;
	; operating system.                                      ;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	mov rax, 0x3c ; 'exit' syscall identifier
	syscall       ; invoke the 'exit' syscall

string_length:

   ; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ; 
	;                                                        ;                                                ;
	; Function args                                          ;
	;  RDI - pointer to a string terminated with the byte 0x0;
	;                                                        ; 
	; Function return value(in RAX)                          ;
	;  This function returns the length of the given string. ;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	xor rax, rax ; RAX = 0

	.loop:

		cmp byte [rdi+rax], 0x0 ; verify if a byte from the given string
		                        ; is the byte 0x0
		je .end
		inc rax
		jmp .loop

	.end:

		ret


print_string:

	; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ; 
	;                                                        ;  	
	; Function args														;
	;	RDI - pointer to a string terminated with the byte 0x0;
	; 																			;
	; Function return value(in RAX)								   ;
	;	This function returns the bytes written in stdout.    ;
	;  Otherwise, returns -1.											;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	call string_length ; get the string length

	mov rdx, rax ; string length
	mov rsi, rdi ; string pointer
	mov rdi, 0x1 ; stdout file descriptor

	mov rax, 0x1 ; 'write' syscall identifier
	syscall      ; invoke the 'write' syscall

	ret

_start:

	mov rdi, string

	call print_string
	call exit

section .data
string: db 0xa, 0x0