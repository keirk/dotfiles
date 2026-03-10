# ~/.zshrc

# Mise runtime manager (only load if installed)
export PATH="$HOME/.local/bin:$PATH"

if [ -x "$HOME/.local/bin/mise" ]; then
  eval "$(mise activate zsh)"
fi


# claude 
alias yolo="claude --dangerously-skip-permissions"

# Java (macOS)
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH="$JAVA_HOME/bin:$PATH"

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"

# GHCup (Haskell)
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

# libpq (PostgreSQL client tools)
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

eval "$(starship init zsh)"

