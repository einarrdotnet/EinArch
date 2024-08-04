# EinArch

**IMPORTANT !**

EinArch is repository designed for my own personal. use it conatains scripts and configs and files designed to aid in a Arch Linux installation for my specific system to my specific preference. anyone is more than welcome to clone it and use it however i suggest you read the contents of any script file before executing it and make changes pertaining to your system.

THIS INSTALLATION GUIDE CONTAINS TECHNICAL LANGUAGE IF YOU ARE HAVING TROUBLE UNDERSTANDING IT ITS RECOMMENDED NOT TO PROCEED

THIS PROCESS IS DESIGNED FOR UEFI BASED SYSTEMS ONLY

**I AM NOT RESPONSABLE FOR ANY DAMAGES TO YOUR SYSTEM BY USING ANY OF THESE SCRIPTS**

## Instructions for use

### Preperations
1. Boot into the Arch Linux Live ISO on your thumb drive
2. Make sure you have a working internet connection 
3. Drive Partitioning completed. **THS SCRIPTS USES SEPERATE PARTITIONS FOR ROOT AND HOME** I have provided sample layout of the drive setup i use.

    |Partition Number|Partition Size|Partiton Type|
    |:--------------:|:------------:|:-----------:|
    |1(sda1)|1GB (1024M)| EFI System | 
    |2 (sda2) | 8GB (8192M) | Linux Swap |
    |3 (sda3) | 64GB (65536M) | Linux File System |
    |4 (sda4) | Remaining Space | Linux File System |

4. install git onto the Arch Linux live USB
5. git clone the repository onto the Arch Linux Live USB


## Stage 1

After doing the preperation work change directory into the repository and run the stage1.sh shell script file the follow actions will be performed.
1. Format the partitions to the correct file system.
2. Create and enable the system swap.
3. Mount the /dev/sda3 to /mnt
4. make directories /mnt/boot/efi and /mnt/home
5. mount /dev/sd1 to /mnt/boot/efi
6. mount /dev/sd4 to /mnt/home
7. run the "pacstrap /mnt" command and install "linux", "linux-firmware", "base", "base-devel" "git" and "neovim"
8. generate the file system table (fstab) using the UUID
9. git clone this repo to the /mnt drive for stage 2
10. perform "arch-chroot /mnt" to load you into your fresh install

## Stage 2
**STILL A WORK IN PROGRESS**
