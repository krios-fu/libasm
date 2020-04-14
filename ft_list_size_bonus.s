section .text
	global	_ft_list_size_bonus

_ft_list_size_bonus:									; t_list begin_list = RDI
						xor		rax, rax				; count = 0
						push	rdi						; salvamos en la pila RDI
						jmp 	while					; saltamos al ciclo

count:
						inc		rax						; incrementamos el contador
while:
						cmp		rdi, 0					; begin_list = NULL
						jz		return					; si es igual retornamos
						mov		rdi, [rdi + 8]			; begin_list = begin_list.next
						jmp		count
return:
						pop		rdi						; recuperamos el principio de rdi
						ret								; retornamos RAX