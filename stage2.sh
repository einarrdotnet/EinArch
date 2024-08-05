#################################################################
#								#
# EINARCH STAGE 2 INSTALL SCRIPT				#
#								#
# This script was designed to automate installing EinArch	#
# EinArch is my own personal build of Arch Linux		#
# The stage 2 script will carry on from where stage 1 left off	#
# Completing the Arch Linux base installation allowing the	#
# user to reboot into a working system with a tty		#
#################################################################

#!/bin/bash

#Prompt user for hostname
printf "\e[1;32mPlease provide a host name for the system.\e[0m\n"
read -p "Hostname: " hostname

#Prompt user for username
printf "\e[1;32mPlease provide a user name (this will be the name you login with when installation is complete)"
read -p "Username: " username

#Prompt user for root password
printf '\e[1;31mPlease provide a\e[33m "root" \e[31mpassword\n' 
read -ps "Root Password: " rootpassword

#prompt user for user password
printf '\e[1;31mPlease provide a user password for the user \e[33m"'$username'"\e[0m\n'
read -ps "User Password:" userpassword

#Set the timezone to Pacific/Auckland (New Zealand)
ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime

#Set the hardware clock to the system clock
hwclock --systohc

#Set the locale to en_NZ.UTF-8
sed -i '164s/.//' /etc/locale.gen
locale-gen

#Set the LANG variable
echo "LANG=en_NZ.UTF-8" >> /etc/locale.conf

#Set Hostname
echo "Einarr-Desktop" >> /etc/hostname

#Set hosts file (Network configuration)
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 Einarr-Desktop.localdomain Einarr-Desktop" >> /etc/hosts

#Install base system packages for bootloader,network manager etc
pacman -S --noconfirm grub efibootmgr dosfstools mtools os-prober networkmanager bash-completion

#Configure Grub bootloader
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

#Enable Network Manager on startup
systemctl enable NetworkManager
