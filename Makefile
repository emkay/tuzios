default: run

.PHONY: clean

build/multiboot_header.o: multiboot_header.asm
	mkdir -p build
	/usr/local/opt/nasm/bin/nasm -f elf64 multiboot_header.asm -o build/mutliboot_header.o

build/boot.o: boot.asm
	mkdir -p build
	/usr/local/opt/nasm/bin/nasm -f elf64 boot.asm -0 build/boot.o

build/kernel.bin: build/multiboot_header.o build/boot.o linker.ld
	$HOME/opt/bin/x86_64-pc-elf-ld -n -o build/kernel.bin -T linker.ld build/multiboot_header.o build/boot.o

build/os.iso: build/kernel.bin grub.cfg
	mkdir -p build/isofiles/boot/grub
	cp grub.cfg build/isofiles/boot/grub
	cp build/kernel.bin build/isofiles/boot/
	$HOME/opt/bin/grub-mkrescue -o build/os.iso build/isofiles

run: build/os.iso
	qemu-system-x86_64 -cdrom os.iso

build: build/os.iso

clean:
	rm -f build
