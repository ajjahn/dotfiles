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

export VI_MODE_SET_CURSOR=true
plugins=(git macos vi-mode history-substring-search fzf tmux zsh-interactive-cd)

source $ZSH/oh-my-zsh.sh

# speed up git prompt info (manually run `git status` in the repository fixes
# this)
function git_prompt_info() {
  ref=$(git-branch-name -q -h 12 -b 64) || return
  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

# cd into projets faster
# make sure to prepend the current directory '.'
export CDPATH=.:~/Code


export EDITOR='nvim'

export DISABLE_AUTO_TITLE=true

export SAM_CLI_TELEMETRY=0 

for f in ~/.sources/**/*; do
  . $f
done


# linux:
# if [[ -z "${SSH_CONNECTION}" ]]; then
#     export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# fi

if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! $TERM =~ screen ]] && [[ ! $TERM =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main
fi
