section .text
    global _ft_list_sort

_ft_list_sort:          cmp     BYTE[rdi], 0
                        je      return2                    
                        push    rbx                         
                        push    r12                         
                        cmp     rdi, 0                     
                        jz      finish                      
                        cmp     rsi, 0                      
                        jz      finish                     
                        mov     r12, [rdi]                  
                        mov     rcx, [rdi]                  
                        mov     rbx, [rcx + 8]             
                        jmp     compare_start

element_base:
                        mov     rcx, [rdi]                  
                        mov     rbx, [rcx + 8]
                        mov     [rdi], rbx
                        cmp     QWORD [rdi], 0              
                        jz      return             

compare_start:  
                        push    rdi                        
                        push    rsi
                        mov     rax, rsi                    
                        mov     rcx, [rdi]                   
                        mov     rdi, [rcx]                  
                        mov     rsi, [rbx]                  
                        call    rax                        
                        pop     rsi                         
                        pop     rdi                         
                        cmp     rax, 0                      
                        jg      ft_swap                     

next_element:                       
                        mov     rcx, [rbx + 8]               
                        mov     rbx, rcx
                        cmp     rbx, 0                        
                        jz      element_base                
                        jmp     compare_start               

ft_swap:
                        mov     r8, [rdi]
                        mov     rcx, [r8]                   
                        mov     rax, [rbx]                  
                        mov     [r8], rax                   
                        mov     [rbx], rcx                  
                        jmp     next_element               

return:
                        mov     [rdi], r12                  

finish:
                        pop     r12
                        pop     rbx					
                        ret
return2:
                        ret
