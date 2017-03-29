#!/bin/bash
if [ ! -d "$HOME/.vim/bundle/nerdtree" ]; then
  git clone https://github.com/scrooloose/nerdtree.git "$HOME/.vim/bundle/nerdtree"
fi
