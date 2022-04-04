all: os-image
 
os-image: boot_sect.bin kernel.bin
	cat $^ > os-image
 
kernel.bin: kernel.elf
	objcopy -O binary $< $@
 
kernel.elf: kernel_entry.o kernel.o
	ld -melf_i386 -o $@ -Ttext 0x1000 $^
 
kernel.o : kernel.c
	gcc -fno-pie -ffreestanding -m32 -c $< -o $@
 
kernel_entry.o : kernel_entry.asm
	nasm $< -f elf -o $@
 
boot_sect.bin : boot_sect.asm
	nasm $< -f bin -o $@
 
clean:
	rm -fr *.bin *.o os-image *.map *.elf