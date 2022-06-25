# Linux and ARM
Since the ARM System on a chip (SoC) comes in a variety of designs it is very difficult if not impossible for the kernel team to provide support for. That is why for ARM SoCs usually a 2 step boot happens:

- The bootloader (U-Boot) is a small application that is ment to start the system. It is small and does not have a lot of features. But it can load and start code on its flash or on connected periperials given that it understands it. You don't normally update the bootloader to add features but you update the kernel.
- At first the bootloader starts the kernel (uImage). So it reads it into memory, unpacks it, and moves the execution pointer to that memory. That is when the bootloader has done its service and will not play a part any longer.
- The kernel then takes over. It tries to initialize the hardware it runs on and kernel-panics if this fails, asking to provide a compatible kernel.
A kernel alone does not bring you any value as you still need a shell to launch applications. So the last step of the kernels booting phase is to call the init process.
- Usually the bootloader knows not only the kernel but also the code that runs the init process (initrd). This can be the final root (what is mounted as /) of the system, or, more typically, at first a rootfs is loaded (mini system containing a shell and dependencies) that is being mounted to root that brings up the final system (LVM, RAID, encrypted drives, other difficult hardware initalization). When it is done it proceeds by mounting the final root over the current root (so in fact under your root is the root of your rootfs).
- So the kernel will end up calling either the init of the rootfs or the init of the final system. It is your obligation to decide which way you want to go.
- If you want to examine / modify the uRamdisk this page describes how to do that.

# The scripts
- Ramdisks come in different fashion. Usually they are compressed with either gzip or LZMA. They also often are a cpio archive, but also can be an ext filesystem. Other variations are possible. 
- The scripts come in a variation for gzip, one for LZMA, and one for ext.
- Copy/link the rootfs you want to explore into the directory with the name uRamdisk and call the scripts.
- They will upack the rootfs given you called the correct one into initrd.
- Initrd contains the mini root filesystem. You can analyze and modify its content and pack it if your done. Pay a special attention to the /init script, as this serves as the entry point for the execution.
- When you have packed the rootfs (LZMA is recommended) you can use the uRamdisk for booting with U-Boot.

# TODO
- enhance scripts: stop if no uRamdisk present
- enhance scripts: stop if filetype is unexpected
- enhance scripts: reduce noise
- enhance scripts: add pack_ramdisk-ext.sh

# useful resources
https://boundarydevices.com/hacking-ram-disks/
https://www.mikrocontroller.net/topic/477429
https://docs.windriver.com/bundle/Wind_River_Linux_Users_Guide_3.0_1/page/497733.html
https://www.gibbard.me/linux_initramfs_initrd/
https://yuhei1-horibe.medium.com/booting-linux-with-ramdisk-f6f2d59780dc
https://armbedded.taskit.de/node/77
https://linux-sunxi.org/Initial_Ramdisk
