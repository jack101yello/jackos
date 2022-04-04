; A boot sector that boots a C kernel in a 32-bit protected mode

[org 0x7c00]	; Tell the assembler where to load the boot sector
KERNEL_OFFSET equ 0x1000	; Memory offset for kernel

mov [BOOT_DRIVE], dl

mov bp, 0x9000	; Set up the stack
mov sp, bp

mov bx, MSG_REAL_MODE	; Use BX as a parameter to the function call
call print_string	; Tell the user that we have booted into 16-bit real mode

call load_kernel	; Load the kernel

call switch_to_pm

jmp $	; Hang indefinitely

%include "Printing/print_string.asm"
%include "Disk/diskload.asm"
%include "pm/gdt.asm"
%include "Printing/print_string_pm.asm"
%include "pm/switch_to_pm.asm"

[bits 16]

load_kernel:
	mov bx, MSG_LOAD_KERNEL	; Announce that we are loading the kernel
	call print_string

	; The following code was found on stackoverflow, and is currently being tested
	;mov ax, KERNEL_OFFSET	; The address to read into
	;mov es, ax	; Move the value to es
	;xor bx, bx	; Clear bx register
	;mov ah, 0x02	; Floppy function
	;mov al, 1	; Read 1 sector
	;mov ch, 0	; Cylinder 0
	;mov cl, 2	; Sector to read
	;mov dh, 0	; Head number
	;mov dl, 0	; Drive number

	; The following code is from the tutorial, but it seems to not work.
	mov bx, KERNEL_OFFSET
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call disk_load
	ret

[bits 32]

BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_string_pm

	call KERNEL_OFFSET	; Move to where the kernel is and pray

	jmp $

; Data
BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

times 510-($-$$) db 0	; Padding
dw 0xaa55	; Magic number to denote boot sector
