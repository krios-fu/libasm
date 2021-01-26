section .text
    global	_ft_list_size

_ft_list_size:                                    
                        xor     rax, rax                
                        push    rdi                     
                        jmp     while                   

count:
                        inc     rax                     
while:
                        cmp     rdi, 0                  
                        jz      return                 
                        mov     rdi, [rdi + 8]          
                        jmp     count
return:
                        pop     rdi                     
                        ret                             
