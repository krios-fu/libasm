
section .text
    global _ft_strcmp

_ft_strcmp:
            xor     rcx, rcx 
            xor     rax, rax
            jmp     while

count:
            inc     rcx

while:
            cmp     BYTE[rdi + rcx], 0
            jz      cmp_byte
            cmp     BYTE[rsi + rcx], 0
            jz      cmp_byte
            mov     dl, BYTE[rdi + rcx]
            cmp     dl, BYTE[rsi + rcx]
            je      count

cmp_byte:
            mov		dl, BYTE [rdi + rcx]	
			sub		dl, BYTE [rsi + rcx]	
			cmp		dl, 0				
			jz		equal
			jl		minor
            jg      major
major:
			mov		rax, 1
			ret
minor:
			mov		rax, -1	
			ret
equal:
			mov		rax, 0
			ret
            