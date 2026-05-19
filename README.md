# dotfiles

Personal config files, managed via symlinks from `$HOME`.

## Layout

```
dotfiles/
├── shell/        zshrc, zshenv, profile
├── git/          gitconfig, gitignore_global, gitconfig.local.example
├── editor/
│   ├── nvim/     full Neovim config (init.lua, lua/, plugin/, after/)
│   └── zed/      settings.json, keymap.json
├── terminal/     tmux.conf, ghostty.config
├── Brewfile      Homebrew packages (use with `brew bundle`)
├── install.sh    symlink configs into $HOME (idempotent, backs up first)
└── uninstall.sh  remove symlinks and restore most recent backup
```

## Bootstrap on a new machine

```sh
git clone <this-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
cp git/gitconfig.local.example ~/.gitconfig.local
$EDITOR ~/.gitconfig.local   # fill in name + email for this machine
```

Existing files at target paths are moved to `~/.dotfiles_backup/<timestamp>/`
before being replaced with symlinks. Running `install.sh` again is safe — it
reports `OK` for links that are already correct.

### Machine-specific git identity

The committed `git/gitconfig` has **no `[user]` block**. Instead, it ends with
`[include] path = ~/.gitconfig.local`, so each machine sets its own identity
in `~/.gitconfig.local` (untracked). This lets the same dotfiles work on a
personal machine and a work machine with different GitHub accounts.

On first run, `install.sh` auto-migrates any existing `[user]` block from a
pre-existing `~/.gitconfig` (name, email, signingkey) into `~/.gitconfig.local`
before replacing the file. This means on a work machine that already has a
gitconfig, you don't have to do anything manually — the existing identity is
preserved.

If no `~/.gitconfig.local` ends up existing after install (e.g. the original
file had no `[user]` block), `install.sh` prints a reminder with the exact
command to create one from the template.

### Homebrew packages

The `Brewfile` lists core tooling installed via Homebrew. It is not symlinked —
run it from inside the repo:

```sh
cd ~/dotfiles
brew bundle                              # install everything in Brewfile
brew bundle cleanup --force              # remove anything NOT in Brewfile
brew bundle dump --file=Brewfile --force # refresh Brewfile from current state
```

## Adding a new config

1. **Move** the real config file into the appropriate folder in this repo.
2. **Register** it in the `MANIFEST` array in **both** `install.sh` and
   `uninstall.sh`. Each entry is `"source:target"`, where `source` is relative
   to this repo and `target` is relative to `$HOME`.
3. **Link** it by running `./install.sh` (creates the symlink, no-op if
   already linked).
4. **Commit** the new file and manifest changes.

Example — adding a Starship prompt config at `~/.config/starship.toml`:

```sh
mv ~/.config/starship.toml ~/dotfiles/shell/starship.toml
# Edit install.sh + uninstall.sh, add to MANIFEST:
#   "shell/starship.toml:.config/starship.toml"
./install.sh
git add -A && git commit -m "Add starship config"
```

## Removing a single tracked config

When you no longer want a file managed by this repo:

1. **Unlink** the symlink in `$HOME`: `rm ~/.path/to/config`
2. **Delete** the file from the repo: `rm ~/dotfiles/<folder>/<file>`
3. **Unregister** by removing its line from `MANIFEST` in both `install.sh`
   and `uninstall.sh`.
4. **Commit** the removal.

Example — removing a tmux config:

```sh
rm ~/.tmux.conf
rm ~/dotfiles/terminal/tmux.conf
# Remove "terminal/tmux.conf:.tmux.conf" from MANIFEST in both scripts
git add -A && git commit -m "Remove tmux config"
```

## Uninstalling everything

```sh
./uninstall.sh
```

Removes every symlink this repo owns from `$HOME`. If a backup exists in
`~/.dotfiles_backup/`, the most recent copy is restored in place. The repo
itself is untouched — delete `~/dotfiles` manually if you want it gone.

## Cheatsheet

`cheatsheet.html` is a standalone, single-file reference page covering all
keybindings and settings. No server or build step needed — open it directly in
a browser:

```sh
open ~/dotfiles/cheatsheet.html       # macOS
xdg-open ~/dotfiles/cheatsheet.html   # Linux
```

Covers: Neovim navigation · editing · LSP · autocompletion · git · avante.nvim · tmux.

## AI (avante.nvim)

The Neovim config includes [avante.nvim](https://github.com/yetone/avante.nvim),
a Claude-powered AI assistant embedded in the editor.

**First-time setup:**

```sh
export ANTHROPIC_API_KEY=your-key   # add to ~/.zshrc or ~/.profile
```

Then inside Neovim:

```
:PackerSync
```

**Key bindings (leader = Space):**

| Key | Action |
|-----|--------|
| `<leader>aa` | Ask Claude about current code |
| `<leader>ae` | Edit selected code with Claude |
| `<leader>at` | Toggle chat sidebar |
| `<leader>af` | Focus sidebar |
| `<leader>ar` | Refresh last response |
| `co` / `ct` | Accept your / Claude's diff |
| `]x` / `[x` | Jump between diff hunks |

**Typical workflow:** visually select code → `<leader>ae` → describe the
change → `Ctrl+s` to submit → accept or reject the diff.

## What's intentionally not tracked

- SSH keys, GPG keys, auth tokens, `.env` files (see `.gitignore`)
- Shell history, completion caches, editor swap files
- Language toolchains (`.nvm`, `.cargo`, `.rustup`, etc.)
- Framework installs like `.oh-my-zsh` — bootstrap those separately
