#!/bin/sh

# .bash_profile
cat > /root/.bash_profile <<\EOF
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

# .bashrc
cat > /root/.bashrc <<\EOF
# LFS
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH

# Colored output for 'ls'
eval `dircolors -b`
alias ls='ls --color=auto'

# Some more aliases
alias ll='ls -al'
alias ..='cd ..'
alias ...='cd ../..'
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias vi='vim'

# Command prompt for root
WHITE='\[\033[1;37m\]'
RED='\[\033[0;33m\]'
NC='\[\033[0m\]'
PS1="$RED[$WHITE\u$NC@$WHITE\h$NC:$WHITE\W$RED] #$NC "

# Vim is our preferred editor
EDITOR=vim
VISUAL=$EDITOR
export EDITOR VISUAL
EOF

echo
echo "############################"
echo "Now log out and log back in."
echo "############################"
echo
