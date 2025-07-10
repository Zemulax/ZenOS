# Toolchain
CC = i686-elf-gcc
OBJCOPY = i686-elf-objcopy

# Flags
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -c -ffreestanding
LDFLAGS = -m32 -nostdlib -nostartfiles -nodefaultlibs -static -Wl,-Tlinker.ld

# Files
OBJECTS = kernel.o
KERNEL_ELF = kernel.elf
KERNEL_BIN = kernel.bin
ISO_IMAGE = ZenOS.iso

# Default target
all: $(ISO_IMAGE)

# Kernel build steps
kernel.o: kernel.c
	$(CC) $(CFLAGS) kernel.c -o kernel.o

$(KERNEL_ELF): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $(KERNEL_ELF)

$(KERNEL_BIN): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $(KERNEL_ELF) $(KERNEL_BIN)

# Bootloader
bootloader.bin: bootloader.asm
	nasm -f bin bootloader.asm -o bootloader.bin

# ISO build
$(ISO_IMAGE): $(KERNEL_ELF) grub.cfg
	mkdir -p isodir/boot/grub
	cp $(KERNEL_ELF) isodir/kernel.bin   # << ELF with Multiboot header
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO_IMAGE) isodir



# Run the ISO in QEMU
run: $(ISO_IMAGE)
	qemu-system-i386 -cdrom $(ISO_IMAGE)

# Clean up build artifacts
clean:
	rm -f *.bin *.o *.elf $(ISO_IMAGE)

