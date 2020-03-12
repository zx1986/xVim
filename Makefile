.PHONY: init
init: ## 初始化安裝配置 neovim
	brew install ctags neovim
	git submodule init
	git submodule update
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -nsiF $(PWD)/ $(HOME)/.vim
	ln -nsiF $(PWD)/vimrc.local $(HOME)/.vimrc.local
	ln -nsiF $(PWD)/vimrc.local.bundles $(HOME)/.vimrc.local.bundles
	ln -nsiF $(PWD)/vimrc.bootstrap $(HOME)/.vimrc
	ln -nsiF $(PWD)/nvim ~/.config/nvim
	$(MAKE) plugins

.PHONY: ruby
ruby: ## 配置搭配的 Ruby 環境
	`rbenv which gem` install neovim solargraph

.PHONY: node
node: ## 配置搭配的 NodeJS 環境
	npm install -g neovim

.PHONY: python
python: ## 配置搭配的 python 環境
	python3 -m pip uninstall neovim pynvim
	python3 -m pip install --user --upgrade pynvim flake8

.PHONY: plugins
plugins: ## 安裝 vim 外掛
	vim -c 'PlugInstall'
	vim -c 'PlugClean'
	vim -c 'CocInstall \
		coc-imselect \
		coc-solargraph \
		coc-highlight \
		coc-tsserver \
		coc-yank \
		coc-emmet \
		coc-lists \
		coc-pairs \
		coc-snippets \
		coc-ultisnips \
		coc-neosnippet \
		coc-tabnine \
		coc-json \
		coc-html \
		coc-yaml \
		coc-css \
		coc-vetur \
		coc-python \
		coc-gocode \
		coc-phpls'

.PHONY: delete
delete: ## 移除現有配置
	rm -vf $(HOME)/.vim
	rm -vf $(HOME)/.vimrc
	rm -vf $(HOME)/.vimrc.local
	rm -vf $(HOME)/.vimrc.local.bundles
	rm -vf $(HOME)/.config/nvim

# Absolutely awesome: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
