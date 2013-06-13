init:
	sudo apt-get install vim vim-doc exuberant-ctags git git-doc curl wget
	git submodule init
	git submodule update
	ln -s $(PWD)/vimrc $(HOME)/.vimrc
	ln -s $(PWD)/ $(HOME)/.vim
