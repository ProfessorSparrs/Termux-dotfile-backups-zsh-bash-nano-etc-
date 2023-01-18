#!/bin/bash

# Reset the PATH variable to its default value in Bash and zsh
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# Reset the PATH variable to its default value in fish
if command -v fish >/dev/null 2>&1; then
    fish -c "set -gx PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games /usr/local/games"
fi

# Print the new value of the PATH variable
echo "PATH is now set to: $PATH"
