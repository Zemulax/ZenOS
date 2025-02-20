CC = i686-elf-gcc
OBJCOPY = i686-elf-objcopy

CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -c -ffreestanding
LDFLAGS = -m32 -nostdlib -nostartfiles -nodefaultlibs -static -Wl,-Tlinker.ld

OBJECTS = kernel.o

all: os-image

kernel.o: kernel.c
	$(CC) $(CFLAGS) kernel.c -o kernel.o

kernel.elf: $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o kernel.elf

kernel.bin: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.bin

os-image: bootloader.bin kernel.bin
	copy /b bootloader.bin+kernel.bin os-image.bin

bootloader.bin: bootloader.asm
	nasm -f bin bootloader.asm -o bootloader.bin

clean:
	del /Q *.bin *.o *.elf os-image