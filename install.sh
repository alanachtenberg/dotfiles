#!/usr/bin/env bash
set -e

echo "🚀 Setting up dotfiles..."
cd "$(dirname "$0")"

# 1. Symlink dotfiles into $HOME
chmod +x ./link-dotfiles.sh
./link-dotfiles.sh

# 2. Install default runtimes if mise is available in the environment
if command -v mise &>/dev/null; then
  echo "📦 Installing default runtimes via mise..."
  mise install
fi

echo "✅ Setup complete!"
