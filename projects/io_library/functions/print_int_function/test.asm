global _start

section .text
_start:
   
   mov rax, -20
   mov rbx, 10
   mov rcx, -1
   mul rcx
   div rbx

   mov rax, 0x3c
   xor rdi, rdi
   syscall
