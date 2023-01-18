#!/bin/bash

echo "This script will backup all important dotfiles in Termux."
echo "Enter 'y' to continue, or anything else to cancel."
read -r user_input

if [ "$user_input" = "y" ]; then
  # Create a backup directory
  echo "Creating backup directory at ~/.dotfiles_backup"
  mkdir ~/.dotfiles_backup

  # Find dotfiles to include in the backup
  dotfiles=`find ~ -maxdepth 1 -type f -name ".*"`

  # Copy dotfiles to the backup directory with progress bar
  echo "Backing up dotfiles to ~/.dotfiles_backup"
  find ~ -maxdepth 1 -type f -name ".*" | pv -l | xargs -I{} cp {} ~/.dotfiles_backup

  # Print confirmation message
  echo "All dotfiles backed up to ~/.dotfiles_backup"
else
  echo "Cancelled."
fi


