# puts path name in bash
export PATH="/usr/local/bin:$PATH"

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
export PATH="/usr/local/bin:$PATH"
export PATH=/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/libexec

# makes it so that not case sensitive
# shopt -s nocaseglob;

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
alias man='man -P less'

# lsg shortcut
alias lsg="ssh -A lsg-east.akamai.com"

export PATH="$HOME/.cargo/bin:$PATH"

# Create a new directory and enter it
function mkd() { 
    mkdir -p "$@" && cd "$_";
}
