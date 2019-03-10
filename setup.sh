#!/bin/bash

ln -s ~/config/.vimrc ~/.vimrc $@
ln -s ~/config/.vimrc ~/.nvimrc $@
ln -s ~/config/.bashrc ~/.bashrc $@
ln -s ~/config/.zshrc ~/.zshrc $@
ln -s ~/config/.envrc ~/.envrc $@
ln -s ~/config/.toprc ~/.toprc $@
mkdir ~/.config/ranger -p
ln -s ~/config/.rc.conf ~/.config/ranger/rc.conf $@
ln -s ~/config/.termite.conf ~/.config/termite/config $@
ln -s ~/config/.aliasrc ~/.aliasrc $@
ln -s ~/config/.i3config ~/.config/i3/config $@
ln -s ~/config/.i3pystatus.conf ~/.config/i3/i3pystatus.conf $@
ln -s ~/config/.Xdefaults ~/.Xdefaults $@
ln -s ~/config/.xsession ~/.xsession $@
ln -s ~/config/.xinitrc ~/.xinitrc $@
ln -s ~/config/.bg.jpg ~/.bg.jpg $@
