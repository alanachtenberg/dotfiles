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

echo "🚀 Setting up dotfiles..."
cd "$(dirname "$0")"

# 1. Symlink dotfiles into $HOME
chmod +x ./link-dotfiles.sh
./link-dotfiles.sh

pause_step "Step 2: Installing default runtimes via mise"

# 2. Install default runtimes if mise is available in the environment
if command -v mise &>/dev/null; then
  echo "📦 Installing default runtimes via mise..."
  mise install
else
  echo "ℹ️  mise is not installed or not in PATH; skipping runtime installation."
fi

echo "✅ Setup complete!"
