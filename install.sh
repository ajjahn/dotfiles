#!/usr/bin/env bash
set -euo pipefail

MISE_CONFIG_URL="${MISE_CONFIG_URL:-https://raw.githubusercontent.com/ajjahn/dotfiles/refs/heads/main/config/mise/config.toml}"

tmp_dir="$(mktemp -d)"

cleanup() {
  rm -rf "$tmp_dir"
}

trap cleanup EXIT

if ! command -v mise &>/dev/null; then
  echo "Installing mise..."
  curl -fsSL https://mise.run | sh
fi

if command -v mise >/dev/null 2>&1; then
  MISE_BIN="$(command -v mise)"
elif [[ -x "$HOME/.local/bin/mise" ]]; then
  MISE_BIN="$HOME/.local/bin/mise"
else
  echo "Error: mise was installed, but the executable could not be found." >&2
  exit 1
fi
echo "Using mise at: $MISE_BIN"
# eval "$(MISE_BIN activate bash --shims)"

if test ! "$(which brew)"; then
  echo "Installing homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Downloading mise.toml..."
curl -fsSL "$MISE_CONFIG_URL" -o "$tmp_dir/mise.toml"

echo "Running mise bootstrap..."
(
  cd "$tmp_dir"
  "$MISE_BIN" trust mise.toml
  "$MISE_BIN" bootstrap --yes
)

# ./install/gems
# ./install/go-packages

cp ./install/*.ttf ~/Library/Fonts/

# Configure macOS
source "$(dirname "$0")/config-macos"
