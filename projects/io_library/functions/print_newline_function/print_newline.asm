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

	mov rdi, newline_char
	call print_char

	ret

_start:

	call print_newline
	call print_newline
	call print_newline
	call print_newline
	call print_newline
	call exit

section .data
newline_char: db 0xA