source "$HOME/.env"

ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

export DISABLE_AUTO_TITLE=true
export VI_MODE_SET_CURSOR=true
export EDITOR='nvim'
plugins=(macos vi-mode history-substring-search fzf zsh-interactive-cd)

source "$ZSH/oh-my-zsh.sh"

# speed up git prompt info (manually run `git status` in the repository fixes
# this)
function git_prompt_info() {
  ref=$(git-branch-name -q -h 12 -b 64) || return
  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

# cd into projets faster
# make sure to prepend the current directory '.'
export CDPATH=.:~/Code

# Setup Homebrew
if command -v /opt/homebrew/bin/brew &>/dev/null;  then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Setup Mise
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
  eval "$(mise completion zsh)"
fi

# Custom Paths
PATHS=(
  "$HOME/.local/bin"
  "$HOME/.bin"
)

LINUX_PATHS=(
  "/usr/local/sbin"
)
if [ "$(uname)" != "Darwin" ]; then
  PATHS=("${LINUX_PATHS[@]}" "${PATHS[@]}")
fi

# Ensure custom paths are prepended and not duplicated in PATH
for entry in "${PATHS[@]}"; do
  PATH=$(echo ":$PATH:" | sed -e "s;:$entry:;:;g" -e 's/^://;s/:$//')
  export PATH="$entry:$PATH"
done

for f in ~/.sources/**/*; do
  . "$f"
done

if [ "$(uname)" != "Darwin" ]; then
  if [[ -z ${SSH_CONNECTION} ]]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
  fi
fi

if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! $TERM =~ screen ]] && [[ ! $TERM =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main
fi
