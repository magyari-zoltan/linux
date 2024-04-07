#!/bin/bash

# ------------------------------------------------------------------------------
# Create build environment
# ------------------------------------------------------------------------------

# Install archiso package
pacman -Syu --noconfirm
pacman -S archiso --noconfirm

# Making directory structure
ArchLiveISO=~/ArchLiveISO
rm -r ${ArchLiveISO}
mkdir -p ${ArchLiveISO}/{out,work}

# Choose profile: baseline / releng
profile=releng
cp -r /usr/share/archiso/configs/${profile} ${ArchLiveISO}

# Create build script for buildin the ISO
build=build.sh
echo "#!/bin/bash" > ${ArchLiveISO}/${build}
echo "rm -r work" >> ${ArchLiveISO}/${build}
echo "rm -r out" >> ${ArchLiveISO}/${build}
echo "pacman -Scc --noconfirm" >> ${ArchLiveISO}/${build}
echo "mkarchiso -v -w work -o out ${profile}" >> ${ArchLiveISO}/${build}
chmod +x ${ArchLiveISO}/${build}

# ------------------------------------------------------------------------------
# Customize iso package
# ------------------------------------------------------------------------------

# Packages to be installed
packages=${profile}/packages.x86_64
echo "git" >> ${ArchLiveISO}/${packages}


home=root
root=airootfs
install=.init.sh

echo "#!/bin/bash" > ${ArchLiveISO}/${profile}/${root}/${home}/${install}
echo "loadkeys hu101" >> ${ArchLiveISO}/${profile}/${root}/${home}/${install}
echo "git clone https://github.com/devbysp/linux.git" >> ${ArchLiveISO}/${profile}/${root}/${home}/${install}
chmod +x ${ArchLiveISO}/${profile}/${root}/${home}/${install}

# File permissions
profiledef=profiledef.sh
sed -i '/file_permissions/a \ \ ["/root/.init.sh"]="0:0:700"' ${archliveiso}/${profile}/${profiledef}
sed -i '/^APPEND/ s/$/ script=.init.sh/' ${ArchLiveISO}/${profile}/syslinux/archiso_sys-linux.cfg

# Neo vim config
vim=.config/nvim
git clone https://github.com/devbysp/nvim
cp -r ${vim} ${ArchLiveISO}/${profile}/${root}/${home}
cp ${vim}/.vimrc ${ArchLiveISO}/${profile}/${root}/${home}
rm -r ${vim}
