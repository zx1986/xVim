# Quick Start Guide

## For Online System (Download Packages)

```bash
cd xVim/ubuntu/offline/scripts
./download.sh

# Create archive
cd ../..
tar -czf nvim-offline-ubuntu.tar.gz offline/ config/
```

## For Offline Ubuntu 22.04 System

```bash
# Extract
tar -xzf nvim-offline-ubuntu.tar.gz
cd ubuntu/offline/scripts

# Install
sudo ./install-offline.sh
# OR user-only: ./install-offline.sh --user-only

# Verify
./verify.sh
nvim --headless '+checkhealth' +qa
```

## Docker Testing

```bash
cd ubuntu/docker
./test-install.sh
```

## Features

- ✅ Complete offline installation
- ✅ Native Neovim LSP (no CoC.nvim, no Node.js)
- ✅ LazyVim plugin manager
- ✅ 70+ development plugins
- ✅ Multi-language: Go, Python, Ruby, TypeScript, PHP, etc.
- ✅ Docker test environment

See [README.md](README.md) for detailed documentation.
