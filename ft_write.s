section .data
				%define SYS_WRITE 0x02000004

section .text          
				EXTERN ___error
				global	_ft_write
_ft_write:
				mov		rax, SYS_WRITE
				syscall					
				jc		error
				ret
error:
				push	r11
				mov		r10, rax		
				call	___error
				mov		[rax], r10	
				mov		rax, -1
				pop		r11
				ret