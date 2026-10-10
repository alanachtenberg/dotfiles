# Cross-Platform Dotfiles (macOS, Linux & Dev Containers)

Clean, automated configuration for macOS, Linux, and Dev Containers using **Homebrew**, **GNU Stow**, and **Zsh**.

## Included Tools & Stack
- **Shell**: Zsh + [Starship](https://starship.rs/) prompt + [Atuin](https://atuin.sh/) (history) + [Zoxide](https://github.com/ajeetdsouza/zoxide) (smart jump) + [Fzf](https://github.com/junegunn/fzf)
- **Zsh Plugins**: `zsh-autosuggestions` & `zsh-syntax-highlighting`
- **Modern CLI**: `bat`, `eza`, `fd`, `ripgrep`, `dust`, `jq`, `tldr`
- **Git**: `gh`, `lazygit`, `git-delta`
- **Workflow & Environment**: `mise` (polyglot runtimes: Node.js LTS, pnpm, Python), `btop` (monitoring), `lazydocker`, `micro`, `neovim`, `stow`

> 💡 *For keybindings, fuzzy search shortcuts, and aliases, see **[SHORTCUTS.md](SHORTCUTS.md)**.*

---

## One-Command Setup

> 🔄 **Idempotent Setup**: All installation scripts (`install-macos.sh`, `install-linux.sh`, `install.sh`, and `link-dotfiles.sh`) are fully idempotent. Re-running them at any time safely updates packages, restows symlinks, and refreshes runtimes without duplicates or errors.
>
> ⏱️ **Interactive Step Pauses**: Root installation scripts pause for 15 seconds before each subsequent step. You can press `Enter` to continue immediately, or press `Ctrl+C` to abort if an error or warning occurred in the previous step. To run non-interactively without pauses, set `PAUSE_TIMEOUT=0`.

Clone the repository to `~/dotfiles`:
```bash
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### On macOS
```bash
chmod +x install-macos.sh
./install-macos.sh
```
*Installs Homebrew (if needed), CLI tools & cross-platform casks via `Brewfile`, macOS-only GUI apps via `Brewfile.macos`, and links dotfiles.*

### On Linux
```bash
chmod +x install-linux.sh
./install-linux.sh
```
*Installs build dependencies via `apt`, Homebrew, CLI tools via `Brewfile`, Linux application equivalents via `apt` (`install-linux-apps.sh`), links dotfiles, and sets Zsh as default shell. For manual AppImage/snap setups (e.g. JetBrains Toolbox), see [MANUAL_INSTALLS_LINUX.md](MANUAL_INSTALLS_LINUX.md).*

### In Dev Containers / Codespaces
GitHub Codespaces automatically runs `install.sh` upon container creation. To run manually:
```bash
chmod +x install.sh
./install.sh
```
*Symlinks your dotfiles into `$HOME` via `link-dotfiles.sh` and runs `mise install` if available. (To strictly symlink configs without running tools, run `./link-dotfiles.sh`).*

---

## Private / Work Secrets & Identity

Do not commit corporate credentials, private API keys, or personal emails to this public repo.

### 1. Shell Secrets (`~/.zshrc.local`)
Keep all private tokens, API keys, and corporate paths in `~/.zshrc.local`. It is automatically sourced by `~/.zshrc` and excluded from Git.

### 2. Git Identity (`~/.gitconfig.local`)
To set your name and email on each machine without committing it to the repo:
```gitconfig
# ~/.gitconfig.local
[user]
  name = Your Name
  email = your.email@example.com
```
This file is automatically included by `~/.gitconfig` and ignored globally.
