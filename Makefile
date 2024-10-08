.PHONY: init
init: ## 初始化安裝配置 neovim
	brew install universal-ctags cmake neovim
	mkdir -p $(HOME)/.config/nvim
	ln -nsiF $(PWD)/vimrc.bootstrap $(HOME)/.config/nvim/init.vim
	ln -nsiF $(PWD)/vimrc.local $(HOME)/.config/nvim/local_init.vim
	ln -nsiF $(PWD)/vimrc.local.bundles $(HOME)/.config/nvim/local_bundles.vim
	$(MAKE) plugin
	nvim -c checkhealth

.PHONY: ruby
ruby: ## 配置搭配的 Ruby 環境
	which ruby
	gem install neovim solargraph

.PHONY: nodejs
nodejs: ## 配置搭配的 NodeJS 環境
	which node
	npm install -g neovim

.PHONY: python
python: ## 配置搭配的 python 環境
	brew install python pipx
	python3 -m pip install --user --upgrade --break-system-packages pynvim jedi
	pipx install flake8

.PHONY: plugin
plugin: ## 安裝 vim 外掛
	nvim -c 'PlugInstall'
	nvim -c 'PlugClean'
	nvim -c 'CocInstall coc-tabnine coc-tsserver'
	nvim -c 'CocInstall \
             coc-css \
             coc-emmet \
             coc-git \
             coc-gocode \
             coc-highlight \
             coc-html \
             coc-jedi \
             coc-json \
             coc-lists \
             coc-pairs \
             coc-phpls \
             coc-snippets \
             coc-solargraph \
             coc-ultisnips \
             coc-vetur \
             coc-yaml \
             coc-yank'
	cp -iv snippets/* $(HOME)/.config/coc/ultisnips/

.PHONY: delete
delete: ## 移除現有配置
	rm -rf $(HOME)/.vim
	rm -vf $(HOME)/.vimrc
	rm -vf $(HOME)/.vimrc.local
	rm -vf $(HOME)/.vimrc.local.bundles
	rm -rf $(HOME)/.config/nvim

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
