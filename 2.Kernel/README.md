# How to cross compile the kernel

## Get all needed packages:
```
apt update
apt upgrade
apt install build-essential u-boot-tools libncurses5-dev git bison flex bc libssl-dev
apt install crossbuild-essential-armhf
```

## Get required files from this repository
```
wget https://raw.githubusercontent.com/gisab/WDMC-Ex2/main/3.Kernel/gpio_trigger.patch
wget https://raw.githubusercontent.com/gisab/WDMC-Ex2/main/3.Kernel/kernel.config
wget https://raw.githubusercontent.com/gisab/WDMC-Ex2/main/3.Kernel/compile.sh
wget https://raw.githubusercontent.com/gisab/WDMC-Ex2/main/3.Kernel/armada-370-wdmc-mirror-gen1-gs.dts
```

## Download the kernel sources and patch the led gpio file

```
git clone --depth 1 --branch linux-rolling-stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-stable
```

Use patch to fix LED beheavor
```
cd linux-stable
patch -p1 < ../gpio_trigger.patch
```

## Copy prepared config file to linux directory
```
cp ../kernel.config .config
```

## Copy the required Device Tree
### For WD MyCloud Ex2 (armada-370)
```
cp ../dts/armada-370-wdmc-mirror-gen1-gs.dts arch/arm/boot/dts/
```
### For Ex2 Ultra (armada-385)
```
cp ../dts/armada-385-wdmc-Ex2-Ultra.dts arch/arm/boot/dts/
```

## Start to compile the kernel 

Chose either WD MyCloud Ex2 (armada-370)
```
device=armada-370-wdmc-mirror-3-gen1-gs.dtb
```
or for WD MyCloud Ex2 Ultra (armada-385)
```
device=armada-385-wdmc-Ex2-Ultra.dtb
```
Then compile (take a break, this takes hours):
```
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j zImage
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j $device
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j modules
mkdir -p ../output
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=../output modules_install
cp arch/arm/boot/zImage zImage_and_dtb
cat arch/arm/boot/dts/$device >> zImage_and_dtb
mkimage -A arm -O linux -T kernel -C none -a 0x00008000 -e 0x00008000 -n linux-rolling-stable -d zImage_and_dtb uImage
```

## Finalize the setup

+ copy the uImage file in the `sda1` partition
+ copy the ../output/lib in the root of the `sda2` (or where your linux distribution is installed); this folder contains the kernel ko to be loaded at runtime by your new kernel


## Reference
+  [vzhilov / WDMC-Ex2-Ultra](https://github.com/vzhilov/WDMC-Ex2-Ultra.git)
