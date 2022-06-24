#!/bin/sh
set -x

# Unpack uRamdisk
sudo rm -rf initrd
mkdir initrd
cd initrd
dd if=../uRamdisk of=initrd.cpio.lzma bs=64 skip=1
file initrd.cpio.lzma
lzma -d < initrd.cpio.lzma > initrd.cpio
file initrd.cpio
#lzma -d initrd.cpio.lzma
sudo cpio -i --no-absolute-filenames < initrd.cpio
rm initrd.cpio.lzma initrd.cpio
cd ..
