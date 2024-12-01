;
; gdt following the basic flat model for segmentation
;
gdt_start:
gdt_null:       ; mandator null descriptor
  dd 0x0
  dd 0x0

gdt_code:       ; code segement descriptor
  ; base=0x0, limit=0xfffff
  ; 1st flags: (present)1 (privilege)00 (descriptor type)1 -> 1001
  ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010
  ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 -> 1100
  dw 0xffff     ; Limit (bits 0-15)
  dw 0x0        ; Base (bits 16-31)
  db 0x0        ; Base (bits 32-39)
  db 0b10011010 ; 1st flags, type flags (bits 40-47)
  db 0b11001111 ; 2nd flags, Limit (bits 48-55)
  db 0x0        ; Base (bits 55-63)

gdt_data:       ; data segment descriptor
  ; same as code segment descriptor except for type flags
  ; type flags: (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010
  dw 0xffff     ; Limit (bits 0-15)
  dw 0x0        ; Base (bits 16-31)
  db 0x0        ; Base (bits 32-39)
  db 0b10010010 ; 1st flags, type flags (bits 40-47)
  db 0b11001111 ; 2nd flags, Limit (bits 48-55)
  db 0x0        ; Base (bits 55-63)

gdt_end:        ; label to calculate size in descriptor below
gdt_descriptor:
  dw gdt_end - gdt_start - 1 
  dd gdt_start 

CODE_SEGMENT equ gdt_code - gdt_start
DATA_SEGMENT equ gdt_data - gdt_start
