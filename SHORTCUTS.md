# Shell Shortcuts & Keybindings Reference

This document provides a quick reference for all interactive shortcuts, keybindings, and productivity aliases configured in these dotfiles.

---

## Keybinding Hierarchy & Layering (No Conflicts)

```
┌─────────────────────────────────────────────────────────────┐
│ 1. Terminal Emulator (Ghostty)                              │
│    Keys: Super (Cmd on macOS) or Ctrl+Shift                 │
├─────────────────────────────────────────────────────────────┤
│ 2. Workspace Multiplexer (Herdr)                            │
│    Keys: Prefix-based (Ctrl+B then key)                     │
├─────────────────────────────────────────────────────────────┤
│ 3. Interactive Shell & Tools (Zsh, Atuin, Fzf, Zoxide)      │
│    Keys: Direct Ctrl, Alt, and Tab keys                     │
└─────────────────────────────────────────────────────────────┘
```

---

## 1. Workspace & Agent Multiplexer (Herdr)

[Herdr](https://herdr.dev) manages terminal workspaces, tabs, and coding agent processes. All Herdr actions use the **`Ctrl + B`** prefix.

| Shortcut            | Action             | Description                                              |
| :------------------ | :----------------- | :------------------------------------------------------- |
| `Ctrl + B` `?`      | Help Menu          | Open interactive keybinding reference inside Herdr       |
| `Ctrl + B` `c`      | New Tab            | Create a new terminal tab in current workspace           |
| `Ctrl + B` `n`      | Next Tab           | Switch to next tab                                       |
| `Ctrl + B` `p`      | Previous Tab       | Switch to previous tab                                   |
| `Ctrl + B` `w`      | Workspace Picker   | Open interactive workspace switcher                      |
| `Ctrl + B` `N`      | New Workspace      | Create a new workspace (`Ctrl+B` then `Shift+N`)         |
| `Ctrl + B` `G`      | New Git Worktree   | Create workspace from Git worktree (`Ctrl+B` `Shift+G`)  |
| `Ctrl + B` `s`      | Settings           | Open Herdr configuration settings                        |
| `Ctrl + B` `q`      | Detach Session     | Detach client (leaves agents and background tasks running)|

---

## 2. Shell History Search (Atuin)

[Atuin](https://atuin.sh/) replaces traditional shell history with an encrypted, SQLite-backed database with contextual search.

| Shortcut            | Action             | Description                                              |
| :------------------ | :----------------- | :------------------------------------------------------- |
| `Ctrl + R`          | History Search     | Opens interactive full-screen history search interface   |
| `Enter`             | Run Command        | Executes the highlighted command immediately             |
| `Tab`               | Edit Command       | Copies highlighted command to shell prompt for editing   |
| `Ctrl + O`          | Inspect Inspector  | Shows execution metadata (exit code, duration, directory)|
| `Ctrl + D`          | Delete Entry       | Removes selected command from history                    |

> **Search Tips in Atuin**:
> - Type search terms separated by spaces to filter across command text.
> - Press **`Ctrl + R`** again inside the search view to toggle search filter modes: `GLOBAL`, `HOST`, `SESSION`, `DIRECTORY`.

---

## 3. Fuzzy Finding & Completions (Fzf)

[Fzf](https://github.com/junegunn/fzf) provides lightning-fast fuzzy selection for files, directories, and arguments.

| Shortcut            | Action             | Description                                              |
| :------------------ | :----------------- | :------------------------------------------------------- |
| `Ctrl + T`          | Fuzzy File Picker  | Fuzzy search files/dirs; pastes path into command line   |
| `Alt + C`           | Fuzzy Directory CD | Fuzzy search subdirectories and cd into selection        |
| `**` + `Tab`        | Fuzzy Completion   | Triggers fuzzy completion for paths, processes, hosts    |

> **Fuzzy Completion (`**<Tab>`) Examples**:
> - `nvim **<Tab>`: Fuzzy pick a file to open in your editor.
> - `cd **<Tab>`: Fuzzy pick any child directory to change into.
> - `kill -9 **<Tab>`: Fuzzy pick a running process to kill.
> - `ssh **<Tab>`: Fuzzy pick a host from `~/.ssh/config` or `/etc/hosts`.
> - `export **<Tab>`: Fuzzy pick an environment variable to modify.

---

## 4. Smart Directory Navigation (Zoxide)

[Zoxide](https://github.com/ajeetdsouza/zoxide) remembers the directories you visit most frequently ("frecency").

| Command             | Action             | Description                                              |
| :------------------ | :----------------- | :------------------------------------------------------- |
| `z <name>`          | Smart Jump         | Jump directly to matching directory (e.g. `z dot`)       |
| `zi`                | Interactive Jump   | Open interactive fzf menu to search and jump to folder   |
| `z -`               | Previous Directory | Return to previous working directory                     |

---

## 5. Zsh Autosuggestions (Fish-like)

As you type, ghost text suggests matching completions based on your recent commands.

| Shortcut            | Action             | Description                                              |
| :------------------ | :----------------- | :------------------------------------------------------- |
| `→` (Right Arrow)   | Accept Suggestion  | Accept entire inline ghost text suggestion               |
| `Alt + →`           | Accept Next Word   | Accept only the next word of ghost text suggestion       |
| `End` / `Ctrl + E`  | Accept Suggestion  | Alternative key to accept entire suggestion              |

---

## 6. Terminal Aliases

Configured shell convenience aliases:

| Alias               | Target Command          | Description                                              |
| :------------------ | :---------------------- | :------------------------------------------------------- |
| `l`                 | `eza --icons`           | Modern file listing with icons and color styling         |
| `ll`                | `eza -la --icons --git` | Detailed list with hidden files, sizes, and Git status   |

---

## 7. Editors & Runtime Management

| Tool                | Role               | Notes                                                    |
| :------------------ | :----------------- | :------------------------------------------------------- |
| `micro`             | Default Git Editor | Fast, intuitive editor for commits/rebases (`Ctrl+S`, `Q`)|
| `nvim`              | Modal Text Editor  | Full Neovim configuration (`<Space>` is leader key)      |
| `mise`              | Runtime Manager    | `mise ls`, `mise use <tool>@<ver>`, `mise install`       |
| `delta`             | Git Diff Pager     | Syntax-highlighting diff viewer in git diff & lazygit    |
