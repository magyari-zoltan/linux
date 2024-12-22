#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install base linux packages"
echo "-------------------------------------------------------------------------------"

# ------------------------------------------------------------------------------
# Install base linux packages
# ------------------------------------------------------------------------------
#
# Install essetial packages
pacstrap -K /mnt base linux linux-firmware --noconfirm
echo "[✔] Base linux system installed"
#
# ------------------------------------------------------------------------------
# Essential configurations
# ------------------------------------------------------------------------------
#
# Configure fstab
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
echo "[✔] fstab config added"
