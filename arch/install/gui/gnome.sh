#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install Gnome"
echo "-------------------------------------------------------------------------------"

# Install Gnome
pacman -S gnome --noconfirm
systemctl enable gdm
systemctl start gdm
