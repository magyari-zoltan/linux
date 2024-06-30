#!/bin/bash

source user/configure
source lib/configure
source apps/apps
source dotfiles/dotfiles

# Setup linux
function setup() {
  configure_user
  install_applications
  restore_dotfiles
  echo "Setup was successfull"
}

source lib/options
