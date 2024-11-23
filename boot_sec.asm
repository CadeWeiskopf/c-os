;
; boot sector program
;

[org 0x7c00]    ; tell assembler where this code is loaded

  mov dx, 'H'
  call print_hex

  mov dx, 'B'
  call print_hex

  mov dx, 10
  call print_hex


  jmp $       

%include "print_string.asm"
  
HEX_OUT:
  db '0x0000', 0

HELLO_MSG: 
  db 'Hello, World!', 0

GOODBYE_MSG: 
  db 'Goodbye!', 0

; padding 512 bytes and BIOS magic number
  times 510-($-$$) db 0
  dw 0xaa55



