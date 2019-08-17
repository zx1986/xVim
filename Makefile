init:
	brew install ctags neovim
	gem install neovim solargraph
	npm install -g neovim
	pip install flake8 pynvim
	pip install --user --upgrade neovim
	pip3 install flake8 pynvim
	pip3 install --user --upgrade neovim
	git submodule init
	git submodule update
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -nsiF $(PWD)/ $(HOME)/.vim
	ln -nsiF $(PWD)/vimrc.local $(HOME)/.vimrc.local
	ln -nsiF $(PWD)/vimrc.local.bundles $(HOME)/.vimrc.local.bundles
	ln -nsiF $(PWD)/vimrc.bootstrap $(HOME)/.vimrc
	ln -nsiF $(PWD)/nvim ~/.config/nvim

setup:
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
		coc-tabnine \
		coc-json \
		coc-html \
		coc-yaml \
		coc-css \
		coc-vetur \
		coc-python \
		coc-phpls'

clean:
	rm -vf $(HOME)/.vim
	rm -vf $(HOME)/.vimrc
	rm -vf $(HOME)/.vimrc.local
	rm -vf $(HOME)/.vimrc.local.bundles
	rm -vf $(HOME)/.config/nvim
