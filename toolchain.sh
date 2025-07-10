#!/bin/bash
set -e

# Configuration
TARGET=i686-elf
PREFIX="$HOME/osdev/cross"
PATH="$PREFIX/bin:$PATH"
BINUTILS_VERSION=2.42
GCC_VERSION=13.2.0
JOBS=$(nproc)

echo "Installing dependencies..."
sudo apt update
sudo apt install -y \
  build-essential bison flex libgmp-dev libmpc-dev libmpfr-dev texinfo wget

# Create directories
mkdir -p "$HOME/osdev/src"
mkdir -p "$PREFIX"
cd "$HOME/osdev/src"

echo "Downloading binutils $BINUTILS_VERSION..."
wget -c https://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.gz
tar -xf binutils-$BINUTILS_VERSION.tar.gz

echo "Downloading GCC $GCC_VERSION..."
wget -c https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz
tar -xf gcc-$GCC_VERSION.tar.gz

echo "Building binutils..."
mkdir -p ../build-binutils
cd ../build-binutils
../src/binutils-$BINUTILS_VERSION/configure \
  --target=$TARGET --prefix=$PREFIX --with-sysroot --disable-nls --disable-werror
make -j$JOBS
make install

echo "Building GCC (C only)..."
mkdir -p ../build-gcc
cd ../build-gcc
../src/gcc-$GCC_VERSION/configure \
  --target=$TARGET --prefix=$PREFIX --disable-nls --enable-languages=c --without-headers
make all-gcc -j$JOBS
make install-gcc

echo ""
echo "✅ i686-elf GCC cross-compiler installed at: $PREFIX/bin"
echo ""
echo "👉 Add this to your shell config (e.g., ~/.bashrc):"
echo "export PATH=\"$PREFIX/bin:\$PATH\""

