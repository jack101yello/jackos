print_string:
	pusha
	mov ah, 0x0e
	jmp print_string_loop

print_string_loop:
	mov al, [bx]
	cmp al, 0
	je print_string_done
	int 0x10
	add bx, 1
	jmp print_string_loop

print_string_done:
	popa
	ret
