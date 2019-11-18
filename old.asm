bits 16 ;
org 0x7c00 ;

jmp main ;

Message db "////////// CHIEVE OS ver. 0.5.0 \\\\\\\\\\", 0x0

MessageB db "Hello World !!!111oneoneone", 0x0

AnyKey db "Press any key to reboot", 0x0



Println:

    lodsb ; Load string
    or al, al
    jz complete
    mov ah, 0x0e
    int 0x10 ; BIOS Innterrupt 0x10 for print on screen

    jmp Println ; Loop

complete:
    call PrintNwl

PrintNwl:
    mov al, 0
    stosb

    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    ret

Reboot:
    mov si, AnyKey
    call Println
    call GetPressedKey

    db 0x0ea
    dw 0x000
    dw 0xfff

GetPressedKey:
    mov ah, 0
    int 0x16 ;BIOS leyboard
    ret

main:
    cli ; Clear interrupts
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax
    sti ; Enable interrupts

    mov si, Message
    call Println

    mov si, MessageB
    call Println
    
    call PrintNwl
    call PrintNwl

    call Reboot

    times 510 - ($-$$) db 0 ; Fill the rest of bootloader with 0's
    dw 0xAA55 ; Boot signatur
