# ZenOS

A minimalist, educational x86 operating system with a custom bootloader and kernel.

## Overview

ZenOS is a simple operating system developed from scratch for x86 architecture computers. It features a custom bootloader written in assembly and a kernel written in C, with basic memory management functionality. This project aims to provide a learning platform for operating system development concepts.

## Features

- Custom 16-bit to 32-bit bootloader
- Protected mode kernel
- Basic memory management (page tables, memory blocks)
- Terminal output capabilities
- Error handling system with panic function
- Floppy disk compatibility

## Project Structure

- **bootloader.asm**: Assembly code for the bootloader that loads the kernel
- **kernel.c**: C code for the kernel with memory management and terminal functions
- **kernel_types.h**: Type definitions used by the kernel
- **linker.ld**: Linker script for kernel compilation
- **Makefile**: Build automation for the operating system

## Building

### Prerequisites

To build ZenOS, you need:

- GCC cross-compiler for i686-elf target
- NASM assembler
- GNU Make

### Build Process

To build the entire operating system:

```
make
```

This will:

1. Compile the bootloader with NASM
2. Compile the kernel with i686-elf-gcc
3. Link everything together
4. Create a bootable disk image (os-image.bin)

To clean the build artifacts:

```
make clean
```

## Running

ZenOS can be run using an emulator like QEMU or written to physical media for testing on real hardware:

```
qemu-system-i386 -fda os-image.bin
```

## Development

ZenOS is designed to be easy to extend. The current implementation provides:

- A bootloader that switches from 16-bit real mode to 32-bit protected mode
- Memory segmentation and paging setup
- Basic terminal I/O capabilities
- Kernel memory allocation functions (kmalloc/kfree)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Feel free to submit pull requests or open issues to improve ZenOS.
