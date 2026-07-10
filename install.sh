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
eval "$(MISE_BIN activate bash --shims)"

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


# # Install brew formulas in Brewfile
# echo "Install Homebrew packages"
# set +e
# brew trust --formula hashicorp/tap/vagrant
# brew trust --formula derailed/k9s/k9s
# # brew trust --formula autozimu/formulas/unison-fsmonitor
# # brew trust --formula coursier/formulas/coursier
# # brew trust --formula itchyny/tap/git-branch-name
# # brew trust --formula localstack/tap/localstack-cli
# # brew trust --formula sandreas/tap/m4b-tool sandreas/tap/mp4v2
# brew bundle --file="$(dirname "$0")/Brewfile"
# set -e
#
# # Install dotfiles
# rcup
#
# # eval "$(mise activate bash --shims)"
# mise install

# ./install/gems
# ./install/go-packages

cp ./install/*.ttf ~/Library/Fonts/

# Configure macOS
source "$(dirname "$0")/config-macos"
