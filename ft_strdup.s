section .text
    global  _ft_strdup
    extern  _malloc
    extern  _ft_strcpy
    extern  _ft_strlen

_ft_strdup:

            call     _ft_strlen
            inc     rax
            
            push    rdi
            mov     rdi, rax
            call    _malloc
            pop     rdi
            cmp     rax, 0
            jz      ret_null
            
            mov     rsi, rdi
            mov     rdi, rax
            call     _ft_strcpy
            ret

ret_null: 
        xor rax, rax
        ret
