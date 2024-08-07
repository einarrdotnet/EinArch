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
printf "\e[1;32mPlease provide a user name (this will be the name you login with when installation is complete)\e[0m\n"
read -p "Username: " username

#Prompt user for root password
#printf '\e[1;31mPlease provide a\e[33m "root" \e[31mpassword\e[0m\n' 
#read -sp "Root Password: " rootpassword

#prompt user for user password
#printf '\e[1;31mPlease provide a user password for the user \e[33m"'$username'"\e[0m\n'
#read -sp "User Password:" userpassword

#Setting root password
vrp=0
while [vpr=0]
do
	#Promt user for a root password
	printf '\e[1;36mPlease enter a password for the \e[33m"root"\e[36m system account.\e[0m\n'
	read -sp "Password: " rp1
	#Promt user to verify root password
	printf '\n\e[1;36mPleas verify password for the \e[33m"root"\e[36m system account.\e[0m\n'
	read -sp "Verify password" rp2
	#check passwords entetered match
	if ["$rp1" != "$rp2"]; then
		#restart setting password process
		vrp=0
		printf '\n\e[1;31mERROR: Passwords do match, Please try again.\e[0m\n\n'
	else
		#set root password to first password entered
		rootpassword=$rp1
		printf '\n\e[1;32mPassword for \e[33m"root" \e32maccout set\e[0m\n\n'
		break
	fi
done


#Setting User password
vup=0
while [vur=0]
do
	#Promt user for a user password
	printf '\e[1;36mPlease enter a password for the user accuout \e[33m"'$username'"\e[0m\n'
	read -sp "Password: " up1
	#Promt user to verify user password
	printf '\n\e[1;36mPleas verify password for the user account\e[33m"'$username'"\e[0m\n'
	read -sp "Verify password" up2
	#check passwords entetered match
	if ["$up1" != "$up2"]; then
		#restart setting password process
		vup=0
		printf '\n\e[1;31mERROR: Passwords do match, Please try again.\e[0m\n\n'
	else
		#set user password to first password entered
		userpassword=$up1
		printf '\n\e[1;32mPassword for the user account \e[33m "'$username'"\e32m has been set\e[0m\n\n'
		break
	fi
done

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
echo "$hostname" >> /etc/hostname

#Set hosts file (Network configuration)
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts

#Install base system packages for bootloader,network manager etc
pacman -S --noconfirm grub efibootmgr dosfstools mtools os-prober networkmanager bash-completion

#Configure Grub bootloader
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

#Enable Network Manager on startup
systemctl enable NetworkManager

#set users paswords and user according to variables
echo root:$rootpassword | chpasswd
useradd -m $username
echo $username:$userpassword | chpasswd
usermod -aG wheel,audio,video,power,storage $username
sed -i '114s/.//' /etc/sudoers
