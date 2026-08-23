# RTK - Rust Token Killer

**Usage**: Token-optimized CLI proxy (60-90% savings on dev operations)

The opencode plugin (`~/.config/opencode/plugins/rtk.ts`) transparently rewrites commands before execution: `git status` -> `rtk git status`. Zero token overhead.

## Meta Commands (always use rtk directly)

```bash
rtk gain              # Show token savings analytics
rtk proxy <cmd>       # Execute raw command without filtering (for debugging)
```

## Installation Verification

```bash
rtk --version         # Should show: rtk X.Y.Z
which rtk             # Verify correct binary
```

⚠️ **Name collision**: If `rtk gain` fails, you may have reachingforthejack/rtk (Rust Type Kit) installed instead.
