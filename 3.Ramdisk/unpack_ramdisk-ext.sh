#!/bin/sh
set -x

# Unpack uRamdisk
sudo rm -rf initrd
mkdir initrd
dd if=uRamdisk of=initrd.ext.gz bs=64 skip=1
file initrd.ext.gz
zcat initrd.ext.gz > initrd.ext
file initrd.ext
sudo mount -o loop initrd.ext initrd
rm initrd.ext.gz initrd.ext
