#!/bin/bash

# Backs up current vim configuration file if it exists, and replaces it with
# a symbolic link to vimrc in this folder in order to simplify git tracking.

INSTALL_DIR=${1:-$HOME}

exit_msg=0

echo -n "Install VIM configuration? [N/y] "
read -n 1 vim_cfg
echo

if [ "$vim_cfg" == "Y" ] || [ "$vim_cfg" == "y" ]; then
    mkdir -p .vim/colors 2> /dev/null

    wget -P .vim/colors \
    https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim 2> /dev/null

    mv $INSTALL_DIR/.vim $INSTALL_DIR/.vim.old 2> /dev/null
    mv $INSTALL_DIR/.vimrc $INSTALL_DIR/.vimrc.old 2> /dev/null
    ln -s $PWD/.vim $INSTALL_DIR/.vim 2> /dev/null
    ln -s $PWD/.vimrc $INSTALL_DIR/.vimrc 2> /dev/null
    exit_msg=1
fi

if [ "$exit_msg" == 0 ]; then
    echo "No configuration files were installed."
else
    echo "Done. Existing configuration files were moved to <file>.old"
fi

exit_msg=0

echo -n "Install TMUX configuration? [N/y] "
read -n 1 tmux_cfg
echo

if [ "$tmux_cfg" == "Y" ] || [ "$tmux_cfg" == "y" ]; then
    mv $INSTALL_DIR/.tmux.conf $INSTALL_DIR/.tmux_conf.old 2> /dev/null
    ln -s $PWD/.tmux.conf $INSTALL_DIR/.tmux.conf 2> /dev/null
    exit_msg=1
fi

if [ "$exit_msg" == 0 ]; then
    echo "No configuration files were installed."
else
    echo "Done. Existing configuration files were moved to <file>.old"
fi
