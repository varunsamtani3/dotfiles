# Set PATH, MANPATH, etc., for Homebrew (must be first — brew tools needed by .bashrc)
eval "$(/opt/homebrew/bin/brew shellenv)"

# uv-managed python shims (python, python3, pip) live here — keep first on PATH
export PATH="/Users/varun/.local/bin:$PATH"

# Source ~/.bashrc for interactive settings (aliases, prompt, completions, fzf)
# Note: Mac terminals open login shells, so .bashrc must be sourced explicitly
[[ -f ~/.bashrc ]] && source ~/.bashrc

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Obsidian second brain vault (used by obsidian-second-brain agent skills)
export OBSIDIAN_VAULT_PATH="$HOME/Documents/SecondBrain"

# opencode: never read Claude Code fallback paths (~/.claude/*)
export OPENCODE_DISABLE_CLAUDE_CODE=1

# GitHub PAT for the opencode GitHub MCP: keychain first, gitignored backup file second
export GITHUB_PERSONAL_ACCESS_TOKEN="$(security find-generic-password -a "$USER" -s opencode-github-pat -w 2>/dev/null)"
if [[ -z "$GITHUB_PERSONAL_ACCESS_TOKEN" && -f "$HOME/workspace/dotfiles/.env.secrets" ]]; then
  export GITHUB_PERSONAL_ACCESS_TOKEN="$(cat "$HOME/workspace/dotfiles/.env.secrets")"
fi
