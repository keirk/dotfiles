#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        rm "$dst"
    elif [ -e "$dst" ]; then
        echo "  Backing up existing $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi

    ln -s "$src" "$dst"
    echo "  $dst -> $src"
}

echo "Installing dotfiles..."
echo ""

# Tmux
link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Ghostty
link "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

# Starship
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

# Zsh
link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

echo ""
echo "Done! You may also want to install dependencies:"
echo ""
echo "  brew install bash starship font-fira-code-nerd-font"
echo "  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
echo "  # Then open tmux and press prefix + I to install plugins"
echo ""
