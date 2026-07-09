# zmodload zsh/zprof
source "$HOME/.env"

export DISABLE_AUTO_TITLE=true
export EDITOR='nvim'

autoload -Uz compinit
compinit

# cd into projets faster
# make sure to prepend the current directory '.'
export CDPATH=.:~/Code

# Setup Homebrew
if command -v /opt/homebrew/bin/brew &>/dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Setup Mise
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
  eval "$(mise completion zsh)"
fi

# Setup fzf shell history
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

# Setup starship shell prompt
if command -v starship &>/dev/null; then
  eval "$(starship init zsh --print-full-init)"
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

function tm() {
  [[ -n $TMUX ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1")
    return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) && tmux $change -t "$session" || echo "No sessions found."
}

# Do we need this?:
export UV_LINK_MODE=hardlink
