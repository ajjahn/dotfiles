#!/usr/bin/env bash

set -e

# Install Homebrew
echo "Install Homebrew"
if test ! "$(which brew)"; then
  echo "Installing homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install brew formulas in Brewfile
echo "Install Homebrew packages"
set +e
brew bundle --file="$(dirname "$0")/Brewfile"
set -e

# Install dotfiles
rcup

./install/ruby
./install/gems
./install/python
./install/python-packages
./install/node-packages
./install/cargo-packages
./install/go-packages

cp ./install/*.ttf ~/Library/Fonts/

# Configure macOS
source "$(dirname "$0")/config-macos"
