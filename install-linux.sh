#!/usr/bin/env bash
set -e

echo "🐧 Setting up Linux environment..."
cd "$(dirname "$0")"

# 1. Install prerequisites for Linuxbrew & Zsh via apt (Debian/Ubuntu)
echo "📦 Installing system dependencies via apt..."
if ! command -v apt-get &>/dev/null; then
  echo "⚠️  apt-get not found. This script is intended for Debian-based Linux systems."
  exit 1
fi
sudo apt-get update && sudo apt-get install -y build-essential curl git zsh stow

# 2. Ensure Homebrew (Linuxbrew) is installed & loaded
if ! command -v brew &>/dev/null; then
  if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# 3. Install packages via Homebrew bundle
echo "📦 Running brew bundle..."
brew bundle --file="./Brewfile"

# 4. Symlink configuration files
chmod +x ./link-dotfiles.sh
./link-dotfiles.sh

# 5. Install default runtimes via mise (Node LTS, pnpm, Python)
if command -v mise &>/dev/null; then
  echo "📦 Installing default runtimes via mise..."
  mise install
fi

# 6. Install desktop applications via apt (if apt-get is available)
if [[ -f "./install-linux-apps.sh" ]] && command -v apt-get &>/dev/null; then
  echo "🖥️  Installing Linux desktop applications via apt..."
  ./install-linux-apps.sh || echo "⚠️  Some applications could not be installed automatically; re-run ./install-linux-apps.sh manually if needed."
fi

# 7. Set default shell to Zsh if not already configured in user database
USER_LOGIN_SHELL="$(getent passwd "$USER" 2>/dev/null | cut -d: -f7)"
if [[ -z "$USER_LOGIN_SHELL" ]]; then
  USER_LOGIN_SHELL="$SHELL"
fi

if [[ "$(basename "$USER_LOGIN_SHELL")" != "zsh" ]]; then
  echo "🐚 Setting default shell to zsh..."
  ZSH_BIN="$(which zsh)"
  if [[ -n "$ZSH_BIN" ]]; then
    if ! grep -q -F -x "$ZSH_BIN" /etc/shells 2>/dev/null; then
      echo "$ZSH_BIN" | sudo tee -a /etc/shells
    fi
    chsh -s "$ZSH_BIN" "$USER" || chsh -s "$ZSH_BIN" || true
  fi
fi

echo ""
echo "✅ Linux setup complete! Restart your terminal or run: exec zsh"
