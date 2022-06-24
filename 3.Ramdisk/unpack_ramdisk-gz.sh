#!/bin/sh
set -x

# Unpack uRamdisk
sudo rm -rf initrd
mkdir initrd
cd initrd
dd if=../uRamdisk of=initrd.cpio.gz bs=64 skip=1
file initrd.cpio.gz
zcat initrd.cpio.gz > initrd.cpio
file initrd.cpio
sudo cpio -i --no-absolute-filenames < initrd.cpio
rm initrd.cpio.gz initrd.cpio
cd ..
