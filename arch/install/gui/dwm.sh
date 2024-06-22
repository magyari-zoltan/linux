#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install DWM"
echo "-------------------------------------------------------------------------------"

# Install prerequisits for GUI
# ----------------------------
#
# Update system
pacman -Syu --noconfirm
#
# Minimal X server running on a Linux system
#  - xorg-server: provides the infrastructure for creating and managing graphical user interfaces
#  - xorg-xinit: starts the X server and loads config from .xinitrc
#  - xorg-xrandr: hotplug, screen resolution, rotation, orientation ...
pacman -S xorg-server xorg-xinit xorg-xrandr --noconfirm
#
# Set the root window properties of the X server.
#  - background color:\> xsetroot -solid black
#  - backgriund image:\> xsetroot -bitmap /path/to/background.png
pacman -S xorg-xsetroot --noconfirm
#
#  - libx11: provides the basic functionality for communicating with the X Window System server.
#  - libxinerama: nables multiple physical monitors to be treated as a single, logical display.
#  - libfxt: rendering fonts in graphical applications
pacman -S libx11 libxinerama libfxt
#
# It is needed to start dwm.
# It provides a set of libraries and tools for embedding web content in GTK+ applications.
pacman -S webkit2gtk --noconfirm
#
# Graphical card driver
pacman -S mesa --noconfirm
pacman -S xf86-video-ati --noconfirm      # AMD
pacman -S xf86-video-intel --noconfirm    # Intel
pacman -S xf86-video-nvidia --noconfirm   # NVIDIA

# Configure .xinitrc
# ------------------
#
# Create .xinitrc
touch ~/.xinitrc
#
# Keyboard Layout
echo 'setxkbmap hu -model "pc101" -variant "101_qwerty_comma_dead" &' >> ~/.xinitrc
#
# Display Resolution
echo 'xrandr --output Virtual-1 --mode 1920x1080 &' >> ~/.xinitrc
#
# Status display
echo 'slstatus &' >> ~/.xinitrc
#
# Display Resolution
echo 'xsetroot -solid "#1D2133"' >> ~/.xinitrc
#
# Pulsewire
echo 'pipewire &' >> ~/.xinitrc
echo 'pipewire-pulse & ' >> ~/.xinitrc
#
# Execute DWM
echo 'exec dwm' >> ~/.xinitrc
#
# Copy config file to skel
cp ~/.xinitrc /etc/skel/.xinitrc

install=~/.install
mkdir -p ${install}

# Install suckless apps
# ---------------------
#
# DWM
cd ${install}
git clone https://git.suckless.org/dwm
cd ${install}/dwm
#
# Set default font
sed -i 's/\(.*\)col_cyan\[\]\( *\)= "#\([0-9]\{6\}\)";/\1col_cyan[]\2= "#202530";/g' config.def.h
#
make clean install

# Install siple terminal from suckless
cd ${install}
git clone https://git.suckless.org/st
cd ${install}/st
#
# Apply color scheme patches
patch=$(curl -s https://st.suckless.org/patches/colorschemes/ | grep -o 'st-colorschemes-[0-9\.]*\.diff' | head -n 1)
git apply < <(curl -s https://st.suckless.org/patches/colorschemes/${patch})
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
# Status display
echo 'slstatus &' >> ~/.xinitrc
#
make clean install

# Install dmenu from suckless
cd ${install}
git clone https://git.suckless.org/dmenu
cd ${install}/dmenu
#
make clean install

# Install sltatus from suckless
cd ${install}
git clone https://git.suckless.org/slstatus
cd ${install}/slstatus
# Configure status
sed -i 's/\(.*\)datetime,\(.*\)$/  { cpu_perc,     "  %s%% |",          NULL              },\n  { ram_used,     "  %s",              NULL              },\n  { ram_total,    " (free: %s) |",      NULL              },\n  { disk_used,    "  %s",              "/"               },\n  { disk_total,   " (free: %s) |",      "/"               },\n	{ datetime,     " %s ",                "%A %d | %H:%M"  }\n/g' config.def.h
#
make clean install

# Install alsa utils
# ------------------------------------------------------------------------------
#
pacman -S alsa-utils --noconfirm
