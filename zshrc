# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

source ~/.aliases
source ~/.env
for f in ~/.sources/**/*; do
  . $f
done

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
plugins=(git bundler gem macos vi-mode history-substring-search fzf)

source $ZSH/oh-my-zsh.sh

# cd into projets faster
# make sure to prepend the current directory '.'
export CDPATH=.:~/Code

# OPAM configuration
#.
.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Tmuxinator Config
export EDITOR='nvim'
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


export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:/usr/local/sbin"

eval "$(rbenv init - zsh)"



export PATH="$HOME/.cargo/bin:$PATH"

export PATH="`npm bin -g`:$PATH" # npm
export PATH="$PATH:`yarn global bin`" # yarn

#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# eval "$(direnv hook zsh)"
# source ~/.gpgrc

# set autoload path
fpath=(~/.shell "${fpath[@]}")
# move cursor to end of line after history search completion
# autoload -Uz history-search-end cani vmc vmi lps kp fp cani bip bup bcp tmuxify utils ll lx
# autoload -Uz 'brew.sh'
# every time we load .zshrc, ditch duplicate path entries
typeset -U PATH fpath

if [ -e /Users/ajjahn/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/ajjahn/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

. /usr/local/opt/asdf/asdf.sh

export SAM_CLI_TELEMETRY=0 

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
