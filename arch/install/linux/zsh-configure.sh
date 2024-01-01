echo "-------------------------------------------------------------------------------"
echo "Configure zsh"
echo "-------------------------------------------------------------------------------"
# ------------------------------------------------------------------------------
# Parsing options
# ------------------------------------------------------------------------------
#
# Default values
dev="true"
#
# Parse command line options
if [ ! -z "$1" ]; then
    dev="$1"
fi
#
# Display the options
echo "Selected options:"
echo " - dev: $dev"


# ------------------------------------------------------------------------------
# Global configuration
# ------------------------------------------------------------------------------
echo 'alias ls="exa --icons"' >> ~/.zshrc

# ------------------------------------------------------------------------------
# Dev env config option
# ------------------------------------------------------------------------------
if [ "$dev" == "true" ]; then
  #
  # Creating aliases
  # dockerd       : start docker daemon
  # dockerd-stop  : stop docker daemon
  echo 'alias dockerd="/usr/local/bin/dockerd &> /dev/null&"' >> ~/.zshrc
  echo 'alias dockerd-stop="pkill dockerd -e&"' >> ~/.zshrc
fi
