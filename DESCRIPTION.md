# ZenOS Technical Description

## System Architecture

ZenOS is a minimal operating system built for x86 architecture with the following components:

### Bootloader (bootloader.asm)

The bootloader is written in x86 assembly and performs several critical functions:

1. **Initialization**: Sets up segments and stack
2. **Kernel Loading**: Reads the kernel from disk into memory at address 0x1000
3. **Mode Switching**: Transitions from 16-bit real mode to 32-bit protected mode
4. **GDT Setup**: Configures the Global Descriptor Table for memory segmentation
5. **Kernel Handoff**: Transfers control to the loaded kernel

The bootloader includes error handling for disk operations and implements simple debug output functions to display the boot progress.

### Kernel (kernel.c)

The kernel is written in C and serves as the core of the operating system:

1. **Memory Management**:

   - Page-based memory allocation with 4KB pages
   - Simple memory block allocator (kmalloc/kfree)
   - Page directory and table structures for virtual memory

2. **Terminal Interface**:

   - Basic text output capabilities
   - Support for error messages and system status

3. **Error Handling**:
   - Kernel panic mechanism for handling critical errors

## Memory Map

```
0x00000000 - 0x00000FFF: Reserved for interrupt vector table
0x00001000 - [Kernel Size]: Kernel code and data
[End of Kernel] - 0x001FFFFF: Kernel heap
0x00200000 - 0x00FFFFFF: User space memory
0x01000000: Upper memory limit (16MB)
```

## Boot Process

1. BIOS loads the bootloader from the first sector of the boot device
2. Bootloader initializes and displays boot message
3. Kernel is loaded from disk (sectors 2-10)
4. System switches to protected mode
5. Control is transferred to the kernel's entry point
6. Kernel initializes memory management and terminal
7. System is ready for operation

## Build System

The Makefile manages the build process:

1. Compiles kernel.c with specific flags for freestanding operation
2. Assembles bootloader.asm
3. Links the kernel with custom linker script
4. Converts kernel ELF binary to raw binary format
5. Concatenates bootloader and kernel into a single image

## Future Development Areas

1. **File System**: Implementing a basic file system for data storage
2. **Process Management**: Adding support for multitasking and process scheduling
3. **Driver Framework**: Creating interfaces for hardware device support
4. **User Space**: Separating kernel and user mode operations
5. **Shell Interface**: Developing a command-line interface for user interaction

## Technical Limitations

1. Limited to 16MB of memory
2. No hardware device drivers beyond basic terminal
3. Single-tasking operation
4. No support for user programs yet
5. Limited error recovery capabilities

## Debug Features

The system includes basic debugging capabilities through terminal output and error codes. When the system encounters a critical error, it will display an error message and halt execution.
