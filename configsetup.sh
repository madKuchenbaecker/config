#!/bin/env sh

./clonesetup.sh

CURRPATH="$(pwd)/$(dirname $0)"

while getopts "f" o
do 
    if [ $o == "f" ]
    then
        FORCE="-f"
    fi
done

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

function mkconfig {
    SRCPATH=${CURRPATH}/$1
    DESTPATH=${HOME}$2
    DESTDIR=$(dirname $DESTPATH)
    F=$3
    mkdir -p $F $DESTDIR
    ln -s $F $SRCPATH $DESTPATH &> /dev/null
    if [ $? -eq 0 ]
    then
        echo -e "${GREEN}success${RESET} creating symlink $DESTPATH"
    else
        echo -e "${RED}failure${RESET} creating symlink $DESTPATH (use -f to force creation)"
    fi
}

set \
    .vimrc .vimrc \
    .bashrc .bashrc \
    .zshrc .zshrc \
    .envrc .envrc \
    .toprc .toprc \
    .inputrc .inputrc \
    .rc.conf .config/ranger/rc.conf \
    .termite.conf .config/termite/config \
    .aliasrc .aliasrc \
    .i3config .config/i3/config \
    .i3pystatus.conf .config/i3/i3pystatus.conf \
    .init.vim .config/nvim/init.vim \
    .Xdefaults .Xdefaults \
    .xsession .xsession \
    .xsession .xsessionrc \
    .xinitrc .xinitrc \
    .bg.jpg .bg.jpg \

while :
do
    SRCDIR=$1
    shift &> /dev/null
    if [ $? -ne 0 ]
    then
        break
    fi
    DESTDIR=$1
    shift &> /dev/null
    if [ $? -ne 0 ]
    then
        break
    fi
    mkconfig $SRCDIR $DESTDIR $FORCE
done
