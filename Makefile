OS := $(shell uname -s)
PWD := $(shell pwd)

# ─── Primary targets (OS auto-detect) ────────────────────────────────────────

.PHONY: init
init: ## 初始化 Neovim 配置（自動偵測 macOS / Linux）
ifeq ($(OS),Darwin)
	$(MAKE) _init-macos
else
	$(MAKE) _init-linux
endif

.PHONY: clean
clean: ## 移除 Neovim 配置（自動偵測 macOS / Linux）
ifeq ($(OS),Darwin)
	$(MAKE) _clean-macos
else
	$(MAKE) _clean-linux
endif

.PHONY: update
update: ## 更新 plugins 與 LSP servers
	nvim --headless "+Lazy! sync" +qa
	nvim --headless "+MasonUpdate" +qa

# ─── macOS ───────────────────────────────────────────────────────────────────

.PHONY: _init-macos
_init-macos:
	brew install neovim universal-ctags cmake ripgrep fd fzf
	rm -rf $(HOME)/.config/nvim
	ln -nsiF $(PWD)/nvim $(HOME)/.config/nvim
	$(MAKE) providers
	@echo "Installing plugins..."
	nvim --headless "+Lazy! sync" +qa
	@echo "Done! Run 'nvim' to start."

.PHONY: _clean-macos
_clean-macos:
	rm -rf $(HOME)/.config/nvim
	rm -rf $(HOME)/.local/share/nvim
	@echo "macOS Neovim config removed."

# ─── Linux (Ubuntu) ──────────────────────────────────────────────────────────

.PHONY: _init-linux
_init-linux:
	@echo "Ubuntu: use ubuntu/offline/scripts/install-offline.sh"
	@echo "Or for online install:"
	cd ubuntu/offline/scripts && ./install-offline.sh --user-only

.PHONY: _clean-linux
_clean-linux:
	rm -rf $(HOME)/.config/nvim
	rm -rf $(HOME)/.local/share/nvim
	rm -rf $(HOME)/.local/bin/nvim
	@echo "Linux Neovim config removed."

# ─── Providers (macOS) ───────────────────────────────────────────────────────

.PHONY: providers
providers: ## 安裝 Neovim providers (python / node / ruby)
	$(MAKE) python
	$(MAKE) nodejs
	$(MAKE) ruby

.PHONY: python
python: ## Python provider: pip install pynvim
	ifeq ($(OS),Darwin)
		brew install python pipx
	endif
	python3 -m pip install --user --upgrade --break-system-packages pynvim

.PHONY: nodejs
nodejs: ## Node provider: npm install -g neovim
	npm install -g neovim

.PHONY: ruby
ruby: ## Ruby provider: gem install neovim solargraph
	gem install neovim solargraph

# ─── Help ─────────────────────────────────────────────────────────────────────

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
