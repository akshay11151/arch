#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:$HOME/.config/emacs/bin
export PATH="$HOME/.cask/bin:$PATH"
export PATH=$PATH:$HOME/.local/bin

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
