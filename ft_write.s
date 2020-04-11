
section .data
%define SYS_WRITE 0x02000004

section	.text
	global _ft_write

_ft_write:
			mov		rax, SYS_WRITE
			syscall
			ret
