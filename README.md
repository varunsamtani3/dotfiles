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
| `agents-global.md` | `~/.claude/CLAUDE.md`, `~/.config/opencode/AGENTS.md` | Universal behavioral guidelines shared by all AI coding tools |

`AGENTS.md` (project context for AI tools in this repo) and `CLAUDE.md` (one-line `@AGENTS.md` import stub) are repo-local and not symlinked.

## Fresh machine setup

### 1. Prerequisites

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install core tools
brew install bash bash-completion@2 fzf starship direnv node ripgrep fd bat eza zoxide tldr
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
git clone https://github.com/varunsamtani3/dotfiles.git ~/workspace/mac_utils
cd ~/workspace/mac_utils

ln -s "$PWD/bash_profile" ~/.bash_profile
ln -s "$PWD/bashrc" ~/.bashrc
mkdir -p ~/.config/direnv
ln -s "$PWD/direnvrc" ~/.config/direnv/direnvrc
ln -s "$PWD/direnv-config.toml" ~/.config/direnv/config.toml
mkdir -p ~/.config/ghostty
ln -s "$PWD/ghostty-config" ~/.config/ghostty/config
```

### 4. Install global uv tools

```bash
uv tool install jupyterlab   # required for Jupyter kernel auto-registration in direnvrc
uv tool install ipython
uv tool install ruff
```

### 5. (Removed) llm conda environment

The Miniconda `llm` env was removed in favor of uv. Its full package list is preserved in `conda-llm-env-backup.txt` in this repo if anything needs reinstalling.

### 6. Configure git

```bash
git config --global user.name "Varun Samtani"
git config --global user.email "varunsamtani3@gmail.com"
git config --global credential.helper osxkeychain
```

### 7. Install Claude Code

```bash
npm install -g @anthropic-ai/claude-code
```

### 8. Set up GitHub MCP for Claude Code

```bash
claude mcp add github -e GITHUB_PERSONAL_ACCESS_TOKEN=<token> -- npx -y @modelcontextprotocol/server-github
```

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
