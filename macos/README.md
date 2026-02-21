# macOS Neovim 配置

基於 `ubuntu/` 的 lazy.nvim 配置，針對 macOS 環境調整。

## 快速安裝

```bash
make macos-init
```

這會：
1. 透過 brew 安裝 neovim、ctags、ripgrep、fzf
2. 將 `macos/config/` 軟連結到 `~/.config/nvim`
3. 安裝 Python/Node/Ruby providers
4. 自動安裝全部 plugins（lazy.nvim）

## 手動步驟

```bash
# 1. 安裝相依工具
brew install neovim universal-ctags cmake ripgrep fd fzf

# 2. 連結配置
rm -rf ~/.config/nvim
ln -nsiF $(pwd)/macos/config ~/.config/nvim

# 3. 安裝 providers
make python    # pynvim
make nodejs    # neovim npm package
make ruby      # neovim + solargraph gems

# 4. 啟動 neovim（自動安裝 plugins 與 LSP servers）
nvim
```

## 與 ubuntu/ 配置的差異

| 項目 | ubuntu | macOS |
|------|--------|-------|
| Clipboard | 停用 | `unnamed`（系統 pbcopy） |
| Providers | 全部停用 | Python3/Node/Ruby 啟用 |
| Plugin checker | 停用 | 啟用（自動檢查更新）|
| Mason auto-install | 停用 | 啟用（自動下載 LSP）|
| Treesitter auto-install | 停用 | 啟用（自動安裝 parser）|
| 安裝方式 | 離線包 | 線上（brew/npm/gem/mason）|

## 更新

```bash
make macos-update   # 更新 plugins 與 LSP servers
```

## 指令

```
make help           # 查看所有指令
make macos-init     # 全新安裝
make macos-update   # 更新
make macos-providers # 只重裝 providers
```

## LSP Servers

Mason 在首次開啟 neovim 時自動安裝：

| Server | 語言 |
|--------|------|
| lua_ls | Lua |
| pyright | Python |
| gopls | Go |
| ts_ls | TypeScript/JavaScript |
| html/cssls/jsonls | Web |
| intelephense | PHP |
| solargraph | Ruby |
| yamlls | YAML / Kubernetes |
| terraformls | Terraform / HCL |
