# Set PATH, MANPATH, etc., for Homebrew (must be first — brew tools needed by .bashrc)
eval "$(/opt/homebrew/bin/brew shellenv)"

# uv
export PATH="/Users/varun/.local/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/varun/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/varun/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/varun/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/varun/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Source ~/.bashrc for interactive settings (aliases, prompt, completions, fzf)
# Note: Mac terminals open login shells, so .bashrc must be sourced explicitly
[[ -f ~/.bashrc ]] && source ~/.bashrc
