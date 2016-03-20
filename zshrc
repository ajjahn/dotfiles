# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vi='/usr/local/bin/vi'
alias vim='/usr/local/bin/vim'
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

source ~/.whatismyip.sh
source ~/.aliases
source ~/.env

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git bundler vagrant gem osx rvm pow powder vi-mode history-substring-search)

source $ZSH/oh-my-zsh.sh

# OPAM configuration
#.
/Users/ajjahn/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Tmuxinator Config
export EDITOR='vim'
source ~/.bin/tmuxinator.zsh
export DISABLE_AUTO_TITLE=true

# VIM Like navigation
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# bind UP and DOWN arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
