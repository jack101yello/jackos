C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h)

OBJ = ${C_SOURCES:.c=.o cpu/interrupt.o} # Convert the .c filesnames to .o

all: os-image
 
os-image: boot/boot_sect.bin kernel.bin # Generate the os-image
	cat $^ > os-image

kernel.bin: kernel/kernel.elf # Generate the kernel binary
	objcopy -O binary $< $@

kernel/kernel.elf: kernel/kernel_entry.o ${OBJ} # Generate the intermediate kernel elf file
	ld -melf_i386 -o $@ -Ttext 0x1000 $^

%.o : %.c ${HEADERS} # Geneate object files from c files
	gcc -fno-pie -ffreestanding -m32 -c $< -o $@

%.o : %.asm # Generate object files from assembly files
	nasm $< -f elf -o $@

%.bin : %.asm # Generate binary files fom assembly files
	nasm $< -f bin -o $@

JackOS.vdi: JackOS.img # Generate the VirtualBox image
	truncate -s 1M $<
	VBoxManage convertfromraw $< $@

JackOS.img: os-image
	cp $< $@

clean:
	rm -fr *.bin *.o os-image *.map *.elf *.img *.vdi
	rm -fr kernel/*.o boot/*.bin drivers/*.o kernel/*.elf cpu/*.o