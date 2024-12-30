BITS 32                 ; We are in 32-bit protected mode

section .data
msg db "jiOS Kernel Loaded!", 0
prompt db "jiOS> ", 0
buffer times 256 db 0  ; Buffer for user input

section .text
global start

start:
    ; Initialize GDT
    call load_gdt

    ; Print welcome message
    mov edx, msg
    call print_string

    ; Enter shell loop
shell_loop:
    ; Print prompt
    mov edx, prompt
    call print_string

    ; Read user input
    call read_input

    ; Echo user input back
    mov edx, buffer
    call print_string

    ; Loop back to shell prompt
    jmp shell_loop

hang:
    jmp hang

print_string:
    pusha
    mov ecx, -1
    mov al, 0
    cld
    repnz scasb
    not ecx
    dec ecx
    mov ebx, 0x0C       ; Attribute (background black, foreground red)
.next_char:
    lodsb               ; Load byte at [EDX] into AL
    or al, al           ; Check if end of string (NULL terminator)
    jz .done
    mov ah, 0x0E        ; BIOS teletype function
    int 0x10            ; BIOS interrupt to print character
    loop .next_char
.done:
    popa
    ret

read_input:
    pusha
    mov edi, buffer
.next_char:
    mov ah, 0           ; BIOS keyboard input
    int 0x16            ; BIOS interrupt to read character
    cmp al, 0x0D        ; Check if Enter key is pressed
    je .done
    stosb               ; Store byte in buffer
    mov ah, 0x0E        ; BIOS teletype function
    int 0x10            ; Echo character
    jmp .next_char
.done:
    stosb               ; Store null terminator
    popa
    ret
