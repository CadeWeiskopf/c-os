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

print_hex:
  mov bx, HELLO_MSG
  call print_string

  mov si, dx
  mov cx, 4       ; will proccess 4 nibbles bc 16bits
  push 0          ; use to offset HEX_OUT
  

hex_to_string:
  shr dx, 12      ; get high nibble
  and dx, 0x0f  

  add dl, '0'
  cmp dl, '9'
  jg convert_to_alpha 
  jmp store_char

convert_to_alpha:
  add dl, 7

store_char:
  lea di, [HEX_OUT + 2]
  pop ax
  add di, ax
  mov [di], dl
  add ax, 1
  push ax

  shl si, 4
  mov dx, si
  loop hex_to_string

  mov bx, HEX_OUT
  call print_string

  mov bx, GOODBYE_MSG
  call print_string

  pop ax
  ret
  
HEX_OUT:
  db '0x0000', 0

HELLO_MSG: 
  db 'Hello, World!', 0

GOODBYE_MSG: 
  db 'Goodbye!', 0

; padding 512 bytes and BIOS magic number
  times 510-($-$$) db 0
  dw 0xaa55



