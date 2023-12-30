#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install DWM"
echo "-------------------------------------------------------------------------------"

# Install prerequisits for GUI
# ----------------------------
#
# Xorg packages
pacman -S xorg-server xorg-xinit xorg-xrandr xorg-xsetroot --noconfirm
#
# Rendering background
pacman -S nitrogen --noconfirm
#
# Window compositor: transparency, transition animations, shadows ...
pacman -S picom --noconfirm
#
# It is needed to start dwm.
pacman -S webkit2gtk --noconfirm
#
# Graphical card driver
pacman -S mesa --noconfirm
pacman -S xf86-video-ati --noconfirm

# Configure .xinitrc
# ------------------
#
# Copy .xinitrc template to home folder
cp /etc/X11/xinit/xinitrc ~/.xinitrc
#
# Disable some setting
sed -i 's/^twm/# twm/g' ~/.xinitrc
sed -i 's/^xclock/# xclock/g' ~/.xinitrc
sed -i 's/^xterm/# xterm/g' ~/.xinitrc
sed -i 's/^exec xterm/# exec xterm/g' ~/.xinitrc
#
# Keyboard Layout
echo 'setxkbmap hu -model "pc101" -variant "101_qwerty_comma_dead" &' >> ~/.xinitrc
#
# Display Resolution
echo 'xrandr --output Virtual-1 --mode 1920x1080 &' >> ~/.xinitrc
#
# Compositor
echo 'picom -f &' >> ~/.xinitrc
#
# Set wallpaper
echo 'nitrogen --restore &' >> ~/.xinitrc
#
# Status display
echo 'avdd "disk mem bat dt" &' >> ~/.xinitrc
echo 'avds "bat dt" m true &' >> ~/.xinitrc
echo 'avds "disk mem" 5000 true &' >> ~/.xinitrc
#
# Execute DWM
echo 'exec dwm' >> ~/.xinitrc
#
# Copy config file to skel
cp ~/.xinitrc /etc/skel/.xinitrc

# Install suckless apps
# ---------------------
#
# DWM
cd ~
git clone https://git.suckless.org/dwm
cd ~/dwm
make clean install
cd ~
rm ~/dwm -r

# Install siple terminal from suckless
cd ~
git clone https://git.suckless.org/st
cd ~/st
#
# Apply color scheme patches
patch=$(curl -s https://st.suckless.org/patches/colorschemes/ | grep -o 'st-colorschemes-[0-9\.]*\.diff' | head -n 1)
git apply < <(curl -L curl -s https://st.suckless.org/patches/colorschemes/${patch})
#
config_def=config.def.h
temp_file=/tmp/moved_lines
destinationline=$(grep -n "static const ColorScheme schemes" ${config_def} | cut -d':' -f1)
startline=$(grep -n "Alacritty (dark)" ${config_def} | cut -d':' -f1)
endline=$(expr ${startline} + 6)
#
sed -n "${startline},${endline}w ${temp_file}" $config_def
sed -i "${startline},${endline}d" $config_def
sed -i "${destinationline}r ${temp_file}" $config_def
rm $temp_file
#
# Set default font
sed -i 's/\(.*\)font = ".*:pixelsize=12\(.*\)";/\1font = "FreeMono:pixelsize=16\2";/g' config.def.h
#
make clean install
cd ~
rm ~/st -r

# Install dmenu from suckless
cd ~
git clone https://git.suckless.org/dmenu
cd ~/dmenu
make clean install
cd ~
rm ~/dmenu -r

# Install alsa utils
# ------------------------------------------------------------------------------
#
pacman -S alsa-utils --noconfirm
