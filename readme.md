OS from Scratch
===

This is a personal project building an operating system from scratch utilizing assembly and C.

It is being developed in a Linux environment using the following tools:
- **NASM** as the assembler/disassembler; i.e. assembling raw machine code with `nasm boot_sect.asm -f bin -o boot_sect.bin`
- **QEmu** the CPU emulator for running the machine code; i.e. test on your machine with `qemu-system-i386 -fda boot_sec.bin`
