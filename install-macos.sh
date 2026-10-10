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

echo "🍎 Setting up macOS environment..."
cd "$(dirname "$0")"

# 1. Ensure Homebrew is installed & loaded
echo "🍺 Checking Homebrew..."
if command -v brew &>/dev/null; then
  echo "✅ Homebrew is already installed: $(brew --version 2>/dev/null | head -n 1)"
elif [[ -f "/opt/homebrew/bin/brew" ]]; then
  echo "📦 Loading Homebrew environment..."
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "✅ Homebrew loaded."
elif [[ -f "/usr/local/bin/brew" ]]; then
  echo "📦 Loading Homebrew environment..."
  eval "$(/usr/local/bin/brew shellenv)"
  echo "✅ Homebrew loaded."
else
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

pause_step "Step 2: CLI tools installation via Brewfile"

# 2. Install all CLI tools via Homebrew
echo "📦 Running brew bundle for CLI tools..."
brew bundle --file="./Brewfile"

pause_step "Step 3: macOS applications via Brewfile.macos"

# 3. Install macOS-only GUI applications and casks
if [[ -f "./Brewfile.macos" ]]; then
  echo "🖥️  Running brew bundle for macOS applications..."
  brew bundle --file="./Brewfile.macos"
else
  echo "ℹ️  Brewfile.macos not found; skipping macOS applications."
fi

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

echo ""
echo "✅ macOS setup complete! Restart your terminal or run: exec zsh"
