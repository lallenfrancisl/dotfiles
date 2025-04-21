#! /bin/bash

if [ ! -d ~/.config/tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
else
    cd ~/.config/tmux/plugins/tpm
    git checkout master
    git pull origin master
fi

