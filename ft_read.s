section .data
%define SYS_READ 0x02000003
			
section .text
			EXTERN ___error
			global	_ft_read
_ft_read:
            mov		rax, SYS_READ
			syscall				
			jc		error
			ret
error:	
            push    r11
            mov		r10, rax	
			call	___error	
			mov		[rax], r10		
			mov		rax, -1
            pop     r11
			ret