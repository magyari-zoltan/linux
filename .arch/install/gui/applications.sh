#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install basic gui applications"
echo "-------------------------------------------------------------------------------"

#
# File manager
pacman -S pcmanfm --noconfirm
echo "[✔] File manager"
#
# Firefox
pacman -S firefox --noconfirm
echo "[✔] Firefox"
#
# Virtualbox
pacman -S virtualbox virtualbox-guest-iso virtualbox-host-modules-arch virtualbox-guest-utils --noconfirm
echo "[✔] Firefox"
