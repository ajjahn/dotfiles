#!/usr/bin/env bash

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install brew formulas in Brewfile
brew bundle --file="$(dirname "$0")/Brewfile"

# Install dotfiles
rcup

# Setup Ruby
rbenv init
LATEST_RUBY_VERSION="$(rbenv install -l | grep -v - | tail -1 | tr -d '[[:space:]]')"
rbenv install -s $LATEST_RUBY_VERSION
rbenv global $LATEST_RUBY_VERSION

# Install global language packages
install-gems
install-npm-packages
install-pip-packages

# Configure macOS
source "$(dirname "$0")/config-macos"
