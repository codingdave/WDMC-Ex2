#!/bin/sh
set -x

# Build uRamdisk
#apt-get install u-boot-tools
cd initrd
shopt -s dotglob
sudo find . | sudo cpio -H newc -o | lzma -7 > ../initramfs.cpio.lzma
cd ..
mkimage -A arm -O linux -T ramdisk -n "Initial Ramdisk (LZMA)" -C lzma -d initramfs.cpio.lzma uRamdisk-lzma
rm initramfs.cpio.lzma
