# Modernize xVim Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Streamline xVim by removing legacy Vim files, Ubuntu support, and simplifying the Makefile and Neovim configuration for a macOS-focused environment.

**Architecture:** Destructive cleanup of redundant directories and files, followed by a rewrite of the orchestration logic in the Makefile and Neovim's init.lua.

**Tech Stack:** Makefile, Lua (Neovim), Shell.

---

### Task 1: Cleanup Legacy Files and Directories

**Files:**
- Delete: `ubuntu/`
- Delete: `macos/`
- Delete: `vimrc.bootstrap`
- Delete: `vimrc.local`
- Delete: `vimrc.local.bundles`

- [ ] **Step 1: Remove Ubuntu and macOS directories**

Run: `rm -rf ubuntu macos`
Expected: Directories are removed.

- [ ] **Step 2: Remove legacy Vim configuration files**

Run: `rm vimrc.bootstrap vimrc.local vimrc.local.bundles`
Expected: Files are removed.

- [ ] **Step 3: Commit the deletion**

Run: `git add . && git commit -m "chore: remove ubuntu, macos, and legacy vimrc files"`
Expected: Clean status.

### Task 2: Simplify Neovim Lua Configuration

**Files:**
- Modify: `nvim/lua/platform.lua`
- Modify: `nvim/init.lua`

- [ ] **Step 1: Refactor `nvim/lua/platform.lua`**

Replace content with:
```lua
-- Platform detection module (Simplified for macOS only)
local M = {}

M.is_macos = vim.fn.has("mac") == 1
-- Note: is_linux and is_offline removed as per modernization plan.

return M
```

- [ ] **Step 2: Simplify `nvim/init.lua`**

Remove the `checker` logic that depended on `platform.is_offline`.
Replace the `checker` section in `require("lazy").setup` with:
```lua
  checker = {
    enabled = true,
    notify  = false,
  },
```

- [ ] **Step 3: Verify Neovim still starts**

Run: `nvim --headless +qa`
Expected: No errors.

- [ ] **Step 4: Commit changes**

Run: `git add nvim/lua/platform.lua nvim/init.lua && git commit -m "feat: simplify lua config by removing offline/linux logic"`

### Task 3: Refactor Makefile for macOS

**Files:**
- Modify: `Makefile`

- [ ] **Step 1: Rewrite Makefile to focus on macOS**

Replace content with:
```makefile
PWD := $(shell pwd)

.PHONY: help
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: init
init: ## Initialize Neovim configuration for macOS
	@echo "Installing macOS dependencies..."
	brew install neovim universal-ctags cmake ripgrep fd fzf
	@echo "Setting up configuration symlink..."
	rm -rf $(HOME)/.config/nvim
	ln -nsiF $(PWD)/nvim $(HOME)/.config/nvim
	@echo "Installing Python provider..."
	python3 -m pip install --user --upgrade --break-system-packages pynvim
	@echo "Installing Node provider..."
	npm install -g neovim
	@echo "Installing plugins..."
	nvim --headless "+Lazy! sync" +qa
	@echo "Done! Run 'nvim' to start."

.PHONY: update
update: ## Update plugins and LSP servers
	nvim --headless "+Lazy! sync" +qa
	nvim --headless "+MasonUpdate" +qa

.PHONY: clean
clean: ## Remove Neovim configuration and data
	rm -rf $(HOME)/.config/nvim
	rm -rf $(HOME)/.local/share/nvim
	rm -rf $(HOME)/.cache/nvim
	@echo "Neovim configuration and data removed."

.DEFAULT_GOAL := help
```

- [ ] **Step 2: Verify Makefile help**

Run: `make help`
Expected: Shows simplified targets (help, init, update, clean).

- [ ] **Step 3: Commit Makefile changes**

Run: `git add Makefile && git commit -m "refactor: simplify Makefile for macOS-only workflow"`

### Task 4: Update Documentation

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Rewrite README.md for the new structure**

Replace content with:
```markdown
# xVim

Modern Neovim configuration for macOS.

## Installation

### Prerequisites

- macOS
- [Homebrew](https://brew.sh/)
- Node.js (for some LSP servers)
- Python 3

### Setup

```bash
make init
```

## Usage

- `make update`: Update all plugins and Mason packages.
- `make clean`: Remove all configuration and Neovim data.

## Structure

- `nvim/`: Core Neovim configuration (Lua).
  - `init.lua`: Entry point.
  - `lua/config/`: Options, keymaps, and autocmds.
  - `lua/plugins/`: Plugin specifications via `lazy.nvim`.

## References

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
```

- [ ] **Step 2: Commit documentation update**

Run: `git add README.md && git commit -m "docs: update README for modernization"`

### Task 5: Final Validation

- [ ] **Step 1: Run full clean and init**

Run: `make clean && make init`
Expected: Complete setup without errors.

- [ ] **Step 2: Verify Neovim health**

Run: `nvim --headless "+checkhealth" +qa`
Expected: Health check passes (minor warnings about providers are acceptable if not installed).
