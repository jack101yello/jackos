Cpp_SOURCES = $(wildcard lib/*.cpp drivers/*.cpp)
HEADERS = $(wildcard lib/*.h drivers/*.h)

OBJ = ${Cpp_SOURCES:.cpp=.o}
CRT0_OBJ=kernel/crt0.o
CRTI_OBJ=kernel/crti.o
CRTBEGIN_OBJ:=$(shell $$HOME/opt/cross/bin/i686-elf-gcc -print-file-name=crtbegin.o)
CRTEND_OBJ:=$(shell $$HOME/opt/cross/bin/i686-elf-gcc -print-file-name=crtend.o)
CRTN_OBJ=kernel/crtn.o
OBJ_LINK_LIST:=$(CRTI_OBJ) $(CRTBEGIN_OBJ) boot/boot.o kernel/kernel.o $(OBJ) $(CRTEND_OBJ) $(CRTN_OBJ)

all: jackos.bin

jackos.iso:
	mkdir -p isodir/boot/grub
	cp jackos.bin isodir/boot/jackos.bin
	cp boot/grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o jackos.iso isodir

jackos.bin: $(OBJ_LINK_LIST)
	$$HOME/opt/cross/bin/i686-elf-gcc -T boot/linker.ld -o jackos.bin $(OBJ_LINK_LIST) -ffreestanding -O2 -nostdlib -lgcc

kernel/kernel.o:
	$$HOME/opt/cross/bin/i686-elf-g++ -c kernel/kernel.cpp -o kernel/kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti

.cpp.o:
	$$HOME/opt/cross/bin/i686-elf-g++ $< -o $@ -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti -nostdlib -r

kernel/crt0.o:
	$$HOME/opt/cross/bin/i686-elf-as kernel/crt0.s -o kernel/crt0.o

kernel/crti.o:
	$$HOME/opt/cross/bin/i686-elf-as kernel/crti.s -o kernel/crti.o

kernel/crtn.o:
	$$HOME/opt/cross/bin/i686-elf-as kernel/crtn.s -o kernel/crtn.o

boot/boot.o:
	$$HOME/opt/cross/bin/i686-elf-as boot/boot.s -o boot/boot.o

clean:
	rm -fr *.bin *.o *.iso
	rm -fr kernel/*.o lib/*.o boot/*.o drivers/*.o