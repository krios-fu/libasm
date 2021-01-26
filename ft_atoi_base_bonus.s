section .text
	global 		_ft_atoi_base
	extern 		_ft_strlen

_ft_atoi_base:								
					xor		rax, rax				
					xor		rcx, rcx				
					xor		r8,  r8					
					xor		r9,  r9					
					xor		r10, r10				
					xor		r12, r12				

len_base:
					push	rdi						
					mov		rdi, rsi				
					call	_ft_strlen				
					pop		rdi						
					mov		rcx, rax				 
					cmp		rcx, 1					
					jz		error_base
					cmp		rcx, 0
					jz		error_base
					jmp		cmp_base_while1			

inc_count_i:
					inc		r12

cmp_base_while1:
					xor		r8,  r8					
					add		r8,  r12				
					inc		r8						
					cmp		BYTE [rsi + r12], 0		
					jnz		cmp_base_while2			 
					xor		r12, r12				
					xor		r8,  r8
					jmp		cmp_bases_space			
inc_count_j:
					inc		r8

cmp_base_while2: 
					mov		dl, BYTE [rsi + r12]	
					cmp		dl, BYTE [rsi + r8]		
					je		error_base
					cmp		BYTE [rsi + r8], 0		
					jz		inc_count_i				 
					jmp		inc_count_j

inc_count_space:
					inc		r12
cmp_bases_space:									; ``+''  ``-''   ``\t''   ``\n''    ``\v''    ``\f''    ``\r''    `` ''
					cmp		BYTE [rsi + r12], 32 
					je		error_base
					cmp		BYTE [rsi + r12], 43	
					je		error_base
					cmp		BYTE [rsi + r12], 45	
					je		error_base
					cmp		BYTE [rsi + r12], 9		
					je		error_base
					cmp		BYTE [rsi + r12], 10	
					je		error_base
					cmp		BYTE [rsi + r12], 13	
					je		error_base
					cmp		BYTE [rsi + r12], 11	
					je		error_base
					cmp		BYTE [rsi + r12], 12	
					je		error_base
					cmp		r12, rcx
					jne		inc_count_space
					xor		r12, r12
					jmp		next_space
							
inc_pointer:
					inc		rdi
next_space:											; ``\t''   ``\n''    ``\v''    ``\f''    ``\r''    `` ''
					cmp		BYTE[rdi], 9
					je		inc_pointer
					cmp		BYTE[rdi], 10
					je		inc_pointer
					cmp		BYTE[rdi], 11
					je		inc_pointer
					cmp		BYTE[rdi], 12
					je		inc_pointer
					cmp		BYTE[rdi], 13
					je		inc_pointer
					cmp		BYTE[rdi], 32
					je		inc_pointer
					jmp		cmp_minus

count_minus:
					xor		r10, 0x00000001			; bandera signo 0 positivo 1 negativo; 0 * 0 = 0; 0 * 1 = 1; 1 * 1 = 0
next:
					inc 	rdi						
cmp_minus:											
					cmp		BYTE[rdi], 45
					je 		count_minus
					cmp 	BYTE[rdi], 43
					je 		next
					xor		r12, r12				
					xor		rax, rax
					jmp 	str_while_count

flag:
					inc		r9						
atoi_count_x:
					inc		r12
str_while_count:									 
					xor		r8,  r8
					cmp		BYTE [rdi + r12], 0
					jnz		base_while_count					
					xor		r12, r12
					dec		r9						; flag-- 
					jmp		str_while				
atoi_count_y:
					inc		r8
base_while_count: 		
					mov		dl,  BYTE [rdi + r12]	
					cmp		dl,  BYTE [rsi + r8]	
					je		flag
					cmp		BYTE [rsi + r8], 0
					jnz		atoi_count_y
					xor		r12, r12				
					dec		r9						 
					jmp		str_while				 

atoi_mul:											
					mul		rcx						
atoi_count_i:
					inc		r12
str_while:											 
					xor		r8,  r8
					cmp		r12, r9	
					jle		base_while
					jmp		return					
atoi_count_j:
					inc		r8
base_while:
					mov		dl, BYTE [rdi + r12]	
					cmp		dl, BYTE [rsi + r8]	
					je		atoi
					cmp		BYTE [rsi + r8], 0
					jnz		atoi_count_j
					jmp		return					 

error_base:
					mov		rax, 0					
					ret								
atoi:				
					add		rax, r8					
					cmp		r12, r9									
					jl		atoi_mul				; (r12 < r9)  
return:												;  (r12 == r9)
					cmp		r10, 0x00000001			 
					je		is_neg					; r10 == 1 
					ret								
is_neg:
					neg		rax						
					ret							
