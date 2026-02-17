#!/bin/bash
# Download all required packages for offline installation
# Run this script with internet connection to prepare offline packages

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OFFLINE_DIR="$(dirname "$SCRIPT_DIR")"
PACKAGES_DIR="$OFFLINE_DIR/packages"
MANIFESTS_DIR="$OFFLINE_DIR/manifests"

echo "========================================="
echo "Downloading packages for offline install"
echo "========================================="
echo ""

# Create directories
mkdir -p "$PACKAGES_DIR"/{neovim,plugins,debs,lsp}
mkdir -p "$MANIFESTS_DIR"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 1. Download Neovim AppImage
echo -e "${BLUE}[1/5] Downloading Neovim AppImage...${NC}"
NVIM_VERSION="v0.9.5"
NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim.appimage"
curl -L "$NVIM_URL" -o "$PACKAGES_DIR/neovim/nvim.appimage"
chmod +x "$PACKAGES_DIR/neovim/nvim.appimage"
echo -e "${GREEN}✓ Neovim AppImage downloaded${NC}"
echo ""

# 2. Download system dependencies (.deb files)
echo -e "${BLUE}[2/5] Downloading system dependencies...${NC}"
cd "$PACKAGES_DIR/debs"

# Create a temporary apt cache directory
TEMP_APT_CACHE=$(mktemp -d)
trap "rm -rf $TEMP_APT_CACHE" EXIT

apt-get download \
    universal-ctags \
    ripgrep \
    fd-find \
    git \
    curl \
    wget \
    2>/dev/null || echo "Note: Some packages may already be in cache"

echo -e "${GREEN}✓ System dependencies downloaded${NC}"
echo ""

# 3. Download LSP servers
echo -e "${BLUE}[3/5] Downloading LSP servers...${NC}"
LSP_DIR="$PACKAGES_DIR/lsp"

# lua-language-server
echo "  - Downloading lua-language-server..."
LUA_LS_VERSION="3.7.4"
curl -L "https://github.com/LuaLS/lua-language-server/releases/download/${LUA_LS_VERSION}/lua-language-server-${LUA_LS_VERSION}-linux-x64.tar.gz" \
    -o "$LSP_DIR/lua-language-server.tar.gz"

# gopls
echo "  - Downloading gopls..."
GOPLS_VERSION="v0.14.2"
curl -L "https://github.com/golang/tools/releases/download/gopls%2F${GOPLS_VERSION}/gopls-linux-amd64.tar.gz" \
    -o "$LSP_DIR/gopls.tar.gz"

# pyright (need npm for this, will bundle node modules)
echo "  - Downloading pyright..."
mkdir -p "$LSP_DIR/pyright"
cd "$LSP_DIR/pyright"
npm pack pyright
cd -

# typescript-language-server
echo "  - Downloading typescript-language-server..."
mkdir -p "$LSP_DIR/typescript"
cd "$LSP_DIR/typescript"
npm pack typescript-language-server typescript
cd -

# vscode-langservers-extracted
echo "  - Downloading vscode-langservers-extracted..."
mkdir -p "$LSP_DIR/vscode-langservers"
cd "$LSP_DIR/vscode-langservers"
npm pack vscode-langservers-extracted
cd -

# intelephense (PHP)
echo "  - Downloading intelephense..."
mkdir -p "$LSP_DIR/intelephense"
cd "$LSP_DIR/intelephense"
npm pack intelephense
cd -

# Note: solargraph is a gem, would need Ruby
echo "  - solargraph (Ruby) needs to be installed via gem on target system"

echo -e "${GREEN}✓ LSP servers downloaded${NC}"
echo ""

# 4. Clone all required plugins
echo -e "${BLUE}[4/5] Cloning Vim plugins...${NC}"
PLUGINS_DIR="$PACKAGES_DIR/plugins"

# Read plugin list from manifest or define here
declare -a PLUGINS=(
    "folke/lazy.nvim"
    "neovim/nvim-lspconfig"
    "hrsh7th/nvim-cmp"
    "hrsh7th/cmp-nvim-lsp"
    "hrsh7th/cmp-buffer"
    "hrsh7th/cmp-path"
    "hrsh7th/cmp-cmdline"
    "L3MON4D3/LuaSnip"
    "saadparwaiz1/cmp_luasnip"
    "rafamadriz/friendly-snippets"
    "williamboman/mason.nvim"
    "williamboman/mason-lspconfig.nvim"
    "nvim-treesitter/nvim-treesitter"
    "scrooloose/nerdtree"
    "jistr/vim-nerdtree-tabs"
    "tpope/vim-fugitive"
    "tpope/vim-rhubarb"
    "airblade/vim-gitgutter"
    "tpope/vim-commentary"
    "scrooloose/nerdcommenter"
    "tpope/vim-surround"
    "Raimondi/delimitMate"
    "junegunn/fzf"
    "junegunn/fzf.vim"
    "ibhagwan/fzf-lua"
    "vim-scripts/grep.vim"
    "xolox/vim-misc"
    "xolox/vim-session"
    "majutsushi/tagbar"
    "junegunn/vim-easy-align"
    "easymotion/vim-easymotion"
    "terryma/vim-multiple-cursors"
    "godlygeek/tabular"
    "editorconfig/editorconfig-vim"
    "AndrewRadev/splitjoin.vim"
    "wakatime/vim-wakatime"
    "morhetz/gruvbox"
    "arcticicestudio/nord-vim"
    "altercation/vim-colors-solarized"
    "vim-airline/vim-airline"
    "vim-airline/vim-airline-themes"
    "Yggdroot/indentLine"
    "ryanoasis/vim-devicons"
    "gko/vim-coloresque"
    "vim-scripts/CSApprox"
    "fatih/vim-go"
    "davidhalter/jedi-vim"
    "raimon49/requirements.txt.vim"
    "tpope/vim-rails"
    "tpope/vim-rake"
    "tpope/vim-projectionist"
    "thoughtbot/vim-rspec"
    "ecomba/vim-ruby-refactoring"
    "ruby-formatter/rufo-vim"
    "leafgarland/typescript-vim"
    "HerringtonDarkholme/yats.vim"
    "jelera/vim-javascript-syntax"
    "phpactor/phpactor"
    "stephpy/vim-php-cs-fixer"
    "hail2u/vim-css3-syntax"
    "tpope/vim-haml"
    "mattn/emmet-vim"
    "posva/vim-vue"
    "leafOfTree/vim-vue-plugin"
    "pearofducks/ansible-vim"
    "hashivim/vim-terraform"
    "hashivim/vim-packer"
    "andrewstuart/vim-kubernetes"
    "tmux-plugins/vim-tmux"
    "vim-scripts/django.vim"
    "tweekmonster/django-plus.vim"
    "KurtPreston/vim-autoformat-rails"
    "vim-scripts/matchit.zip"
    "dbeniamine/cheat.sh-vim"
)

for plugin in "${PLUGINS[@]}"; do
    plugin_name=$(echo "$plugin" | sed 's/.*\///')
    echo "  - Cloning $plugin..."
    
    if [ ! -d "$PLUGINS_DIR/$plugin_name" ]; then
        git clone --depth 1 "https://github.com/$plugin.git" "$PLUGINS_DIR/$plugin_name" 2>/dev/null || echo "    Warning: Failed to clone $plugin"
    else
        echo "    Already exists, skipping..."
    fi
done

echo -e "${GREEN}✓ Plugins cloned${NC}"
echo ""

# 5. Generate manifests and checksums
echo -e "${BLUE}[5/5] Generating manifests and checksums...${NC}"

# Create plugin list
ls -1 "$PLUGINS_DIR" > "$MANIFESTS_DIR/plugins.txt"

# Create checksums
cd "$PACKAGES_DIR"
find . -type f -exec sha256sum {} \; > "$MANIFESTS_DIR/checksums.sha256"

# Create manifest with versions
cat > "$MANIFESTS_DIR/manifest.json" <<EOF
{
  "generated_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "neovim_version": "$NVIM_VERSION",
  "lua_ls_version": "$LUA_LS_VERSION",
  "gopls_version": "$GOPLS_VERSION",
  "total_plugins": $(ls -1 "$PLUGINS_DIR" | wc -l)
}
EOF

echo -e "${GREEN}✓ Manifests generated${NC}"
echo ""

echo "========================================="
echo -e "${GREEN}✅ Download completed successfully!${NC}"
echo "========================================="
echo ""
echo "Offline packages location: $OFFLINE_DIR"
echo "Total size: $(du -sh "$OFFLINE_DIR" | cut -f1)"
echo ""
echo "To create a distributable archive:"
echo "  cd $(dirname "$OFFLINE_DIR")"
echo "  tar -czf nvim-offline-ubuntu.tar.gz offline/"
