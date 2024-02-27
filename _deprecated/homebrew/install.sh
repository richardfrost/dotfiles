#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Install the correct homebrew for each OS type
# if ["$(uname -s)" == "Darwin"; then
#   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
#   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
# fi

if [[ "$(uname -s)" == "Darwin" ]]; then
  read -e -p "Set macOS Defaults?: (y/n) " setMacOSDefaults
  if [[ "${setMacOSDefaults}" == "y" || "${setMacOSDefaults}" == 'Y' ]]; then
    echo "› OSX defaults"
    "$DOTFILES/macos/set-defaults.sh"
  fi

  read -e -p "Install Homebrew?: (y/n) " installHomebrew
  if [[ "${installHomebrew}" == "y" || "${installHomebrew}" == 'Y' ]]; then
    # Install homebrew
    "$DOTFILES/homebrew/install.sh" 2>&1

    # Upgrade homebrew
    echo "› Brew"
    brew update
    brew upgrade
    "$DOTFILES/homebrew/links.sh" 2>&1
    "$DOTFILES/homebrew/services.sh" 2>&1
  fi

  # Run Homebrew through the Brewfile
  echo "› brew bundle"
  brew bundle
fi

# TODO: Check for Homebrew
# Install Homebrew only for macOS
if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "  Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

exit 0
