# Compile the OS
nasm -f bin -o bootloader.bin bootloader.asm
nasm -f bin -o kernel.bin kernel.asm
# Create the OS image
cat bootloader.bin kernel.bin > jiOS.img
