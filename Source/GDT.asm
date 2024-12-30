BITS 32

section .data
gdt_start:
    ; Null descriptor
    dd 0
    dd 0

    ; Code segment descriptor
    dw 0xFFFF        ; Limit low
    dw 0x0000        ; Base low
    db 0x00          ; Base middle
    db 10011010b     ; Access byte (present, ring 0, executable, readable)
    db 11001111b     ; Granularity byte (4KB granularity, 32-bit opcodes)
    db 0x00          ; Base high

    ; Data segment descriptor
    dw 0xFFFF        ; Limit low
    dw 0x0000        ; Base low
    db 0x00          ; Base middle
    db 10010010b     ; Access byte (present, ring 0, writable)
    db 11001111b     ; Granularity byte (4KB granularity, 32-bit opcodes)
    db 0x00          ; Base high

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Size of GDT
    dd gdt_start                ; Address of GDT

section .text
global load_gdt
load_gdt:
    lgdt [gdt_descriptor]       ; Load the GDT descriptor
    mov ax, 0x10                ; Data segment selector (2nd entry)
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    jmp 0x08:flush_cs           ; Code segment selector (1st entry)

flush_cs:
    mov ax, 0x10                ; Reload data segment selector
    ret
