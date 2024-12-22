#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Configure installation environment"
echo "-------------------------------------------------------------------------------"

# ------------------------------------------------------------------------------
# Installation environment basic config
#
# # not mandatory for linux installation
# ------------------------------------------------------------------------------
#
# Keyboard layout
loadkeys hu101
echo "[✔] Set keyboard layout (hu101)"
#
# Update time
timedatectl set-ntp true
echo "[✔] Update time from time server"
#
# Update keys
pacman-key --init
pacman-key --populate
echo "[✔] Keyring update"
