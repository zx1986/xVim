init:
	brew install ctags
	brew install vim --with-python3 --with-lua --with-tcl --with-toolbar --with-gettext --with-mzscheme
	git submodule init
	git submodule update
	ln -nsiF $(PWD)/ $(HOME)/.vim
	ln -nsiF $(PWD)/vimrc.bootstrap $(HOME)/.vimrc
	ln -nsiF $(PWD)/plugins $(HOME)/.vimrc.local.bundles

clean:
	rm -vf $(HOME)/.vim
	rm -vf $(HOME)/.vimrc
