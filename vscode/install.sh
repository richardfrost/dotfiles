#!/usr/bin/env bash

set -e

# Windows %APPDATA%\Code\User\settings.json
# Mac $HOME/Library/Application Support/Code/User/settings.json
# Linux $HOME/.config/Code/User/settings.json

# Link VS Code User configs
# if [ "$(uname -s)" = "Darwin" ]
# then
#   echo "› Setup VSCode Config for MacOS"
#   ln -s "$DOTFILES/vscode/User" "$HOME/Library/Application Support/Code/User"
# else
#   echo "› Setup VSCode Config for Linux"
#   echo "TODO: Find destination path"
# fi
