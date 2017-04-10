init:
	brew install vim
	brew install ctags
	git submodule init
	git submodule update
	ln -nsiF $(PWD)/ $(HOME)/.vim
	ln -nsiF $(PWD)/vimrc.spf13 $(HOME)/.vimrc.local
	ln -nsiF $(PWD)/vimrc.before.local $(HOME)/.vimrc.before.local
	ln -nsiF $(PWD)/vimrc.bundles.local $(HOME)/.vimrc.bundles.local
	curl http://j.mp/spf13-vim3 -L -o - | sh

update:
	cd $(HOME)/.spf13-vim-3/ && git pull
	vim +BundleInstall! +BundleClean +q
