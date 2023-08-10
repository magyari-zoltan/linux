#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install virtual box guest additions"
echo "-------------------------------------------------------------------------------"

# Install guest additions
# -----------------------
#
pacman -S virtualbox-guest-utils --noconfirm
systemctl enable vboxservice
groupadd vboxusers
usermod -a -G vboxusers $USER
