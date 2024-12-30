# Compile the OS
nasm -f bin -o bootloader.bin bootloader.asm
nasm -f elf -o kernel.o kernel.asm
nasm -f elf -o GDT.o GDT.asm
ld -m elf_i386 -Ttext 0x1000 -o kernel.bin kernel.o GDT.o --oformat binary
# Create the OS image
dd if=bootloader.bin of=jiOS.img bs=512 count=1 conv=notrunc
dd if=kernel.bin of=jiOS.img bs=512 seek=1 conv=notrunc
