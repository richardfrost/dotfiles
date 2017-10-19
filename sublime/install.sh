#!/usr/bin/env bash

set -e

# Link Sublime Text 3 User configs
if [ "$(uname -s)" = "Darwin" ]
then
  echo "› Setup Sublime Text 3 Config for MacOS"
  ln -s "$DOTFILES/sublime/User" "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
else
  echo "› Setup Sublime Text 3 Config for Linux"
  echo "TODO: Find destination path"
fi

echo "  Install Package Control: https://packagecontrol.io/installation"
