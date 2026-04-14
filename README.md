# dotfiles

Personal dotfiles for macOS — shell config, Python/ML environment setup, and developer tooling.

## What's in here

| File | Symlink target | Purpose |
|------|---------------|---------|
| `bash_profile` | `~/.bash_profile` | Login shell: PATH, Homebrew, conda init, sources bashrc |
| `bashrc` | `~/.bashrc` | Interactive shell: aliases, history, fzf, starship, direnv |
| `condarc` | `~/.condarc` | conda config: conda-forge channel, auto-activate disabled |
| `direnvrc` | `~/.config/direnv/direnvrc` | Global direnv layout: uv venv + Jupyter kernel auto-registration |

## Fresh machine setup

### 1. Prerequisites

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install core tools
brew install bash bash-completion@2 fzf starship direnv node

# Install uv (standalone, not via conda)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Miniconda (for existing llm env / heavy ML deps)
# Download from https://docs.conda.io/en/latest/miniconda.html
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
ln -s "$PWD/condarc" ~/.condarc
mkdir -p ~/.config/direnv
ln -s "$PWD/direnvrc" ~/.config/direnv/direnvrc
```

### 4. Install global uv tools

```bash
uv tool install jupyterlab   # required for Jupyter kernel auto-registration in direnvrc
uv tool install ipython
uv tool install ruff
```

### 5. Restore the llm conda environment (optional)

```bash
conda activate llm
pip install anthropic openai litellm mlflow polars duckdb chromadb nbstripout
```

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

### Key aliases

```bash
gs        # git status
gd        # git diff
glog      # git log --oneline --graph --decorate --all
ll        # ls -lhF
la        # ls -lahF
venv      # uv venv
pipi      # uv pip install
py        # python
```

---

## Stack

- **Shell**: bash 5.x (Homebrew), starship prompt
- **Python manager**: uv (project envs) + Miniconda (llm env)
- **Default Python**: 3.13
- **ML env**: `conda activate llm` — transformers, HuggingFace, PyTorch, Jupyter
- **Experiment tracking**: MLflow
- **Data tools**: polars, duckdb
- **LLM clients**: anthropic, openai, litellm
- **Code quality**: ruff
