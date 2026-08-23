# dotfiles

Personal dotfiles for macOS — shell config, Python/ML environment setup, and developer tooling.

## What's in here

| File | Symlink target | Purpose |
|------|---------------|---------|
| `bash_profile` | `~/.bash_profile` | Login shell: PATH, Homebrew, sources bashrc |
| `bashrc` | `~/.bashrc` | Interactive shell: aliases, history, fzf, starship, direnv |
| `direnvrc` | `~/.config/direnv/direnvrc` | Global direnv layout: uv venv + Jupyter kernel auto-registration |
| `direnv-config.toml` | `~/.config/direnv/config.toml` | Whitelist: auto-allows `.envrc` under `~/workspace` |
| `ghostty-config` | `~/.config/ghostty/config` | Ghostty terminal: bash 5 login shell, FiraCode Nerd Font, Gruvbox Dark, transparency |
| `agents-global.md` | `~/.config/opencode/AGENTS.md` | Behavioral guidelines loaded into every opencode session |
| `RTK.md` | `~/.config/opencode/RTK.md` | rtk proxy reference (loaded via `opencode.jsonc` instructions) |
| `opencode.jsonc` | `~/.config/opencode/opencode.jsonc` | opencode config: instruction files, MCP servers |

`AGENTS.md` is repo-local project context for AI tools working in this repo.

## Fresh machine setup

### 1. Prerequisites

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install core tools
brew install bash bash-completion@2 fzf starship direnv node ripgrep fd bat eza zoxide tldr rtk ast-grep
brew install --cask ghostty

# Install uv (standalone)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install uv-managed Python as the global default (~/.local/bin shims)
uv python install 3.13 --default
```

### 2. Switch to Homebrew bash

```bash
sudo sh -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
chsh -s /opt/homebrew/bin/bash
```

### 3. Clone and symlink dotfiles

```bash
git clone https://github.com/varunsamtani3/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles

ln -s "$PWD/bash_profile" ~/.bash_profile
ln -s "$PWD/bashrc" ~/.bashrc
mkdir -p ~/.config/direnv
ln -s "$PWD/direnvrc" ~/.config/direnv/direnvrc
ln -s "$PWD/direnv-config.toml" ~/.config/direnv/config.toml
mkdir -p ~/.config/ghostty
ln -s "$PWD/ghostty-config" ~/.config/ghostty/config
mkdir -p ~/.config/opencode/plugins
ln -s "$PWD/agents-global.md" ~/.config/opencode/AGENTS.md
ln -s "$PWD/RTK.md" ~/.config/opencode/RTK.md
ln -s "$PWD/opencode.jsonc" ~/.config/opencode/opencode.jsonc
```

### 4. Install global uv tools

```bash
uv tool install jupyterlab   # required for Jupyter kernel auto-registration in direnvrc
uv tool install ipython
uv tool install ruff
uv tool install gitingest    # packs a repo into a single LLM-ready text block
```

### 5. Configure git

```bash
git config --global user.name "Varun Samtani"
git config --global user.email "varunsamtani3@gmail.com"
git config --global credential.helper osxkeychain
```

### 6. Set up AI token optimization (rtk)

`rtk` is a CLI proxy that filters/summarizes command output before it reaches LLM context (60-90% savings). The opencode plugin at `~/.config/opencode/plugins/rtk.ts` transparently rewrites commands (`git status` -> `rtk git status`) — zero token overhead.

```bash
# Installs the opencode plugin
rtk init -g --opencode

# RTK.md and opencode.jsonc are already symlinked from step 3;
# RTK.md is loaded into every session via the instructions array in opencode.jsonc
```

Useful commands:

```bash
rtk gain              # token savings dashboard
rtk proxy <cmd>       # run a command without rtk filtering (debugging)
```

### 7. Set up GitHub MCP for opencode

Already wired and enabled in `opencode.jsonc`. The token lives in the macOS keychain (primary) with a gitignored backup file in the repo root (recovery). `bash_profile` resolves it automatically — no plaintext token in any tracked file.

```bash
# 1. Store token in keychain (paste when prompted)
security add-generic-password -a "$USER" -s opencode-github-pat -w

# 2. Backup copy (gitignored, never committed)
printf '%s' '<your-token>' > .env.secrets

# 3. Verify
source ~/.bash_profile
echo ${#GITHUB_PERSONAL_ACCESS_TOKEN}   # should print token length
opencode mcp list                        # github server listed
```

To rotate: update both places above; nothing else references the raw value.

---

## New project workflow

```bash
mkdir ~/workspace/my-project && cd ~/workspace/my-project
git init
echo "3.13" > .python-version       # pin Python version
echo "layout uv" > .envrc           # auto-creates .venv + registers Jupyter kernel
direnv allow
uv pip install <packages>
```

direnv will automatically:
- Create `.venv` using Python 3.13
- Activate it on `cd` in, deactivate on `cd` out
- Register the project as a Jupyter kernel (named after the folder)

---

## Shell features

| Shortcut | Action |
|----------|--------|
| `Ctrl+R` | Fuzzy history search (fzf) |
| `Ctrl+T` | Fuzzy file insert (fzf) |
| `Alt+C` | Fuzzy cd into subdirectory (fzf) |
| `z <name>` | Jump to frequently used directory (zoxide) |

### Key aliases

```bash
gs        # git status
gd        # git diff
glog      # git log --oneline --graph --decorate --all
ll        # eza -lh --git --icons=auto
la        # eza -lha --git --icons=auto
venv      # uv venv
pipi      # uv pip install
```

---

## Stack

- **Shell**: bash 5.x (Homebrew), starship prompt, Ghostty terminal
- **Python manager**: uv — project envs via direnv, global shims via `uv python install --default`
- **Default Python**: 3.13
- **Experiment tracking**: MLflow
- **Data tools**: polars, duckdb
- **LLM clients**: anthropic, openai, litellm
- **Code quality**: ruff
- **AI token optimization**: rtk proxy via opencode plugin, ast-grep, gitingest
