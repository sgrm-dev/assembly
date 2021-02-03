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


_start:

	mov rdi, char0
	call print_char
	mov rdi, char1
	call print_char
	mov rdi, char2
	call print_char
	mov rdi, char3
	call print_char
	mov rdi, char4
	call print_char
	mov rdi, char5
	call print_char

	call exit

section .data
char0: db 0x41
char1: db 0x42
char2: db 0x43
char3: db 0x44
char4: db 0x45
char5: db 0xa