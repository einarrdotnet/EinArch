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
