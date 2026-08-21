# ─── History ──────────────────────────────────────────────────────────────────
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTTIMEFORMAT='%F %T '           # timestamps in history output
shopt -s histappend                      # append rather than overwrite history
shopt -s checkwinsize cdspell dirspell histverify   # resize fix, typo-tolerant cd, confirm history edits

# ─── Editor ───────────────────────────────────────────────────────────────────
export EDITOR="vim"
export VISUAL="$EDITOR"

# ─── Aliases — Navigation ─────────────────────────────────────────────────────
alias ll='eza -lh --git --icons=auto'
alias la='eza -lha --git --icons=auto'
alias ..='cd ..'
alias ...='cd ../..'

# ─── Aliases — Git ────────────────────────────────────────────────────────────
alias gs='git status'
alias gd='git diff'
alias glog='git log --oneline --graph --decorate --all'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# ─── Aliases — Python / uv ────────────────────────────────────────────────────
# Global python/pip resolve via uv-managed shims in ~/.local/bin (first on PATH)
alias venv='uv venv'          # create a new venv: venv .venv
alias pipi='uv pip install'   # fast package install
# Global CLI tools → uv tool install <tool>  (e.g. uv tool install ruff)

# ─── Aliases — System ─────────────────────────────────────────────────────────
alias clr='clear'
alias ut='uptime'
alias brewup='brew update && brew upgrade && brew cleanup'

# ─── fzf — Fuzzy finder ───────────────────────────────────────────────────────
# Ctrl+R  → fuzzy history search
# Ctrl+T  → fuzzy file insert
# Alt+C   → fuzzy cd
eval "$(fzf --bash)"

# ─── zoxide — Smarter cd that learns frequent dirs ─────────────────────────────
eval "$(zoxide init bash)"   # usage: z <partial-dir-name>

# ─── direnv — Per-project env vars (.envrc files) ─────────────────────────────
eval "$(direnv hook bash)"

# ─── Starship prompt — git branch, conda env, python version inline ───────────
eval "$(starship init bash)"

# ─── bash-completion@2 ────────────────────────────────────────────────────────
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && \
    . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# ─── Readline — friendlier tab completion ──────────────────────────────────────
bind 'set completion-ignore-case on'    # Tab ignores case
bind 'set show-all-if-ambiguous on'     # single Tab lists all matches
bind 'set colored-stats on'             # colorize completion listings
