; load dh sectors to es:bx from drive dl
disk_load:
  push dx

  mov ah, 0x02  ; bios read sector function
  mov al, dh
  mov ch, 0x00  ; select cylinder 0
  mov dh, 0x00  ; select head 0
  mov cl, 0x02  ; second sector (the one after boot sector)
  int 0x13      
  jc disk_error
  
  pop dx
  cmp dh, al    ; al (sectors read) vs dh (sectors expected)
  jne disk_error
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_string
  
  mov dx, ax
  call print_hex

  ret

DISK_ERROR_MSG: 
  db 'Disk read error!', 0
