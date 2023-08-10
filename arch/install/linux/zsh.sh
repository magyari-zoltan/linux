#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install zsh"
echo "-------------------------------------------------------------------------------"

# Z Shell
# -------
pacman -S zsh zsh-completions powerline-fonts --noconfirm

# Oh My Zsh
share=/usr/local/share
ohmyzsh=.oh-my-zsh
git clone http://github.com/robbyrussell/oh-my-zsh ${share}/${ohmyzsh}

home=~
zshrc=.zshrc
mv -b ${share}/${ohmyzsh}/templates/zshrc.zsh-template ${home}/${zshrc}
sed -i 's/export ZSH=$HOME\/.oh-my-zsh/export ZSH=\/usr\/local\/share\/.oh-my-zsh/g' ${home}/${zshrc}
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="risto"/g' ${home}/${zshrc}
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g' ${home}/${zshrc}

skel=/etc/skel
cp ${home}/${zshrc} ${skel}

# Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${share}/${ohmyzsh}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${share}/${ohmyzsh}/plugins/zsh-autosuggestions

# Setting Z Shell as default
chsh -s /bin/zsh
