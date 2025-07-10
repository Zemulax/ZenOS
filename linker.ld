ENTRY(kernel_main)
OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)

SECTIONS
{
    . = 0x100000;    /* Load address at 1MB, standard for protected mode kernels */

    .multiboot : {
        *(.multiboot) /* Multiboot header goes here */
    }

    .text : {
        *(.text)
    }
    .rodata : {
        *(.rodata)
    }
    .data : {
        *(.data)
    }
    .bss : {
        *(.bss)
    }
}

