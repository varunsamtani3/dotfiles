# AGENTS.md

Project-specific instructions for AI coding agents working in this repo. Universal behavioral guidelines are shared globally via `agents-global.md`.

## Project: mac_utils

macOS dotfiles and shell config repo. Files edited directly — no symlink manager.

**Key files:**

| File | Purpose |
|------|---------|
| `bash_profile` | Login shell: PATH, env vars, aliases. Load order matters. |
| `bashrc` | Interactive shell: prompt, completions, functions |
| `starship.toml` | Starship prompt config |
| `direnvrc` | Global direnv hooks — loaded by all `.envrc` files |
| `.envrc` | Per-dir env activation via direnv |

**Edit → test workflow:**
```bash
source ~/.bash_profile   # test bash_profile changes
exec $SHELL              # full restart to test all config
direnv allow             # after editing .envrc
```

**Gotchas:**
- Starship node version display disabled — causes timeout. Don't re-enable without `command_timeout` set.
- `bash_profile` sources `bashrc`. Avoid duplicating logic between them.
- bun is prepended to PATH after `.bashrc` sourcing — keep that line last in `bash_profile`.
- Python 3.13 is default (`uv`-managed via `~/.local/bin` shims). No conda.

