#!/bin/bash

# Make sure the script is being run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Reset the PATH variable to its default value in Bash and zsh
echo "export PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games\"" >> /etc/bash.bashrc
echo "export PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games\"" >> /etc/zsh/zshenv

# Reset the PATH variable to its default value in fish
echo "set -gx PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games /usr/local/games" >> /etc/fish/config.fish

# Print the new value of the PATH variable
echo "PATH is now set to: $PATH"
