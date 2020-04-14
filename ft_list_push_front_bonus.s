section .text
	global _ft_list_push_front_bonus
	extern	_malloc

_ft_list_push_front_bonus:                          ; rdi = t_list **begin, rsi = void *data
                        push    rsp
                        push    rdi                 ; Subimos de la pila (guardamos) t_list (rdi) y data (rsi)
                        push    rsi
                        mov     rdi, 16             ; Asignamos 16 "byte"
                        xor     rax, rax            ; RAX = 0 alli se retorna la reserva de memoria  
                        call    _malloc             ; Malloc(sizeof(t_list)) * (16)
                        pop     rsi                 ; Bajamos de la pila t_list (rdi) y data (rsi)
                        pop     rdi
                        cmp     rax, 0              ; Verificamos que se haya hecho la reserva de la memoria 
                        jz      return              ; Si el valor es igual a 0 retornamos por defecto RAX 
                        mov     [rax], rsi          ; RAX es nuestro nuevo elemento creado y guardamos el valor de data (rsi) new.data = data
                        mov     rcx, [rdi]          ; Regla de 3 : 1 copiamos a RCX "t_list original" 
                        mov     [rax + 8], rcx      ; 2: El elemento nuevo  byte + 8 copiamos RCX  new.next = *begin
                        mov     [rdi], rax          ; 3: y por ultimo reescribimos la lista  *begin = new

return:
                        pop rsp
                        ret