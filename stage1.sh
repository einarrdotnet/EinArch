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
