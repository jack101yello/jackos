Cpp_SOURCES = $(wildcard lib/*.cpp kernel/*.cpp)
HEADERS = $(wildcard lib/*.h)

OBJ = ${Cpp_SOURCES:.cpp=.o}

all: jackos.bin

jackos.iso:
	mkdir -p isodir/boot/grub
	cp jackos.bin isodir/boot/jackos.bin
	cp boot/grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o jackos.iso isodir

jackos.bin: boot.o ${OBJ}
	$$HOME/opt/cross/bin/i686-elf-gcc -T boot/linker.ld -o jackos.bin -ffreestanding -O2 -nostdlib $^ -lgcc

kernel:
	$$HOME/opt/cross/bin/i686-elf-g++ -c kernel/kernel.cpp -o kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti

%.o : %.cpp ${HEADERS}
	$$HOME/opt/cross/bin/i686-elf-g++ -c $< -o $@ -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti

boot.o:
	$$HOME/opt/cross/bin/i686-elf-as boot/boot.s -o boot.o

clean:
	rm -fr *.bin *.o *.iso
	rm -fr kernel/*.o lib/*.o