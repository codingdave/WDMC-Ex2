#!/bin/sh
set -x

# Build uRamdisk
#apt-get install u-boot-tools
cd initrd
shopt -s dotglob
sudo find . | sudo cpio -H newc -o | gzip > ../uramdisk.cpio.gz
cd ..
mkimage -A arm -O linux -T ramdisk -n "Initial Ramdisk (gz)" -d uramdisk.cpio.gz uRamdisk-gz
rm uramdisk.cpio.gz
