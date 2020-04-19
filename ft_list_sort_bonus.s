section .text
    global _ft_list_sort_bonus

_ft_list_sort_bonus:                                        ; t_list **begin, rsi = _funcion
                        push	rbx	                        ; RBX = será list->next;
                        push	r12                         ; R12 = guardará el inicio de la lista
                        cmp		rdi, 0                      ; Verificamos que la lista no esté vacia
                        jz		finish                      ; Igual a cero finalizamos
                        cmp		rsi, 0				        ; Verificamos la existencia de una funcion
                        jz		finish                      ; Igual a cero finalizamos
                        mov		r12, [rdi]                  ; Guardamos el inicio de la lista
                        mov		rcx, [rdi]                  ; Copiamos la direccion de rdi
                        mov		rbx, [rcx + 8]              ; Guardamos el siguiente elemento.  RBX = list->next;
                        jmp     compare_start

element_base:
                        mov     rcx, [rdi]                  ; RDI es el elemento base de comparación
                        mov     rbx, [rcx + 8]
                        mov     [rdi], rbx
                        cmp		QWORD [rdi], 0              ; verificamos que no sea el fin de la lista
                        jz		return             

compare_start:  
                        push    rdi                         ; Guardamos en la pila RDI Y RSI
                        push    rsi
                        mov     rax, rsi                    ; Copiamos la funcion (*cmp)(rdi, rsi)
                        mov     rcx, [rdi]                  ; Copiamos begin->data 
                        mov     rdi, [rcx]                  ; Reescribimos RDI = begin->data ej: [0] = 8
                        mov     rsi, [rbx]                  ; Reescribimos RSI con begin->data del elemento siguiente [1] = 4
                        call    rax                         ; Llamamos la funcion (*cmp)(RDI, RSI) RAX = (*cmp)(RDI, RSI)
                        pop     rsi                         ; Recuperamos la funcion (*cmp)
                        pop     rdi                         ; Recuperamos el elemento base
                        cmp     rax, 0                      
                        jg      ft_swap                     ; [0] = 8 > [1] = 4 si se cumple la condicion saltamos a ft_swap
                       
next_element:                       
                        mov     rcx, [rbx + 8]              ; si no se cumple avanzamos al siguien elemento para comparar con el elemento base 
                        mov     rbx, rcx
                        cmp     rbx, 0                      ; Verificamos que no sea el fin de la lista  
                        jz      element_base                ; si es el fin de la lista avanzamos el elemento base
                        jmp     compare_start               ; sino volvemos a comparar

ft_swap:
                        mov     r8, [rdi]
                        mov     rcx, [r8]                   ; RCX = elemento mayor
                        mov     rax, [rbx]                  ; RAX = elemto menor
                        mov     [r8], rax                   ; [r8] apunta a la direccion del elemento mayor y alli copiamos el elemento menor
                        mov     [rbx], rcx                  ; [rbx] apunta a la direccion del elemento menor y alli copiamos el elemento mayor
                        jmp     next_element                ; continuamos con la comparación

return:                     
                        mov     [rdi], r12                  ; Volvemos al principio de la lista
finish:
                        pop		r12
                        pop		rbx					
                        ret
