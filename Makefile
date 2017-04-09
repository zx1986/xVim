init:
	brew install ctags
	brew install neovim/neovim/neovim
	git submodule init
	git submodule update
	ln -nsiF $(PWD)/ $(HOME)/.config/nvim
	ln -nsiF $(PWD)/vimrc $(HOME)/.config/nvim/init.vim
	alias vim='nvim'
