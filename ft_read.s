
section .data
%define SYS_READ 0x02000003

section .text
	global _ft_read	

_ft_read:
			mov		rax, SYS_READ
			syscall
	ret