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
