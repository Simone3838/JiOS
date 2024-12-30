; kernel.asm
BITS 32                 ; We are in 32-bit protected mode

section .text
global start

start:
    ; Print a simple message to the screen
    mov edx, msg
    call print_string

    ; Hang the system (infinite loop)
hang:
    jmp hang

print_string:
    mov ecx, msg_len
    mov ebx, 0x0C       ; Attribute (background black, foreground red)
.next_char:
    lodsb               ; Load byte at [EDX] into AL
    or al, al           ; Check if end of string (NULL terminator)
    jz .done
    mov ah, 0x0E        ; BIOS teletype function
    int 0x10            ; BIOS interrupt to print character
    loop .next_char
.done:
    ret

msg db 'jiOS Kernel Loaded!', 0
msg_len equ $ - msg
