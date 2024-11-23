;
; boot sector program
;

[org 0x7c00]    ; tell assembler where this code is loaded

  mov [BOOT_DRIVE], dl  ; bios stores boot drive in dl, store for later

  mov bp, 0x8000        ; move stack out of the way
  mov sp, bp

  mov bx, 0x9000 
  mov dh, 5
  mov dl, [BOOT_DRIVE]
  call disk_load

  mov dx, [0x9000]
  call print_hex

  mov dx, [0x9000 + 512]
  call print_hex

  jmp $       

%include "print_string.asm"
%include "disk_load.asm"

; global variables
BOOT_DRIVE:
  db 0

; padding 512 bytes and BIOS magic number 
times 510-($-$$) db 0
dw 0xaa55

; since bios will only load first 512-byte sector from disk,
; we can intentionally add more sectors with data 
; to prove we actually load the additional sectors 
; from the disk we booted from
times 256 dw 0xdada
times 256 dw 0xface

