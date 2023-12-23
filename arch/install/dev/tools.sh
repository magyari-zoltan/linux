#!/bin/bash

echo "-------------------------------------------------------------------------------"
echo "Install development area"
echo "-------------------------------------------------------------------------------"

# JavaScript
# ----------
# n-installer: Node version manager
#
# Instead of installing a fix version of node with the following command:
# \> pacman -S nodejs npm --noconfirm
#
# It can be installed any version of node any time with the following commands:
# \> n install 14.15.4
# \> n latest
#
curl -L https://git.io/n-install | bash -s -- -y -a arch
n lts

# Python
pacman -S python --noconfirm

# Java
pacman -S jdk-openjdk --noconfirm

# Vim linters
# TODO: this might be obsolate with the new vim-lsp plugin
npm install --global typescript eslint prettier fixjson stdio
pacman -S python-lsp-server ruff python-pylint --noconfirm

# Pure script formatter
npm install --global purs-tidy

# Docker
# ------
#
# Download docker client & server binaries
wget https://download.docker.com/linux/static/stable/x86_64/docker-24.0.5.tgz
tar -xzvf docker-24.0.5.tgz
cp docker/* /usr/local/bin
rm docker -r
#
# Creating aliases
# dockerd       : start docker daemon
# dockerd-stop  : stop docker daemon
echo 'alias dockerd="/usr/local/bin/dockerd &> /dev/null&"' >> ~/.zshrc
echo 'alias dockerd-stop="pkill dockerd -e&"' >> ~/.zshrc
#
# Install docker compose
curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep docker-compose-linux-x86_64 | cut -d '"' -f 4 | wget -qi -
chmod +x docker-compose-linux-x86_64
mv docker-compose-linux-x86_64 /usr/local/bin/docker-compose
