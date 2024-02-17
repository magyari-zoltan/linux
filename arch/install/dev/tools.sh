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
home=~
zshrc=.zshrc
curl -L https://git.io/n-install | bash -s -- -y -a arch
echo 'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).' >> ${home}/${zshrc}
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
#
n lts

# Python
pacman -S python --noconfirm

# Java
pacman -S jdk-openjdk --noconfirm
pacman -S maven --noconfirm

# Clojure
pacman -S leiningen --noconfirm

# Purescript
npm install -g purescript
npm install -g spago

# Vim linters
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
# Install docker compose
curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep docker-compose-linux-x86_64 | cut -d '"' -f 4 | wget -qi -
chmod +x docker-compose-linux-x86_64
mv docker-compose-linux-x86_64 /usr/local/bin/docker-compose
