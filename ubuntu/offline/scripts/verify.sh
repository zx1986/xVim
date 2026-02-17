#!/bin/bash
# Verification script to ensure Neovim and all components are properly installed

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

echo "========================================="
echo "Neovim Installation Verification"
echo "========================================="
echo ""

# Helper function to check command
check_command() {
    local cmd=$1
    local name=$2
    
    if command -v "$cmd" &> /dev/null; then
        local version=$($cmd --version 2>&1 | head -n1)
        echo -e "${GREEN}✓${NC} $name: $version"
        return 0
    else
        echo -e "${RED}✗${NC} $name: Not found"
        ((ERRORS++))
        return 1
    fi
}

# Helper function to check file
check_file() {
    local file=$1
    local name=$2
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $name: Found"
        return 0
    else
        echo -e "${RED}✗${NC} $name: Not found"
        ((ERRORS++))
        return 1
    fi
}

# Helper function to check directory
check_dir() {
    local dir=$1
    local name=$2
    local  count_expected=$3
    
    if [ -d "$dir" ]; then
        local count=$(find "$dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
        if [ -n "$count_expected" ] && [ "$count" -lt "$count_expected" ]; then
            echo -e "${YELLOW}⚠${NC} $name: Found ($count items, expected at least $count_expected)"
            ((WARNINGS++))
        else
            echo -e "${GREEN}✓${NC} $name: Found ($count items)"
        fi
        return 0
    else
        echo -e "${RED}✗${NC} $name: Not found"
        ((ERRORS++))
        return 1
    fi
}

# 1. Check Neovim binary
echo -e "${BLUE}[1/6] Checking Neovim installation...${NC}"
if check_command "nvim" "Neovim"; then
    # Check version
    nvim_version=$(nvim --version | head -n1 | grep -oP 'v\d+\.\d+\.\d+')
    min_version="v0.9.0"
    if [ "$(printf '%s\n' "$min_version" "$nvim_version" | sort -V | head -n1)" = "$min_version" ]; then
        echo -e "${GREEN}✓${NC} Neovim version $nvim_version >= $min_version"
    else
        echo -e "${YELLOW}⚠${NC} Neovim version $nvim_version < $min_version (may have compatibility issues)"
        ((WARNINGS++))
    fi
fi
echo ""

# 2. Check Neovim configuration
echo -e "${BLUE}[2/6] Checking Neovim configuration...${NC}"
check_file "$HOME/.config/nvim/init.lua" "init.lua"
check_dir "$HOME/.config/nvim/lua/config" "Config modules" 3
check_dir "$HOME/.config/nvim/lua/plugins" "Plugin configs" 4
echo ""

# 3. Check plugins
echo -e "${BLUE}[3/6] Checking plugins installation...${NC}"
check_dir "$HOME/.local/share/nvim/lazy" "Lazy plugins directory" 30
check_file "$HOME/.local/share/nvim/lazy/lazy.nvim/lua/lazy.lua" "Lazy.nvim"
check_file "$HOME/.local/share/nvim/lazy/nvim-lspconfig/lua/lspconfig.lua" "LSP config"
check_file "$HOME/.local/share/nvim/lazy/nvim-cmp/lua/cmp/init.lua" "nvim-cmp"
check_file "$HOME/.local/share/nvim/lazy/nvim-treesitter/lua/nvim-treesitter.lua" "Treesitter"
echo ""

# 4. Check LSP servers
echo -e "${BLUE}[4/6] Checking LSP servers...${NC}"
check_dir "$HOME/.local/share/nvim/lsp" "LSP servers directory"

# Optional LSP binaries check
for lsp in lua-language-server gopls pyright; do
    if command -v "$lsp" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $lsp: Available in PATH"
    else
        echo -e "${YELLOW}⚠${NC} $lsp: Not in PATH (may still work if in LSP directory)"
        ((WARNINGS++))
    fi
done
echo ""

# 5. Check Treesitter parsers
echo -e "${BLUE}[5/6] Checking Treesitter parsers...${NC}"
PARSER_DIR="$HOME/.local/share/nvim/lazy/nvim-treesitter/parser"
if [ -d "$PARSER_DIR" ]; then
    parser_count=$(find "$PARSER_DIR" -name "*.so" 2>/dev/null | wc -l)
    if [ "$parser_count" -gt 0 ]; then
        echo -e "${GREEN}✓${NC} Treesitter parsers: $parser_count parsers installed"
    else
        echo -e "${YELLOW}⚠${NC} Treesitter parsers: None found (will be compiled on first use)"
        ((WARNINGS++))
    fi
else
    echo -e "${YELLOW}⚠${NC} Treesitter parser directory not found"
    ((WARNINGS++))
fi
echo ""

# 6. Functional tests
echo -e "${BLUE}[6/6] Running functional tests...${NC}"

# Test if Neovim can load
if nvim --headless +"lua print('Neovim can execute Lua')" +qa 2>&1 | grep -q "Neovim can execute Lua"; then
    echo -e "${GREEN}✓${NC} Neovim Lua execution: OK"
else
    echo -e "${RED}✗${NC} Neovim Lua execution: Failed"
    ((ERRORS++))
fi

# Test if plugins can load
if nvim --headless +"lua require('lazy')" +qa 2>&1; then
    echo -e "${GREEN}✓${NC} Lazy.nvim loading: OK"
else
    echo -e "${RED}✗${NC} Lazy.nvim loading: Failed"
    ((ERRORS++))
fi

# Test LSP config
if nvim --headless +"lua require('lspconfig')" +qa 2>&1; then
    echo -e "${GREEN}✓${NC} LSP config loading: OK"
else
    echo -e "${RED}✗${NC} LSP config loading: Failed"
    ((ERRORS++))
fi

# Test completion
if nvim --headless +"lua require('cmp')" +qa 2>&1; then
    echo -e "${GREEN}✓${NC} nvim-cmp loading: OK"
else
    echo -e "${RED}✗${NC} nvim-cmp loading: Failed"
    ((ERRORS++))
fi

echo ""
echo "========================================="
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✅ All checks passed!${NC}"
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠ Verification completed with $WARNINGS warning(s)${NC}"
else
    echo -e "${RED}✗ Verification failed with $ERRORS error(s) and $WARNINGS warning(s)${NC}"
fi
echo "========================================="
echo ""

if [ $ERRORS -eq 0 ]; then
    echo "Installation verified successfully!"
    echo ""
    echo "Recommended next steps:"
    echo "  1. Run: nvim --headless '+checkhealth' +qa  (detailed health check)"
    echo "  2. Start Neovim and check :Lazy status"
    echo "  3. Test LSP in a source file"
    exit 0
else
    echo "Installation has errors. Please check the output above."
    echo ""
    echo "Common fixes:"
    echo "  - Ensure ~/.local/bin is in PATH"
    echo "  - Re-run install-offline.sh"
    echo "  - Check Neovim :checkhealth output"
    exit 1
fi
