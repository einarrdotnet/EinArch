#########################################################################
#									#
# EINARCH STAGE 1 INSTALL SCRIPT					#
#									#
# This script was designed to automate installing EinArch		#
# EinArch is my own personal build of Arch Linux			#
# Stage 1 script will format the freshly partitioned drives		#
# into the correct file system, Mount the drive partitions,		#
# Install the packages "linux", "linux-firmware", "base",		#
# "base-devel" "neovim" and "git"					#
# It will also create the file system tables and chroot into the system	#
#									#
#########################################################################

#!/bin/bash

#Format boot partition to fat 32 file system
mkfs.fat -F32 /dev/sda1

#Format swap partition and turn swap on
mkswap /dev/sda2
swapon /dev/sda2

#Format root and home partitions to ext4 file system
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4

#Mount root partition to /mnt
mount /dev/sda3 /mnt

#Create boot/efi and home directories
mkdir -p /mnt/{boot/efi,home}

#Mount boot partition
mount /dev/sda1 /mnt/boot/efi

#Mount home Partition
mount /dev/sda4 /mnt/home

#Run pacstrap command on /mnt to install basic packages
pacstrap /mnt linux linux-firmware base base-devel git neovim

#Generate file system table with UUID's
genfstab -U /mnt >> /mnt/etc/fstab

#Clone EinArch files to root directory for stage2
mkdir /mnt/EinArch
cp EinArch/stage2.sh /mnt/EinArch/.
#git clone https://github.com/einarrdotnet/EinArch /mnt/EinArch
chmod +x /mnt/EinArch/stage2.sh

#completion message
printf '\n\e[1;32mEinArch stage1 installation complete.
\e[31mYou have now been chrooted into the new system.\n
\e[36mTo complete the install of Arch Linux (install bootloader etc)
run the stage 2 script by typing\e[33m "./EinArchstage2.sh" 
\e[36m(it has already been made executable) and pressing Enter\e[0m\n\n'

#chroot into the installation
arch-chroot /mnt
