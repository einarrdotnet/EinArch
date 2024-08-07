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


#Set password for Root account
vrp=0
while [ vrp=0 ]
do
	#Prompt user to set password for root account
	printf '\e[1;36mPease provide a password for the \e[33m"root"\e[36m system account.\e[0m\n'
	read -sp "password: " rp1
	#Prompt user to verify password for root account
	printf '\n\e[1;36mPlease verify password for the\e[33m "root"\e[36m system account.\e[0m\n'
	read -sp "Verify Password: " rp2

	if [ "$rp1" != "$rp2" ]; then 
		vrp=0
		printf "\n\e[1;31mError: Passwords do match please try again\e[0m\n\n"
	else
		rootpassword=$rp1
		printf '\n\e[1;32mPassword has been set for\e[33m"root"\e36m system account\e[0m\n\n'
	
		break
	fi
done

#Set Password for user account
vup=0
while [ vup=0 ]
do
	#promt user to set password for user account
	printf '\e[1;36mPease provide a password for the user account \e[33m"'$username'"\e[36m.\e[0m\n'
	read -sp "password: " up1
	#prompt user to verify password for user account
	printf '\n\e[1;36mPlease verify password. for the user account \e[33m"'$username'"\e[36m\e[0m\n'
	read -sp "Verify Password: " up2

	if [ "$up1" != "$up2" ]; then 
		printf "\n\e[1;31mError: Passwords do not match please try again\e[0m\n\n"
		vup=0
	else
		userpassword=$up1
		printf '\n\e[1;32Pasword has set for the user account \e[33m"'$username'".\e[0m\n\n'
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
