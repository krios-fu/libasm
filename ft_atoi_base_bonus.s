section .text
	global 		_ft_atoi_base_bonus
	extern 		_ft_strlen

_ft_atoi_base_bonus:													; resteamos los distintos contadores == 0
					xor		rax, rax									; total
					xor		rcx, rcx									; contador longitud base
					xor		r8,	 r8										; contador while
					xor		r9,  r9										; contador longitud numero a convertir
					xor 	r10, r10									; bandera signo 0 positivo 1 negativo
					xor		r12, r12									; contador while

len_base:
					push	rdi											; guardamos en la pila str
					mov		rdi, rsi									; copiamos base a rdi, rdi es el argumento que recibe ft_strlen
					call	_ft_strlen									; calculamos la longitud, El valor retornado queda en RAX
					pop		rdi											; recuperamos la cadena str
					mov		rcx, rax									; gurdamos la longitud en rcx 
					cmp		rcx, 1										; verifiamos la longitud 
					jz		error_base
					cmp		rcx, 0
					jz 		error_base
					jmp		cmp_base_while1								; saltamos a comparar la base con si misma, caracteres no repetidos 

inc_count_i:
					inc 	r12

cmp_base_while1:
					xor		r8,  r8										; j = 0
					add		r8,  r12									; j += i
					inc		r8											; j ++
					cmp		BYTE [rsi + r12], 0							; base [j] != '\0'
					jnz		cmp_base_while2								; saltamos al segundo ciclo 
					xor		r12, r12									; sino se cumple el salto reseteamos contadores
					xor		r8,  r8
					jmp		cmp_bases_space								; y saltamos a comparar los isspace ``\t''   ``\n''    ``\v''    ``\f''    ``\r''    `` ''
inc_count_j:
					inc		r8

cmp_base_while2: 
					mov		dl, BYTE [rsi + r12]						; copiamos a tmp el caracter base [j]
					cmp		dl, BYTE [rsi + r8]							; comparamos base [j] ==  base [i] ; i = j + 1
					je		error_base
					cmp		BYTE [rsi + r8], 0							; final de la cadena base
					jz		inc_count_i									; incrementamos contadores 
					jmp		inc_count_j

inc_count_space:
					inc		r12
cmp_bases_space:														; ``+''  ``-''   ``\t''   ``\n''    ``\v''    ``\f''    ``\r''    `` ''
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
					inc 	rdi
next_space:																; ``\t''   ``\n''    ``\v''    ``\f''    ``\r''    `` ''
					cmp 	BYTE[rdi], 9
					je 		inc_pointer
					cmp 	BYTE[rdi], 10
					je 		inc_pointer
					cmp 	BYTE[rdi], 11
					je 		inc_pointer
					cmp 	BYTE[rdi], 12
					je 		inc_pointer
					cmp 	BYTE[rdi], 13
					je 		inc_pointer
					cmp 	BYTE[rdi], 32
					je 		inc_pointer
					jmp 	cmp_minus

count_minus:
					xor		r10, 0x00000001							; bandera signo 0 positivo 1 negativo; 0 * 0 = 0; 0 * 1 = 1; 1 * 1 = 0
next:
					inc 	rdi										; incrementamos str++
cmp_minus:															; ciclo mientras sea - o +
					cmp		BYTE[rdi], 45
					je 		count_minus
					cmp 	BYTE[rdi], 43
					je 		next
					xor		r12, r12								; reseteamos valores 
					xor		rax, rax
					jmp 	str_while_count

flag:
					inc		r9										; calculamos longitud numero a convertir, lo utilizamos como banedera 
atoi_count_x:
					inc 	r12
str_while_count:													; hay dos posibles salidas del ciclo 
					xor		r8,  r8
					cmp		BYTE [rdi + r12], 0	
					jnz		base_while_count						
					xor		r12, r12
					dec		r9										; flag-- 
					jmp		str_while								; salida 1: fin de cadena str
atoi_count_y:
					inc		r8
base_while_count: 		
					mov		dl,  BYTE [rdi + r12]	
					cmp		dl,  BYTE [rsi + r8]	
					je		flag
					cmp		BYTE [rsi + r8], 0
					jnz		atoi_count_y
					xor		r12, r12								; reseteamos contador
					dec		r9										; flag-- 
					jmp		str_while								; salida 2: el caracter no se encuentra en la base 

atoi_mul:															; atoi
					mul		rcx										; RAX * RCX (RCX = LONGITUD BASE)
atoi_count_i:
					inc 	r12
str_while:															; hay 3 posibles salidas del ciclo 
					xor		r8,  r8
					cmp     r12, r9	
					jle		base_while
					jmp		return									; salida 1: fin de cadena 
atoi_count_j:
					inc		r8
base_while: 		
					mov		dl, BYTE [rdi + r12]	
					cmp		dl, BYTE [rsi + r8]	
					je		atoi
					cmp		BYTE [rsi + r8], 0
					jnz		atoi_count_j
					jmp		return									; salida 2: caracter no encontrado en la base 

error_base:
					mov 	rax, 0									; RAX = 0
					ret												; RETURN RAX por defecto
atoi:				
					add		rax, r8									; RAX += R8 (R8 = posicion del caracter en la base)
					cmp     r12, r9									
					jl      atoi_mul								; (r12 < r9) saltamos a multiplicar sino caemos en return 
return:																; salida 3: (r12 == r9)
					cmp 	r10, 0x00000001							; verificamos que el numero se par o impar
					je		is_neg									; r10 == 1 saltamo a convertir a negativo sino
					ret 											; retornamos positivo
is_neg:
					neg rax											; convertimos a negativo
					ret												; retornamos negativo 