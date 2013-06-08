init:
	git submodule init
	git submodule update
	ln -s $(PWD)/vimrc $(HOME)/.vimrc
	ln -s $(PWD)/ $(HOME)/.vim
