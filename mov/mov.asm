; Marcos Gabriel Santos Rocha
; 30/01/2021

; MOV instruction

; a brief description of the MOV instruction

; instruction syntax: 
;	mov <destination_operand>, <source_operand>

; the move instruction copies the value into the source operand
; to the destination operand.

; the destination operand can be
;	. a general purpose register
;	. a segment register
;	. a memory location

; the source operand can be
;   . a general purpose register
;   . a segment register
;   . a memory location
;   . an immediate value

; IMPORTANT: BOTH OPERANDS MUST BE THE SAME SIZE!


global _start


section .text

_start:

	; MOV r/m8, r8 =: move r8 to r/m8

	mov dl, al         ; here we're doing: mov r8/r8
	mov byte[demo], al ; here we're doing: mov m8/r8

	; MOV r/m16, r16 =: move r16 to r/m16

	mov bx, ax		   ; here we're doing: mov r16/r16
	mov word[demo], cx ; here we're doing: mov m16/r16

	; MOV r/m32, r32 =: move r32 to r/m32

	mov eax, edx		 ; here we're doing: mov r32/r32	
	mov dword[demo], esi ; here we're doing: mov m32/r32

	; MOV r/m64, r64 =: move r64 to r/m64

	mov rdx, rax         ; here we're doing: mov r64/r64
	mov qword[demo], rdi ; here we're doing: mov m64/r64

	; some examples using mov instruction

	mov al, 1   ; al = 1 -> ah = 0 -> ax = 1 -> eax = 1 -> rax = 1
	mov ah, 2   ; al = 1 -> ah = 2 -> ax = 513 -> eax = 513 -> rax = 513

	xor rbx, rbx
	xor rcx, rcx
	xor rdx, rdx
	xor rdi, rdi
	xor rsi, rsi

	mov bl, al  ; bl = 1 -> bh = 0 -> bx = 1 -> ebx = 1 -> rbx = 1
	mov cl, al  ; cl = 1 -> ch = 0 -> cx = 1 -> ecx = 1 -> rcx = 1
	mov dl, al  ; dl = 1 -> dh = 0 -> dx = 1 -> edx = 1 -> rdx = 1
	mov dil, al ; dil = 1 -> di = 1 -> edi = 1 -> rdi = 1
	mov sil, al ; sil = 1 -> si = 1 -> esi = 1 -> rdi = 1

	mov rax, 0x3c
	xor rdi, rdi
	syscall

section .data
demo: db 'hello', 0