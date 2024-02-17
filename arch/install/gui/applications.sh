#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install basic gui applications"
echo "-------------------------------------------------------------------------------"

# GUI for ufw
pacman -S gufw --noconfirm
echo "[✔] Gui for firewall"
#
# File manager
pacman -S pcmanfm --noconfirm
echo "[✔] File manager"
#
# Install Gnome
pacman -S firefox --noconfirm
echo "[✔] Firefox"
#
# Virtualbox
pacman -S virtualbox virtualbox-guest-iso virtualbox-host-modules-arch virtualbox-guest-utils --noconfirm
echo "[✔] Firefox"
