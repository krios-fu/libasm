
section .text
	global _ft_strcpy

_ft_strcpy:
			xor		rcx,rcx

while: 
			cmp 	BYTE[rsi + rcx],0
			jz 		return
			mov 	dl, BYTE[rsi + rcx]
			mov 	BYTE[rdi + rcx], dl
			inc 	rcx
			jmp 	while

return:
			mov 	BYTE[rdi + rcx],0
			mov 	rax, rdi
			ret 