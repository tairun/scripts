#!/bin/bash

## This script install the python3 implementation of powerline via pip and configures it for vim, tmux and bash.
## You still need to install a patched font and activate it in your temrinal emulator. UTF-8 support required.
## Doc: https://powerline.readthedocs.io/en/master/index.html
## Fonts: https://github.com/powerline/fonts

sudo apt install -y python3 python3-pip vim tmux zsh
sudo pip3 install powerline-status

touch ~/.zshrc
echo ". /usr/local/lib/python3.5/dist-packages/powerline/bindings/zsh/powerline.zsh" > .zshrc

# Create ~/.tmux.conf
cat > ~/.tmux.conf << EOF
run-shell "powerline-daemon -q"
source "/usr/local/lib/python3.5/dist-packages/powerline/bindings/tmux/powerline.conf"
set -g default-terminal "screen-256color"
EOF

# Create ~/.vimrc
cat > ~/.vimrc << EOF
set laststatus=2
set t_Co=256
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set rtp+=/usr/local/lib/python3.5/dist-packages/powerline/bindings/vim
"set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim
let g:powerline_pycmd = "py3"
let g:powerline_pyeval = "py3eval"
let g:powerline_fonts = 1
set noshowmode
let g:bufferline_echo = 0
EOF

# Add to ~/.bashrc
cat >> ~/.bashrc << EOF
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/local/lib/python3.5/dist-packages/powerline/bindings/bash/powerline.sh
export TERM=xterm-256color
alias tmux='tmux -2'
[ -z "$TMUX"  ] && { tmux attach || tmux new-session;}
EOF