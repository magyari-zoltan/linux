#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install virtual box guest additions"
echo "-------------------------------------------------------------------------------"

# Install guest additions
# -----------------------
#
# Install the necessary packages for building kernel modules and managing virtual devices
pacman -S virtualbox-guest-utils --noconfirm
#
# Load the VirtualBox kernel modules
modprobe -a vboxguest vboxsf vboxvideo
sed -i 's/^MODULES=\(.*\)/MODULES=\(vboxguest vboxsf vboxvideo\)/g' /etc/mkinitcpio.conf
mkinitcpio -P
#
# Enable and start the vboxservice.service and vboxweb.service services
systemctl enable vboxservice
systemctl start vboxservice.service
#
# Add current user to vboxusers group
groupadd vboxusers
usermod -a -G vboxusers $USER
