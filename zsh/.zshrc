# ==============================================================================
# Homebrew Shell Environment
# Automatically detects Apple Silicon, Linuxbrew, or Intel macOS paths
# ==============================================================================
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Ensure unique entries in PATH when .zshrc is reloaded
typeset -U path PATH

# Ensure user local binaries are on PATH
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# ==============================================================================
# Brew-Installed Zsh Plugins (Fish-like experience)
# ==============================================================================
if command -v brew &>/dev/null; then
  BREW_PREFIX="$(brew --prefix)"

  # Autosuggestions (ghost text as you type; hit Right-Arrow to complete)
  if [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi

  # Syntax Highlighting (valid commands green, typos red) - MUST be sourced last
  if [[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi
fi

# ==============================================================================
# Interactive Tool Initializations
# ==============================================================================
command -v starship &>/dev/null && eval "$(starship init zsh)"
command -v zoxide   &>/dev/null && eval "$(zoxide init zsh)"
# Fzf provides Ctrl+T (files), Alt+C (cd), and tab completion; Atuin loads after so Atuin owns Ctrl+R
command -v fzf      &>/dev/null && source <(fzf --zsh)
command -v atuin    &>/dev/null && eval "$(atuin init zsh)"
command -v mise     &>/dev/null && eval "$(mise activate zsh)"

# ==============================================================================
# Aliases & Quality of Life
# ==============================================================================
alias l="eza --icons"
alias ll="eza -la --icons --git"

# Intentionally left unaliased to maintain broad script, pipeline, and AI agent compatibility:
# alias cat="bat"
# alias ls="eza"

# ==============================================================================
# Machine-Local Overrides (Work tokens, private secrets, custom paths)
# This file is gitignored so your public dotfiles repo stays clean and safe.
# ==============================================================================
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
