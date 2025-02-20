ENTRY(kernel_main)
OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)

SECTIONS
{
    . = 0x1000;    /* Changed to match bootloader's KERNEL_OFFSET */
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