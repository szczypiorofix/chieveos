bits 16
cpu  8086 
org 0x7c00

jmp main

MessageA db ".............. CHIEVE OS ver. 0.5.0 ..............", 0xD, 0xA, 0x0
MessageB db "Simple Bootloader. Type a command:", 0xD, 0xA, 0x0
array db 'a'

Println:
    lodsb ; Load string
    or al, al
    jz complete
    mov ah, 0x0e
    int 0x10 ; BIOS Innterrupt 0x10 for print on screen
    jmp Println ; Loop

complete:
    ret

PrintNwl:
    mov al, 0x0
    stosb
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    jmp GetInput

StartCommandLine:
    call GetInput


GetInput:
    mov ah, 0x0
    int 0x16 ;BIOS leyboard

    mov ah, 0x0e
    int 0x10

    cmp al, 13
    je PrintNwl
    
    
    ; ret
    jmp GetInput
    
main:
    cli ; Clear interrupts
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    sti ; Enable interrupts


    mov si, MessageA
    call Println
    
    mov si, MessageB
    call Println



    call StartCommandLine

    times 510 - ($-$$) db 0 ; Fill the rest of bootloader with 0's
    dw 0xAA55 ; Boot signature

