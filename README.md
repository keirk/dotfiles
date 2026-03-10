# dotfiles

Personal dotfiles for macOS — tmux, Ghostty, Starship prompt, and zsh.

## What's included

| Tool | Config | Description |
|------|--------|-------------|
| **tmux** | `tmux/.tmux.conf` | tmux2k theme, C-a prefix, vim-style pane navigation |
| **Ghostty** | `ghostty/config` | FiraCode Nerd Font, macOS option-as-alt |
| **Starship** | `starship/starship.toml` | Nerd Font Symbols + Bracketed Segments presets |
| **zsh** | `zsh/.zshrc` | mise runtime manager, Starship init, PATH setup |

## Setup on a new machine

### 1. Install dependencies

```bash
# Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core tools
brew install bash tmux starship

# Fonts
brew install font-fira-code-nerd-font

# Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 2. Clone and install

```bash
git clone https://github.com/keirk/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

This creates symlinks from the standard config paths to the repo. Any existing files are backed up with a `.bak` extension.

### 3. Finish tmux setup

Open tmux and install plugins:

```bash
tmux
# Press C-a + I (capital I) to install TPM plugins
# Press C-a + r to reload config
```

### 4. Restart your terminal

Ghostty needs a full restart for font changes to take effect.

## Updating

Since configs are symlinked, any edits are reflected in the repo immediately:

```bash
cd ~/dotfiles
git add -A && git commit -m "Update configs" && git push
```

On another machine, pull the latest:

```bash
cd ~/dotfiles && git pull
```

No need to re-run `install.sh` — the symlinks already point to the right files.
