# WD MyCloud Ex2 (WD MyCloud-Mirror) and EX2 Ultra with Linux stable on Debian stable

### Steps to update your Linux Kernel for WD MyCloud Ex2

This Guide will explain you how to install Linux stable and Debian stable on your WD MyCloud Ex2.
This procedure was tested with WD MyCloud Ex2, but it should work also for MyCloud Ex2 Ultra and the basic concepts of it can be applied to any WD Nas device.

This repository contains the image file for kernel v5.18.5 (as it is linux-stable at the time of writing).

This guide works without flashing U-Boot.

It allows for several ways to integrate the kernel:
* Use the kernel (uImage) from /dev/mtdblock1 and the initrd/rootfs (uRamdisk) from /dev/mtdblock2 like WD has set their boxes up
* Boot the kernel from /dev/sda
* Boot the kernel from the usb drive
* Boot the kernel via TFTP

The procedure is articulated in these steps:
1. Get access to the serial log on your device (note: this will break the warranty, noting that the the Ex2 is officially no more supported by WD. It can also easily brick your device if you are not careful.)
2. Build the kernel. The repository contains the file ready-to-go with Linux 5.18.5 built for the WD MyCloud Ex2. If you have a different hardware you need to build the kernel for yourself (e.g. for Wd MyCloud Ex2 Ultra). 
4. Install the Linux kernel (uImage)
5. Optionally build/change the initrd/rootfs (uRamdisk)
6. Modify U-Boot to load the kernel and ramdisk
7. Install debian (The operating system)
8. Install userspace tools (applications on your NAS)

## Support
+ USB or SATA drive 
+ ext2,3,4, btrfs
+ raid 0,1 and LVM
+ ssh-rescue shell

## References to other public projects
+ This site contains a lot of VUIs (very useful information): 
  https://wd.hides.su/wd/Ex2/WDMC-Ex2/
  https://wd.hides.su/wdnas.el8.website/WDMyCloud-Mirror/Developing/

## Credits:
+ @FoxExe https://github.com/codingdave/wdmc-gen1-tools
+ @vzhilov https://github.com/vzhilov/WDMC-Ex2-Ultra.git
+ @Johns-Q https://github.com/Johns-Q/wdmc-gen2.git
+ @Heisath https://github.com/Heisath/wdmc2-kernel.git
