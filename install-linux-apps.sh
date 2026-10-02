#!/usr/bin/env bash
set -e

echo "🐧 Installing Linux application equivalents via apt..."
cd "$(dirname "$0")"

if ! command -v apt-get &>/dev/null; then
  echo "⚠️  apt-get not found. This script requires a Debian/Ubuntu-based system."
  exit 1
fi

echo "🔄 Updating apt package list..."
sudo apt-get update

# ==============================================================================
# 1. Terminal: Ghostty
# ==============================================================================
if command -v ghostty &>/dev/null; then
  echo "✅ Ghostty is already installed."
elif apt-cache show ghostty &>/dev/null; then
  echo "📦 Installing Ghostty via apt..."
  sudo apt-get install -y ghostty
elif command -v add-apt-repository &>/dev/null; then
  if ! grep -q -s -r "mkasberg/ghostty-ubuntu" /etc/apt/sources.list* 2>/dev/null; then
    echo "📦 Adding Ghostty community PPA..."
    sudo add-apt-repository -y ppa:mkasberg/ghostty-ubuntu || true
    sudo apt-get update || true
  fi
  echo "📦 Installing Ghostty via apt..."
  sudo apt-get install -y ghostty || echo "ℹ️  Could not install Ghostty via PPA. See MANUAL_INSTALLS_LINUX.md for alternative install methods."
else
  echo "ℹ️  Ghostty is not available in standard apt repos. See MANUAL_INSTALLS_LINUX.md to install via snap or binary."
fi

# ==============================================================================
# 2. Productivity: JetBrains Toolbox
# ==============================================================================
if command -v jetbrains-toolbox &>/dev/null || [[ -d "$HOME/.local/share/JetBrains/Toolbox" ]]; then
  echo "✅ JetBrains Toolbox is already installed."
else
  echo "ℹ️  JetBrains Toolbox is not distributed via apt. See MANUAL_INSTALLS_LINUX.md for manual AppImage setup."
fi

echo ""
echo "✅ Linux application setup finished! For manual tools, see MANUAL_INSTALLS_LINUX.md"
