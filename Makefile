init:
	brew install ctags neovim
	git submodule init
	git submodule update
	ln -nsiF $(PWD)/ $(HOME)/.vim
	ln -nsiF $(PWD)/vimrc.local $(HOME)/.vimrc.local
	ln -nsiF $(PWD)/vimrc.local.bundles $(HOME)/.vimrc.local.bundles
	ln -nsiF $(PWD)/vimrc.bootstrap $(HOME)/.vimrc
	ln -nsiF $(PWD)/nvim ~/.config/nvim

clean:
	rm -vf $(HOME)/.vim
	rm -vf $(HOME)/.vimrc
