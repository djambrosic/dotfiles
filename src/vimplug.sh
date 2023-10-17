#!/bin/bash

install_vim_plug () {
    echo "Installing VimPlug"

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}