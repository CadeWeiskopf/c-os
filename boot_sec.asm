;
; boot sector program
;

[org 0x7c00]    ; tell assembler where this code is loaded

  mov bx, HELLO_MSG
  call print_string

  mov bx, GOODBYE_MSG
  call print_string

  jmp $       

%include "print_string.asm"

HELLO_MSG: 
  db 'Hello, World!', 0

GOODBYE_MSG: 
  db 'Goodbye!', 0

; padding 512 bytes and BIOS magic number
  times 510-($-$$) db 0
  dw 0xaa55



