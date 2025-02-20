# ZenOS Instructions

## Building the OS

1. Open a terminal in the workspace directory (c:\Users\Stanf\Videos\ZenOS).
2. Run the command: `make`
   This will build bootloader.bin, kernel.bin, and combine them to create os-image.bin.

## Running the OS

You can run the OS image using QEMU. For example, if you have QEMU installed, run:

```
qemu-system-i386 -fda os-image.bin
```

This command will emulate a floppy disk (-fda) containing the os-image.bin. Adjust the command if using a different boot medium.

## Notes

- Ensure you have an i686-elf cross compiler installed and your PATH configured to include its binaries.
- If using another emulator or virtualization software, consult its documentation for booting from a binary image.
