; Load DH sectors to ES:BX from drive DL
disk_load:
	push dx
	mov ah, 0x02	; bios read sector function
	mov al, dh	; Read DH sectors
	mov ch, 0x00	; Select cylinder 0
	mov dh, 0x00	; Select head 0
	mov cl, 0x02	; Start reading from the second sector
	int 0x13
	jc disk_error	; Jump if there was an error
	pop dx
	cmp dh, al
	jne disk_error
	ret

disk_error:
	mov bx, DISK_ERROR_MSG
	call print_string
	jmp $

; Data
DISK_ERROR_MSG db "Disk read error!", 0
