init:
	git submodule init
	git submodule update
	ln -nsiF $(PWD)/vimrc $(HOME)/.vimrc
	ln -nsiF $(PWD)/ $(HOME)/.vim
