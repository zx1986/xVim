# Neovim Offline Installation for Ubuntu 22.04

Complete offline Neovim setup with LazyVim and native LSP support, designed for systems without internet access.

## Overview

This configuration provides:

- **Neovim 0.9.5+** with LazyVim plugin manager
- **Native LSP** support (no CoC.nvim, no Node.js required for LSP)
- **70+ plugins** for development
- **Multi-language support**: Go, Python, Ruby, TypeScript, PHP, HTML, CSS, and more
- **Complete offline installation** from pre-downloaded packages

## Directory Structure

```
ubuntu/
├── config/                    # Neovim configuration
│   ├── init.lua              # Main entry point
│   └── lua/
│       ├── config/           # Settings, keymaps, autocmds
│       └── plugins/          # Plugin configurations
├── offline/                   # Offline installation assets
│   ├── packages/             # Downloaded packages (after running download.sh)
│   ├── scripts/              # Installation scripts
│   │   ├── download.sh       # Download packages (needs internet)
│   │   ├── install-offline.sh # Offline installer
│   │   └── verify.sh         # Verification script
│   └── manifests/            # Package lists and checksums
└── docker/                    # Testing environment
    ├── Dockerfile
    ├── docker-compose.yml
    └── test-install.sh
```

## Prerequisites

### On Machine with Internet (One-time Download)

1. Ubuntu 22.04 or macOS with Docker
2. Git, curl, npm installed
3. At least 2GB free disk space

### On Target Offline System

- Ubuntu 22.04
- At least 1GB free disk space

## Installation Guide

### Step 1: Download Packages (Online Machine)

```bash
# Clone this repository
cd xVim/ubuntu/offline/scripts

# Run download script (requires internet)
./download.sh

# This will download:
# - Neovim tarball (nvim-linux64.tar.gz)
# - System dependencies (.deb files)
# - LSP servers (lua-ls, gopls, pyright, etc.)
# - All Vim plugins (70+ repositories)
```

Download time: ~10-30 minutes depending on connection
Total size: ~500MB-1GB

### Step 2: Create Offline Archive

```bash
cd xVim/ubuntu
tar -czf nvim-offline-ubuntu.tar.gz offline/ config/
```

### Step 3: Transfer to Offline System

Transfer `nvim-offline-ubuntu.tar.gz` to your offline Ubuntu system using:
- USB drive
- Network file copy
- Any other method available

### Step 4: Install Offline (Target System)

```bash
# Extract
tar -xzf nvim-offline-ubuntu.tar.gz
cd ubuntu/offline/scripts

# Run installer (requires sudo for system packages)
sudo ./install-offline.sh

# Or user-only installation (no sudo, ~/.local/bin)
./install-offline.sh --user-only
```

**Note**: If using `--user-only`, ensure `~/.local/bin` is in your PATH:
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Step 5: Verify Installation

```bash
./verify.sh
nvim --headless '+checkhealth' +qa
```

## Configuration Details

### LSP Servers Included

- **Lua**: lua-language-server
- **Go**: gopls
- **Python**: pyright
- **JavaScript/TypeScript**: typescript-language-server
- **HTML/CSS/JSON**: vscode-langservers-extracted
- **PHP**: intelephense
- **Ruby**: solargraph (requires Ruby runtime)

### Key Mappings

| Key | Action |
|-----|--------|
| `,` | Leader key |
| `jj` | Escape (in insert mode) |
| `<F2>` | NERDTree Find |
| `<F3>` | NERDTree Toggle |
| `<F4>` | Tagbar Toggle |
| `<C-p>` | FZF Files |
| `gd` | Go to definition (LSP) |
| `gr` | Show references (LSP) |
| `K` | Hover documentation (LSP) |
| `<leader>rn` | Rename symbol (LSP) |
| `<leader>ca` | Code action (LSP) |
| `[g`, `]g` | Previous/Next diagnostic |

See [lua/config/keymaps.lua](config/lua/config/keymaps.lua) for complete list.

### Plugins Included

**Core**:
- lazy.nvim (plugin manager)
- NERDTree (file explorer)
- vim-fugitive (Git integration)
- fzf.vim (fuzzy finder)
- vim-airline (status line)

**LSP & Completion**:
- nvim-lspconfig
- nvim-cmp (completion)
- nvim-treesitter (syntax highlighting)
- mason.nvim (LSP manager)

**Language Support**:
- vim-go, jedi-vim, vim-rails, phpactor, and many more

See [offline/manifests/plugins.txt](offline/manifests/plugins.txt) for complete list.

## Docker Testing

Test the offline installation in a clean Ubuntu 22.04 container:

```bash
cd ubuntu/docker

# Build and test
./test-install.sh

# Or manually
docker-compose up -d
docker-compose exec nvim-test bash
```

The Docker environment simulates an offline system and validates the installation process.

## Troubleshooting

### Neovim not found after installation

```bash
# Check if nvim exists
which nvim

# Add to PATH if using --user-only
export PATH="$HOME/.local/bin:$PATH"
```

### LSP not working

```bash
# Check LSP servers
ls -la ~/.local/share/nvim/lsp/

# Check health
nvim --headless '+checkhealth lsp' +qa

# Check inside Neovim
:checkhealth
:LspInfo
```

### Plugins not loading

```bash
# Open Lazy UI to check plugin status
nvim +Lazy

# Force sync
nvim --headless '+Lazy! sync' +qa
```

### Missing Treesitter parsers

Treesitter parsers are compiled on first use. When you open a file, Neovim will compile the parser if missing.

```bash
# Manually install parsers
nvim --headless '+TSInstall lua python go javascript' +qa
```

## Customization

### Add More Plugins

1. Edit `config/lua/plugins/*.lua` files
2. Add plugin to `offline/manifests/plugins.txt`
3. Re-run `download.sh` to download new plugins

### Change Colorscheme

Edit `config/lua/plugins/ui.lua`:

```lua
-- Change from gruvbox to nord
vim.cmd([[colorscheme nord]])
```

Available: gruvbox, nord, solarized

### Configure LSP Servers

Edit `config/lua/plugins/lsp.lua` to customize LSP server settings.

## Differences from macOS Configuration

| Feature | macOS (old) | Ubuntu (new) |
|---------|-------------|--------------|
| Plugin Manager | vim-plug | LazyVim |
| Completion | CoC.nvim | nvim-cmp + native LSP |
| Node.js Required | Yes (for CoC) | No |
| Offline Support | No | Yes |
| Configuration Format | VimScript | Lua |

## Performance

- Startup time: ~100-200ms (with lazy loading)
- Memory usage: ~50-80MB (idle)
- Plugin count: 70+

## License

Same as the main xVim repository.

## Support

For issues specific to Ubuntu offline installation, please check:
1. `:checkhealth` output
2. `verify.sh` results
3. Existing documentation

## References

- [Neovim](https://github.com/neovim/neovim)
- [LazyVim](https://github.com/LazyVim/LazyVim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
