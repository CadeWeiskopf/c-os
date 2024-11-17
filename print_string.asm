;
; print string function reads address in bx 
; and prints the characters until null terminator `0`
;
print_string:
  mov ah, 0x0e        ; bios teletype
  mov al, [bx]
  cmp al, 0
  je done             ; break at null terminator
  int 0x10            ; print
  inc bx
  jmp print_string

done:
  ret
