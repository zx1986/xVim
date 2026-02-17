#!/bin/bash
# Offline installation script for Neovim and all dependencies
# This script installs everything from pre-downloaded packages

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OFFLINE_DIR="$(dirname "$SCRIPT_DIR")"
PACKAGES_DIR="$OFFLINE_DIR/packages"
MANIFESTS_DIR="$OFFLINE_DIR/manifests"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "========================================="
echo "Neovim Offline Installation"
echo "========================================="
echo ""

# Check if running as root for system package installation
if [ "$EUID" -ne 0 ] && [ "$1" != "--user-only" ]; then
    echo -e "${RED}Error: This script needs sudo privileges for system package installation${NC}"
    echo "Run with: sudo $0"
    echo "Or run with --user-only flag to skip system packages"
    exit 1
fi

# 1. Verify package integrity
echo -e "${BLUE}[1/7] Verifying package integrity...${NC}"
cd "$PACKAGES_DIR"
if [ -f "$MANIFESTS_DIR/checksums.sha256" ]; then
    if sha256sum -c "$MANIFESTS_DIR/checksums.sha256" --quiet; then
        echo -e "${GREEN}✓ All packages verified${NC}"
    else
        echo -e "${YELLOW}⚠ Warning: Some checksums don't match. Continuing anyway...${NC}"
    fi
else
    echo -e "${YELLOW}⚠ No checksums file found. Skipping verification.${NC}"
fi
echo ""

# 2. Install system dependencies
if [ "$1" != "--user-only" ]; then
    echo -e "${BLUE}[2/7] Installing system dependencies...${NC}"
    cd "$PACKAGES_DIR/debs"
    
    if ls *.deb 1> /dev/null 2>&1; then
        dpkg -i *.deb || apt-get install -f -y
        echo -e "${GREEN}✓ System dependencies installed${NC}"
    else
        echo -e "${YELLOW}⚠ No .deb files found. Skipping system dependencies.${NC}"
    fi
    echo ""
else
    echo -e "${YELLOW}[2/7] Skipping system dependencies (--user-only mode)${NC}"
    echo ""
fi

# 3. Install Neovim AppImage
echo -e "${BLUE}[3/7] Installing Neovim...${NC}"
NVIM_APPIMAGE="$PACKAGES_DIR/neovim/nvim.appimage"

if [ -f "$NVIM_APPIMAGE" ]; then
    if [ "$1" != "--user-only" ]; then
        # System-wide installation
        cp "$NVIM_APPIMAGE" /usr/local/bin/nvim
        chmod +x /usr/local/bin/nvim
        echo -e "${GREEN}✓ Neovim installed to /usr/local/bin/nvim${NC}"
    else
        # User installation
        mkdir -p "$HOME/.local/bin"
        cp "$NVIM_APPIMAGE" "$HOME/.local/bin/nvim"
        chmod +x "$HOME/.local/bin/nvim"
        echo -e "${GREEN}✓ Neovim installed to ~/.local/bin/nvim${NC}"
        echo -e "${YELLOW}  Make sure ~/.local/bin is in your PATH${NC}"
    fi
else
    echo -e "${RED}✗ Neovim AppImage not found!${NC}"
    exit 1
fi
echo ""

# 4. Install LSP servers
echo -e "${BLUE}[4/7] Installing LSP servers...${NC}"
LSP_DIR="$PACKAGES_DIR/lsp"
INSTALL_LSP_DIR="$HOME/.local/share/nvim/lsp"
mkdir -p "$INSTALL_LSP_DIR"

# lua-language-server
if [ -f "$LSP_DIR/lua-language-server.tar.gz" ]; then
    echo "  - Installing lua-language-server..."
    mkdir -p "$INSTALL_LSP_DIR/lua-language-server"
    tar -xzf "$LSP_DIR/lua-language-server.tar.gz" -C "$INSTALL_LSP_DIR/lua-language-server"
    ln -sf "$INSTALL_LSP_DIR/lua-language-server/bin/lua-language-server" "$HOME/.local/bin/lua-language-server" 2>/dev/null || true
fi

# gopls
if [ -f "$LSP_DIR/gopls.tar.gz" ]; then
    echo "  - Installing gopls..."
    mkdir -p "$INSTALL_LSP_DIR/gopls"
    tar -xzf "$LSP_DIR/gopls.tar.gz" -C "$INSTALL_LSP_DIR/gopls"
    ln -sf "$INSTALL_LSP_DIR/gopls/gopls" "$HOME/.local/bin/gopls" 2>/dev/null || true
fi

# npm-based LSP servers (pyright, typescript, etc.)
for lsp_pack in pyright typescript vscode-langservers intelephense; do
    if [ -d "$LSP_DIR/$lsp_pack" ]; then
        echo "  - Installing $lsp_pack..."
        cp -r "$LSP_DIR/$lsp_pack" "$INSTALL_LSP_DIR/"
        # Install npm packages if npm is available
        if command -v npm &> /dev/null; then
            cd "$INSTALL_LSP_DIR/$lsp_pack"
            npm install *.tgz 2>/dev/null || echo "    Note: npm install failed, may need manual setup"
            cd -
        fi
    fi
done

echo -e "${GREEN}✓ LSP servers installed${NC}"
echo ""

# 5. Copy plugin repositories
echo -e "${BLUE}[5/7] Installing Vim plugins...${NC}"
PLUGINS_SRC="$PACKAGES_DIR/plugins"
PLUGINS_DEST="$HOME/.local/share/nvim/lazy"
mkdir -p "$PLUGINS_DEST"

if [ -d "$PLUGINS_SRC" ]; then
    cp -r "$PLUGINS_SRC"/* "$PLUGINS_DEST/" 2>/dev/null || true
    echo -e "${GREEN}✓ $(ls -1 "$PLUGINS_SRC" | wc -l) plugins installed${NC}"
else
    echo -e "${YELLOW}⚠ No plugins directory found${NC}"
fi
echo ""

# 6. Copy Neovim configuration
echo -e "${BLUE}[6/7] Installing Neovim configuration...${NC}"
CONFIG_SRC="$(dirname "$(dirname "$OFFLINE_DIR")")/config"
CONFIG_DEST="$HOME/.config/nvim"

if [ -d "$CONFIG_SRC" ]; then
    # Backup existing config
    if [ -d "$CONFIG_DEST" ]; then
        BACKUP_DIR="$CONFIG_DEST.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}  Backing up existing config to: $BACKUP_DIR${NC}"
        mv "$CONFIG_DEST" "$BACKUP_DIR"
    fi
    
    # Copy new config
    cp -r "$CONFIG_SRC" "$CONFIG_DEST"
    echo -e "${GREEN}✓ Configuration installed to ~/.config/nvim${NC}"
else
    echo -e "${YELLOW}⚠ Configuration directory not found at: $CONFIG_SRC${NC}"
fi
echo ""

# 7. Setup and sync
echo -e "${BLUE}[7/7] Running initial setup...${NC}"

# Create necessary directories
mkdir -p "$HOME/.local/share/nvim/session"
mkdir -p "$HOME/.local/state/nvim"

# Run Lazy sync (this should work offline since plugins are already in place)
if command -v nvim &> /dev/null; then
    echo "  Running Lazy.nvim sync..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || echo "  Note: Lazy sync completed with warnings"
    echo -e "${GREEN}✓ Initial setup complete${NC}"
else
    echo -e "${RED}✗ nvim command not found. Please check PATH.${NC}"
fi
echo ""

echo "========================================="
echo -e "${GREEN}✅ Installation completed!${NC}"
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. Verify installation: ./verify.sh"
echo "  2. Run health check: nvim --headless '+checkhealth' +qa"
echo "  3. Start Neovim: nvim"
echo ""
echo "If you encounter any issues:"
echo "  - Check :checkhealth in Neovim"
echo "  - Check :Lazy status for plugin issues"
echo "  - Ensure ~/.local/bin is in your PATH"
