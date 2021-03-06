; author: Marcos Gabriel Santos Rocha
; e-mail: mgabrielifnmg@gmail.com
; github: sgrm-dev 

section .text

exit:

	; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ;
	;                                                        ;                                                
	; Function args                                          ;
	;	1) status_code (in RDI)                          ; 
	; Function return value                                  ;
	;  this function doesn't return any value                ;
	;                                                        ;
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
	;                                                        ;                                                
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


print_string:

	; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ; 
	;                                                        ;  	
	; Function args						 ;
	;  RDI - pointer to a string terminated with the byte 0x0;
	; 							 ;											;
	; Function return value(in RAX)				 ;
	;  This function returns the bytes written in stdout.    ;
	;  Otherwise, returns -1.				 ;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	call string_length ; get the string length

	mov rdx, rax ; string length
	mov rsi, rdi ; string pointer
	mov rdi, 0x1 ; stdout file descriptor

	mov rax, 0x1 ; 'write' syscall identifier
	syscall      ; invoke the 'write' syscall

	ret


print_char:

	; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ; 
	;                                                        ;  	
	; Function args						 ;
	;  RDI - pointer to a single byte                        ;
	; 						         ;													;
	; Function return value(in RAX)				 ;
	;  This function returns 1 in case of success. Otherwise,;
	;  returns -1.					         ;
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
	; Function args					         ;
	;  This function doesn't require any argument            ;
	; 						         ;
	; Function return value(in RAX)				 ;
	;  This function returns 1 in case of success. Otherwise,;
	;  returns -1.					         ;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov rdi, newline_char
	call print_char

	ret


print_uint:

	; ------------------------------------------------------ ;
	;                     DESCRIPTION                        ;
	; ------------------------------------------------------ ;
	;							 ;												;
	; Function args						 ;
	;  RDI - an unsigned value				 ;
	;							 ;												;
	; Function return value(in RAX)				 ;
	;  this is still undefined				 ;
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

print_int:

	xor rax, rax
	xor rbx, rbx
	push rbx

	cmp rdi, 0x0
	jl .to_unsigned
	jge .print

	.to_unsigned:

      mov rax, rdi
      mov rbx, -1
      imul rbx
      mov rdi, rax

   .write_signal:

		push rdi
		mov rdi, minus_signal_byte
		call print_char
		pop rdi

	.print:

		call print_uint
		
	pop rbx
	ret


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

section .data
newline_char: db 0xA
<<<<<<< HEAD
minus_signal_byte: db 0x2D
=======
>>>>>>> b398b5ab8ad685cdb3a46d1c4c0912c4df6fa878
