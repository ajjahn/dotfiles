#!/usr/bin/env bash

set -e

# Install Homebrew
echo "Install Homebrew"
if test ! "$(which brew)"; then
  echo "Installing homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install brew formulas in Brewfile
echo "Install Homebrew packages"
set +e
brew bundle --file="$(dirname "$0")/Brewfile"
set -e

# Install dotfiles
rcup

eval "$(mise activate bash --shims)"
mise install

./install/gems
./install/go-packages

cp ./install/*.ttf ~/Library/Fonts/

# Configure macOS
source "$(dirname "$0")/config-macos"
