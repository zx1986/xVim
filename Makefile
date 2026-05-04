PWD := $(shell pwd)

.PHONY: help
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: init
init: ## Initialize Neovim configuration for macOS
	@echo "Installing macOS dependencies..."
	brew install neovim universal-ctags cmake ripgrep fd fzf
	@echo "Setting up configuration symlink..."
	rm -rf $(HOME)/.config/nvim
	ln -nsiF $(PWD)/nvim $(HOME)/.config/nvim
	@echo "Installing Python provider..."
	python3 -m pip install --user --upgrade --break-system-packages pynvim
	@echo "Installing Node provider..."
	npm install -g neovim
	@echo "Installing plugins..."
	nvim --headless "+Lazy! sync" +qa
	@echo "Done! Run 'nvim' to start."

.PHONY: update
update: ## Update plugins and LSP servers
	nvim --headless "+Lazy! sync" +qa
	nvim --headless "+MasonUpdate" +qa

.PHONY: clean
clean: ## Remove Neovim configuration and data
	rm -rf $(HOME)/.config/nvim
	rm -rf $(HOME)/.local/share/nvim
	rm -rf $(HOME)/.cache/nvim
	@echo "Neovim configuration and data removed."

.DEFAULT_GOAL := help
