# Ubuntu Offline Installation - Notes

## Package Sizes (Approximate)

- Neovim v0.11.6 tarball (nvim-linux-x86_64.tar.gz): ~30MB (extracted: ~80MB)
- System dependencies (.deb): ~5-10MB
- LSP servers: ~100-200MB total
  - lua-language-server: ~40MB
  - gopls: ~20MB
  - pyright + deps: ~30MB
  - typescript-language-server: ~25MB
  - vscode-langservers: ~15MB
  - intelephense: ~10MB
- Plugins (68 repos): ~200-300MB
- **Total: ~500MB-700MB**

## Download Script Details

The `download.sh` script:
1. Downloads Neovim v0.11.6 tarball (`nvim-linux-x86_64.tar.gz`)
2. Downloads .deb packages using `apt-get download`
3. Downloads LSP server binaries and npm packages
4. Clones all plugin repositories (shallow clone, depth=1)
5. Generates checksums and manifest

## Installation Script Details

The `install-offline.sh` script supports two modes:

### System-wide installation (`sudo ./install-offline.sh`)
1. Installs .deb packages using `dpkg -i`
2. Extracts Neovim tarball to `/usr/local/`
3. Installs LSP servers to `~/.local/share/nvim/lsp/`
4. Copies plugins to `~/.local/share/nvim/lazy/`
5. Copies configuration to `~/.config/nvim/`
6. Runs Lazy.nvim sync (offline mode)

### User-only installation (`./install-offline.sh --user-only`)
1. Skips system package installation
2. Extracts Neovim tarball to `~/.local/`
3. Steps 3-6 same as above

## LSP Configuration

Uses Neovim 0.11+ native `vim.lsp.config` API (not the deprecated `require('lspconfig')` framework).
Falls back to `lspconfig` for older Neovim versions.

### Configured Servers
| Server | Language | Installation |
|--------|----------|-------------|
| lua_ls | Lua | Binary tarball |
| pyright | Python | npm |
| gopls | Go | go install |
| ts_ls | TypeScript/JS | npm |
| html/cssls/jsonls | Web | npm (vscode-langservers-extracted) |
| intelephense | PHP | npm |
| solargraph | Ruby | gem |

## Disabled Plugins

The following plugins are disabled (`enabled = false`) due to compatibility issues:

- **jedi-vim**: Requires Python3 provider; redundant with pyright LSP
- **requirements.txt.vim**: Triggers `E117: Unknown function: requirements#shebang`

## Known Limitations

1. **Treesitter parsers**: Not pre-compiled. Compile on first use per language.
   - Requires build tools (gcc, make) on the target system
   - Alternative: Pre-compile on a similar system and copy `.so` files

2. **FZF binary**: Plugin downloads Go binary on first use
   - May require manual compilation on offline system
   - Or pre-download and place in PATH

3. **Mason.nvim**: Configured for offline mode
   - Uses pre-installed LSP servers
   - Cannot download new servers without internet

## Docker Verification Environment

The `docker/` directory provides a testing environment:
- **Base**: Ubuntu 22.04
- **Languages**: Python 3, Node.js, Go 1.22, Ruby
- **LSP servers**: Pre-installed via npm/gem/go install
- **Python provider**: `pynvim` installed via pip

## Customization for Different Systems

If target system differs from download system:

1. **Architecture**: Ensure LSP server binaries match (x64, arm64)
2. **Ubuntu version**: .deb packages should match (22.04, 20.04, etc.)
3. **Glibc version**: Some binaries require specific glibc versions

## Future Improvements

- [ ] Pre-compile Treesitter parsers
- [ ] Add pre-built FZF binary
- [ ] Compress offline archive with better compression
- [ ] Add incremental update mechanism
