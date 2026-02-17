# Ubuntu Offline Installation - Notes

## Package Sizes (Approximate)

- Neovim AppImage: ~12MB
- System dependencies (.deb): ~5-10MB  
- LSP servers: ~100-200MB total
  - lua-language-server: ~40MB
  - gopls: ~20MB
  - pyright + deps: ~30MB
  - typescript-language-server: ~25MB
  - vscode-langservers: ~15MB
  - intelephense: ~10MB
- Plugins (70+ repos): ~200-300MB
- **Total: ~500MB-700MB**

## Download Script Details

The `download.sh` script:
1. Downloads Neovim v0.9.5 AppImage
2. Downloads .deb packages using `apt-get download`
3. Downloads LSP server binaries and npm packages
4. Clones all plugin repositories (shallow clone, depth=1)
5. Generates checksums and manifest

## Installation Script Details

The `install-offline.sh` script:
1. Verifies package integrity (optional, based on checksums)
2. Installs .deb packages using `dpkg -i`
3. Installs Neovim AppImage to `/usr/local/bin/nvim` (or `~/.local/bin`)
4. Extracts LSP servers to `~/.local/share/nvim/lsp/`
5. Copies plugins to `~/.local/share/nvim/lazy/`
6. Copies configuration to `~/.config/nvim/`
7. Runs Lazy.nvim sync (offline mode)

## Known Limitations

1. **Treesitter parsers**: Not pre-compiled. They compile on first use per language.
   - Requires build tools (gcc, make) on the target system
   - Alternative: Pre-compile on a similar system and copy `.so` files

2. **Ruby LSP (solargraph)**: Requires Ruby runtime installation
   - Not included in offline package
   - Install separately if needed: `gem install solargraph`

3. **FZF binary**: Plugins download Go binary on first use
   - May require manual compilation on offline system
   - Or pre-download and place in PATH

4. **Mason.nvim**: Configured for offline mode
   - Uses pre-installed LSP servers
   - Cannot download new servers without internet

## Customization for Different Systems

If target system differs from download system:

1. **Architecture**: Ensure LSP server binaries match (x64, arm64)
2. **Ubuntu version**: .deb packages should match (22.04, 20.04, etc.)
3. **Glibc version**: Some binaries require specific glibc versions

## Future Improvements

- [ ] Pre-compile Treesitter parsers
- [ ] Bundle Ruby for solargraph
- [ ] Add pre-built FZF binary
- [ ] Support multiple architectures (arm64, x64)
- [ ] Compress offline archive with better compression
- [ ] Add incremental update mechanism
