
section .text
	global _ft_strlen

_ft_strlen:
			xor		rax, rax

while:
			cmp		BYTE[rdi + rax], 0
			je		return 
			add		rax, 1
			jmp		while
return:
			ret 
