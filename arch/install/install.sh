#!/bin/bash

# ------------------------------------------------------------------------------
# Parsing options
# ------------------------------------------------------------------------------
#
# Define a function to display script usage
usage() {
  echo "Usage: $0 [OPTIONS]"
  echo "Options:"
  echo "  --hdd /dev/sda        The hard disk on which the operating system will be installed on."
  echo "  --gui dwm|gnome       The graphical user interface to be installed (if not specified, echo no gui will be installed)."
  echo "  --vboxguest           Installs vbox guest additions for virtual box like environment."
  echo "  --dev                 Installs development environtment."
  exit 1
}
#
# Default values
hdd=/dev/sda
gui=""
vboxguest="false"
dev="false"
#
# Parse command line options
while [[ $# -gt 0 ]]; do
  case "$1" in
    --hdd)
      hdd="$2"
      shift 2
      ;;
    --gui)
      gui="$2"
      shift 2
      ;;
    --vboxguest)
      vboxguest="true"
      shift
      ;;
    --dev)
      dev="true"
      shift
      ;;
    --help)
      usage
      ;;
    *)
      echo "Error: Unknown option $1"
      usage
      ;;
  esac
done
#
# Display the options
echo "-------------------------------------------------------------------------------"
echo "Installing Arch Linux"
echo "-------------------------------------------------------------------------------"
echo "Selected options:"
echo " - hdd: $hdd"
echo " - gui: $gui"
echo " - vboxguest: $vboxguest"
echo " - dev: $dev"

# Environment basic config
./configure-env.sh
./create-partition.sh ${hdd}

linux=linux
./${linux}/base-system-install.sh

# Create root home folder
home=/mnt/root
mkdir -p ${home}
echo "[x] Create root folder ('${home}')"

# Installa Arch Linux
basesystem_configure=base-system-configure.sh
cp ${linux}/${basesystem_configure} ${home}
arch-chroot /mnt /bin/bash -c "/root/${basesystem_configure}" "${hdd}"
rm ${home}/${basesystem_configure}
#
basesystem_applications=basic-applications.sh
cp ${linux}/${basesystem_applications} ${home}
arch-chroot /mnt /bin/bash -c "/root/${basesystem_applications}" "${hdd}"
rm ${home}/${basesystem_applications}

# Z Shell config
zshell=zsh.sh
cp ${linux}/${zshell} ${home}
arch-chroot /mnt /bin/bash -c "/root/${zshell}"
rm ${home}/${zshell}

# Copy config files
config=.config
mc=${config}/mc
root_config=/mnt/root/.config
skel_config=/etc/skel/.config
#
# mc configuration
mkdir -p ${root_config}
cp -r ${mc} ${root_config}
mkdir -p ${skel_config}
cp -r ${mc} ${skel_config}

gui_folder=gui
# DWM
if [ "$gui" == "dwm" ]; then
  # Dynamic Window Manager
  #
  # DWM status
  dwm_status=${config}/dwm/dwmstatus
  local_bin=/mnt/usr/local/bin
  cp ${dwm_status}/avdd ${local_bin}
  cp ${dwm_status}/avds ${local_bin}
  cp ${dwm_status}/rpid ${local_bin}
  cp ${dwm_status}/util ${local_bin}
  cp ${dwm_status}/mod  ${local_bin} -r
  #
  # Copy nitrogen configuration
  nitrogen=${config}/nitrogen
  cp -r ${nitrogen} ${skel_config}
  cp -r ${nitrogen} ${root_config}
  #
  # DWM install
  dwm=dwm.sh
  cp ${gui_folder}/${dwm} ${home}
  arch-chroot /mnt /bin/bash -c "/root/${dwm}"
  rm ${home}/${dwm}
fi

# Gnome
if [ "$gui" == "gnome" ]; then
  gnome=gnome.sh
  cp ${gui_folder}/${gnome} ${home}
  arch-chroot /mnt /bin/bash -c "/root/${gnome}"
  rm ${home}/${gnome}
fi

# Install basic gui apps
if [ ! -z "$gui" ]; then
  basesystem_gui_apps=applications.sh
  cp ${gui_folder}/${basesystem_gui_apps} ${home}
  arch-chroot /mnt /bin/bash -c "/root/${basesystem_gui_apps}"
  rm ${home}/${basesystem_gui_apps}
fi

# Virtual Box Guest
vbox=virtualbox
if [ "$vboxguest" == "true" ]; then
  guest=guest.sh
  cp ${vbox}/${guest} ${home}
  arch-chroot /mnt /bin/bash -c "/root/${guest}"
  rm ${home}/${guest}
fi

# Development tools
devtools_folder=dev
if [ "$dev" == "true" ]; then
  devtools=tools.sh
  cp ${devtools_folder}/${devtools} ${home}
  arch-chroot /mnt /bin/bash -c "/root/${devtools}"
  rm ${home}/${devtools}
fi

# ------------------------------------------------------------------------------
# System shutdown
# ------------------------------------------------------------------------------
umount -R /mnt
shutdown -h now
