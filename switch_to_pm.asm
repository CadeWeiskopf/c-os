[bits 16]
switch_to_pm:
  cli         ; disable interrupts until switch to pm
  
  lgdt [gdt_descriptor]
  
  mov eax, cr0 
  or eax, 0x1     ; set first bit of cr0  
  mov cr0, eax    ; to switch to 32 bit protected mode

  jmp CODE_SEGMENT:init_pm    ; far jump to 32 bit code to force cpu flush prefetched decoded realmode instructions

[bits 32]
init_pm:
  mov ax, DATA_SEGMENT    ; point segment registers to data segment defined in GDT
  mov ds, ax 
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000
  mov esp, ebp

  call begin_protected_mode