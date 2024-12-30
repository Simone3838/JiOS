# Compile the OS
nasm -f bin -o bootloader.bin bootloader.asm
nasm -f elf -o kernel.o kernel.asm
nasm -f elf -o GDT.o GDT.asm
ld -m elf_i386 -Ttext 0x1000 -o kernel.bin kernel.o GDT.o --oformat binary
# Create the OS image
cat bootloader.bin kernel.bin > jiOS.img
