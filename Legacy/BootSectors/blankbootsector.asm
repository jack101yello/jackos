; Basic boot sector program written in assembly
loop: ; A label that allows us to go indefinitely
	jmp loop ; Recursively runs itself forever
times 510-($-$$) db 0 ; Pads with zeroes
dw 0xaa55 ; Magic number to denote boot sector
