BITS 16
ORG 0x7C00

start:
    ; Load the kernel (assuming it is located at the second sector)
    mov bx, 0x1000      ; Load kernel at 0x1000:0000
    mov dh, 1           ; Number of sectors to read
    mov dl, 0           ; Drive number (floppy)
    mov ax, 0x0201      ; BIOS read sectors function
    int 0x13            ; BIOS interrupt

    ; Jump to the kernel
    jmp 0x1000:0000

TIMES 510-($-$$) db 0   ; Pad the rest of the 512-byte sector with zeros
DW 0xAA55               ; Boot signature
