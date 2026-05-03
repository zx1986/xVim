# Design Spec: Merging Unified Neovim Refactor

- **Topic**: Merging Unified Neovim Refactor
- **Date**: 2026-05-03
- **Author**: Gemini CLI

## Goal
The goal is to merge the `refactor` branch into `master`. The `refactor` branch contains a significant structural change:
- Consolidates `macos/config` and `ubuntu/config` into a root `nvim/` directory.
- Introduces `nvim/lua/platform.lua` for dynamic platform detection.
- Refactors the `Makefile` to support a unified entry point.
- Reduces total configuration lines by over 1200.

## Approach: Regular Merge
The user has chosen a **Regular Merge** to preserve the commit history of the refactor.

## Strategy: "Merge then Fix"
The user has opted to merge the changes immediately and address any potential regressions in subsequent commits, rather than exhaustive pre-merge verification.

## Implementation Steps
1. **Prepare Master**:
   - `git checkout master`
   - `git pull origin master`
2. **Execute Merge**:
   - `git merge refactor`
   - Resolve any conflicts (expected to be minimal/none as `master` was recently merged into `refactor`).
3. **Validation**:
   - Run `make help` to ensure the new Makefile is functional.
   - Verify existence of `nvim/` directory and absence of `macos/config` / `ubuntu/config`.
4. **Finalize**:
   - `git push origin master`

## Success Criteria
- `master` branch reflects the unified configuration structure.
- `make init` (macOS) and `make init` (Linux) are correctly routed via the new Makefile.
- Neovim starts correctly with the new structure (to be verified after merge).
