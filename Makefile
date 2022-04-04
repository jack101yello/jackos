all: os-image

os-image: boot_sect.bin kernel.bin
	cat $^ > os-image

kernel.bin: kernel_entry.o kernel.o
	ld -melf_i386 -o kernel.bin -Ttext 0x1000 $^ --oformat binary

kernel.o : kernel.c
	gcc -fno-pie -ffreestanding -m32 -c $< -o $@

kernel_entry.o : kernel_entry.asm
	nasm $< -f elf -o $@

boot_sect.bin : boot_sect.asm
	nasm $< -f bin -o $@

clean:
	rm -fr *.bin *.dis *.o os-image *.map

kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@