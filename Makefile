init:
	brew install ctags
	brew install neovim/neovim/neovim
	alias vim="nvim"
	git submodule init
	git submodule update
	curl -sLf https://spacevim.org/install.sh | bash
	mkdir -p ${HOME}/.SpaceVim.d/
	ln -sinF ${PWD}/vimrc ${HOME}/.SpaceVim.d/init.vim
	ln -sinF ${PWD}/spacevim ${HOME}/.spacevim
