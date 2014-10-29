POWERLINE_PATH = vim/bundle/powerline
BASHRCD_FILES = $(wildcard *.bashrcd)
SHELL=bash

.PHONY: bashrcd
all: vim bash gitconfig
	@echo "Configuration installed"

init:
	git submodule init

gitconfig-clean:
	rm -f ~/.gitconfig

gitconfig: gitconfig-clean
	ln -sf $(CURDIR)/gitconfig ~/.gitconfig
	
vim-clean:
	rm -f ~/.vimrc
	rm -Rf ~/.vim

vim-init:
	ln -sf $(CURDIR)/vim ~/.vim
	ln -sf ~/.vim/vimrc ~/.vimrc
	@vim +PluginInstall +qall
	@if [ `git -C vim/bundle/powerline/ log -1 --format=format:%h` == "491ac11" ] && [ ! "`git -C vim/bundle/powerline/ diff`" ]; then git -C vim/bundle/powerline/powerline/ apply -v $(CURDIR)/patches/powerline.segment.patch; fi
	@if [ `git -C vim/bundle/riv.vim/ log -1 --format=format:%h` == "91c0ebb" ] && [ ! "`git -C vim/bundle/riv.vim/ diff`" ]; then git -C vim/bundle/riv.vim/ apply -v $(CURDIR)/patches/riv.clickable.patch; fi

vim: init vim-clean vim-init powerline
	echo "Vim plugins initialized"

powerline: vim-init ubuntu-powerline-fonts
	#cd $(POWERLINE_PATH); python setup.py install --user	
	@mkdir -p ~/.config/powerline
	cp -R $(POWERLINE_PATH)/powerline/config_files/* ~/.config/powerline/
	@rm -f ~/.config/powerline/config.json
	ln -s $(CURDIR)/powerline.json ~/.config/powerline/config.json	

bash-clean:
	rm -f ~/.bashrc
	rm -f ~/.profile

bash-init:
	@mkdir -p ~/.bashrc.d

bash: init bash-clean bash-init
	ln -s $(CURDIR)/bashrc ~/.bashrc
	ln -s $(CURDIR)/profile ~/.profile
	@$(foreach file, $(BASHRCD_FILES), ln -s $(CURDIR)/$(file) ~/.bashrc.d/$(basename $(file));)

gnome-term-setup: ubuntu-powerline-fonts
	@$(CURDIR)/tomorrow-theme/Gnome-Terminal/setup-theme.sh
	gconftool-2 -t string --set /apps/gnome-terminal/profiles/Tomorrow/font "Ubuntu Mono derivative Powerline 12"
	gconftool-2 -t bool --set /apps/gnome-terminal/profiles/Tomorrow/allow_bold false
	gconftool-2 -t bool --set /apps/gnome-terminal/profiles/Tomorrow/silent_bell true
	gconftool-2 -t string --set /apps/gnome-terminal/global/default_profile Tomorrow

ubuntu-powerline-fonts: init
	@if [ ! -d  ~/.fonts ]; then mkdir ~/.fonts;fi
	ln -sf $(CURDIR)/powerline-fonts/UbuntuMono/*.ttf ~/.fonts
	fc-cache -vf ~/.fonts

