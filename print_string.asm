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
    ; new line at end
    mov al, 10
    int 0x10
    mov al, 13
    int 0x10

    ret

;
; prints hex representation of data in dx
;
print_hex:
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

    pop ax
    ret


HEX_OUT:
  db '0x0000', 0

VIDEO_MEMORY equ 0xb8000
GREEN_ON_BLACK equ 0b0000_0010
[bits 32]
print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY

  print_string_pm_loop:
    mov al, [ebx]
    mov ah, GREEN_ON_BLACK 
    mov [edx], ax             ; display current char

    cmp al, 0
    je print_string_pm_done

    add ebx, 1                ; increment to next char in string
    add edx, 2                ; move to next char cell in video mem

    jmp print_string_pm_loop

  print_string_pm_done:
    popa
    ret