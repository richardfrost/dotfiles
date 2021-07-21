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

# TODO: Check for Homebrew
# Install Homebrew only for macOS
if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "  Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

exit 0
