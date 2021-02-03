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

_start:
	mov rdi, 0xfe
	call exit