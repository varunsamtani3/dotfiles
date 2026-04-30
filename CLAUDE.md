# CLAUDE.md

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

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
| `condarc` | Conda channel/solver config |

**Edit → test workflow:**
```bash
source ~/.bash_profile   # test bash_profile changes
exec $SHELL              # full restart to test all config
direnv allow             # after editing .envrc
```

**Gotchas:**
- Starship node version display disabled — causes timeout. Don't re-enable without `command_timeout` set.
- `bash_profile` sources `bashrc`. Avoid duplicating logic between them.
- bun in PATH must come after nvm/conda in `bash_profile` to avoid override conflicts.
- Python 3.13 is default (`uv`-managed). Conda kept for legacy envs only.

---

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## 5. Response Style

**Be terse. Communicate results, not process.**

- One sentence before the first tool call stating what you're about to do.
- Brief updates at key moments: when you find something unexpected, change direction, or hit a blocker.
- End-of-turn: one or two sentences — what changed and what's next. Nothing else.
- Don't narrate what you just did ("I have now updated the file..."). The diff speaks.
- Don't add trailing summaries after completing a task unless asked.
- Match response length to task complexity: a simple question gets a direct answer, not headers and bullets.

## 6. Code Hygiene

**Don't introduce new problems while solving the stated one.**

- Never introduce security vulnerabilities: no SQL injection, XSS, command injection, hardcoded secrets, or other OWASP top 10 issues. If you spot one in existing code, flag it — don't silently fix it.
- Default to writing no comments. Only add one when the WHY is non-obvious: a hidden constraint, a subtle invariant, a workaround for a known bug. If removing the comment wouldn't confuse a future reader, don't write it.
- Don't explain WHAT the code does — well-named identifiers do that.
- Never commit secrets, credentials, or tokens. Warn loudly if asked to.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.
