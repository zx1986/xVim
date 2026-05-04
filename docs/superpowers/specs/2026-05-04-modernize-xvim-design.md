# Design Spec: Modernize xVim (macOS-Only & Clean Lua)

- **Topic**: Modernize xVim for macOS and Pure Neovim Lua
- **Date**: 2026-05-04
- **Author**: Gemini CLI

## Goal
Streamline the xVim repository by removing legacy Vim configurations, Ubuntu support, and offline installation logic. The result will be a lean, macOS-focused Neovim configuration repository using modern Lua-based patterns.

## Architecture Changes

### 1. Cleanup of Redundant Components
We will remove all files and directories that are no longer relevant to a macOS-only, Neovim-centric environment.

- **Directories to Remove**:
  - `ubuntu/`: Contains Linux-specific installation scripts, Docker setups, and offline manifests.
  - `macos/`: Contains outdated documentation that will be merged into the root `README.md`.
- **Legacy Files to Remove**:
  - `vimrc.bootstrap`: Large legacy Vim configuration (approx. 19k lines).
  - `vimrc.local`: Legacy local Vim overrides.
  - `vimrc.local.bundles`: Legacy Vim plugin management.

### 2. Makefile Simplification
The root `Makefile` will be refactored to focus exclusively on macOS.

- **Removed**: OS detection (`uname -s`), Linux-specific targets (`_init-linux`, `_clean-linux`), and complex provider management for unused languages (e.g., Ruby).
- **Core Targets**:
  - `init`: Install macOS dependencies via Homebrew, symlink `nvim/` to `~/.config/nvim`, and bootstrap `lazy.nvim`.
  - `update`: Synchronize plugins via Lazy and update Mason packages.
  - `clean`: Remove the symlink and Neovim data/cache directories.

### 3. Neovim Configuration Refactor
The Lua configuration within `nvim/` will be simplified by removing platform and offline detection.

- **`nvim/lua/platform.lua`**: Removed or simplified to only provide `is_macos` if still needed, but likely merged into `init.lua` for simplicity.
- **`nvim/init.lua`**: Remove logic that disables plugin updates in "offline mode".

### 4. Documentation
The root `README.md` will be updated to reflect the new, simplified installation process and remove all references to Ubuntu/Offline mode.

## Approach: Destructive Cleanup
Since the goal is to "stop considering" these environments, we will perform a direct removal of files and a rewrite of the core orchestration logic (`Makefile`, `init.lua`).

## Success Criteria
- The repository contains only macOS-relevant Neovim configuration files.
- `make init` successfully sets up the environment on macOS.
- No references to "offline mode" or "Ubuntu" remain in the codebase.
- The total repository size is significantly reduced (removal of large `vimrc` files).
