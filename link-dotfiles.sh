#!/usr/bin/env bash
set -e

echo "🔗 Symlinking dotfiles into $HOME..."
cd "$(dirname "$0")"

# Folders to stow into $HOME
for folder in git zsh starship lazygit nvim mise ghostty; do
  if [[ -d "$folder" ]]; then
    echo "   -> Stowing $folder..."
    stow -v -R -t "$HOME" "$folder"
  fi
done

echo "✅ Dotfiles linked successfully!"
