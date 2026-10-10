#!/usr/bin/env bash
set -e

pause_step() {
  local message="${1:-the next step}"
  local timeout="${PAUSE_TIMEOUT:-15}"

  if [[ "$timeout" -le 0 ]] || [[ -n "${CI:-}" ]]; then
    return 0
  fi

  echo ""
  echo "⏸️  Pausing ${timeout}s before ${message}. Press Enter to continue now, or Ctrl+C to cancel..."
  if [ -t 0 ]; then
    read -t "$timeout" || true
  else
    sleep "$timeout"
  fi
  echo ""
}

echo "🐧 Setting up Linux environment..."
cd "$(dirname "$0")"

# 1. Install prerequisites for Linuxbrew & Zsh via apt (Debian/Ubuntu)
echo "📦 Installing system dependencies via apt..."
if ! command -v apt-get &>/dev/null; then
  echo "⚠️  apt-get not found. This script is intended for Debian-based Linux systems."
  exit 1
fi
sudo apt-get update && sudo apt-get install -y build-essential curl git zsh stow

pause_step "Step 2: Homebrew setup"

# 2. Ensure Homebrew (Linuxbrew) is installed & loaded
echo "🍺 Checking Homebrew..."
if command -v brew &>/dev/null; then
  echo "✅ Homebrew is already installed: $(brew --version 2>/dev/null | head -n 1)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  echo "📦 Loading Homebrew environment..."
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  echo "✅ Homebrew loaded."
else
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

pause_step "Step 3: Running brew bundle"

# 3. Install packages via Homebrew bundle
echo "📦 Running brew bundle..."
brew bundle --file="./Brewfile"

pause_step "Step 4: Symlinking configuration files"

# 4. Symlink configuration files
chmod +x ./link-dotfiles.sh
./link-dotfiles.sh

pause_step "Step 5: Installing default runtimes via mise"

# 5. Install default runtimes via mise (Node LTS, pnpm, Python)
if command -v mise &>/dev/null; then
  echo "📦 Installing default runtimes via mise..."
  mise install
else
  echo "ℹ️  mise is not installed or not in PATH; skipping runtime installation."
fi

pause_step "Step 6: Installing desktop applications via apt"

# 6. Install desktop applications via apt (if apt-get is available)
if [[ -f "./install-linux-apps.sh" ]] && command -v apt-get &>/dev/null; then
  echo "🖥️  Installing Linux desktop applications via apt..."
  ./install-linux-apps.sh || echo "⚠️  Some applications could not be installed automatically; re-run ./install-linux-apps.sh manually if needed."
else
  echo "ℹ️  install-linux-apps.sh not found or apt-get unavailable; skipping desktop apps."
fi

pause_step "Step 7: Configuring default shell to zsh"

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
    echo "✅ Default shell changed to zsh."
  fi
else
  echo "✅ Default shell is already configured to zsh ($USER_LOGIN_SHELL)."
fi

echo ""
echo "✅ Linux setup complete! Restart your terminal or run: exec zsh"
