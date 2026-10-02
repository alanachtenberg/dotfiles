#!/usr/bin/env bash
set -e

echo "🍎 Setting up macOS environment..."
cd "$(dirname "$0")"

# 1. Ensure Homebrew is installed & loaded
if ! command -v brew &>/dev/null; then
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f "/usr/local/bin/brew" ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  fi
fi

# 2. Install all CLI tools via Homebrew
echo "📦 Running brew bundle for CLI tools..."
brew bundle --file="./Brewfile"

# 3. Install macOS-only GUI applications and casks
if [[ -f "./Brewfile.macos" ]]; then
  echo "🖥️  Running brew bundle for macOS applications..."
  brew bundle --file="./Brewfile.macos"
fi

# 4. Symlink configuration files
chmod +x ./link-dotfiles.sh
./link-dotfiles.sh

# 5. Install default runtimes via mise (Node LTS, pnpm, Python)
if command -v mise &>/dev/null; then
  echo "📦 Installing default runtimes via mise..."
  mise install
fi

echo ""
echo "✅ macOS setup complete! Restart your terminal or run: exec zsh"
