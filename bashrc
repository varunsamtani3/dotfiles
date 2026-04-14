# ─── History ──────────────────────────────────────────────────────────────────
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
shopt -s histappend                      # append rather than overwrite history

# ─── Editor ───────────────────────────────────────────────────────────────────
export EDITOR="vim"
export VISUAL="$EDITOR"

# ─── Aliases — Navigation ─────────────────────────────────────────────────────
alias ll='ls -lhF'
alias la='ls -lahF'
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
alias py='python'
alias venv='uv venv'          # create a new venv: venv .venv
alias pipi='uv pip install'   # fast package install

# ─── Aliases — System ─────────────────────────────────────────────────────────
alias clr='clear'
alias ut='uptime'

# ─── fzf — Fuzzy finder ───────────────────────────────────────────────────────
# Ctrl+R  → fuzzy history search
# Ctrl+T  → fuzzy file insert
# Alt+C   → fuzzy cd
eval "$(fzf --bash)"

# ─── direnv — Per-project env vars (.envrc files) ─────────────────────────────
eval "$(direnv hook bash)"

# ─── Starship prompt — git branch, conda env, python version inline ───────────
eval "$(starship init bash)"

# ─── bash-completion@2 ────────────────────────────────────────────────────────
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && \
    . "/opt/homebrew/etc/profile.d/bash_completion.sh"
