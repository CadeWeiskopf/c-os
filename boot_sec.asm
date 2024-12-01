;
; boot sector program that enters 32 bit protected mode
;

[org 0x7c00]    ; tell assembler where this code is loaded
  
  mov bp, 0x9000          ; set the stack
  mov sp, bp
  mov bx, REAL_MODE_MSG
  call print_string
  call switch_to_pm        ; this will jump to begin_protected_mode
  jmp $

%include "disk_load.asm"
%include "gdt.asm"
%include "print_string.asm"
%include "switch_to_pm.asm"

begin_protected_mode:
  mov ebx, PROTECTED_MODE_MSG
  call print_string_pm
  jmp $

; global variables
BOOT_DRIVE:
  db 0

DEBUG_MSG:
  db 'Debug message!', 0

REAL_MODE_MSG:
  db "Started in 16-bit Real Mode", 0

PROTECTED_MODE_MSG:
  db "Jumped to 32-bit Protected Mode", 0


; padding 512 bytes and BIOS magic number 
times 510-($-$$) db 0
dw 0xaa55
