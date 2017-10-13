#!/bin/bash
sudo yum update -y
sudo yum install tmux vim -y
# Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ./.tmux.conf ~
cp ./.vimrc ~
