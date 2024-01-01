#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install Gnome"
echo "-------------------------------------------------------------------------------"

#
# Update system
pacman -Syu --noconfirm
#
# Install Gnome
pacman -S gnome --noconfirm
systemctl enable gdm
systemctl start gdm
