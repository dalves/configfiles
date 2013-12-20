# Use vi-style keybindings in bash
set -o vi

alias ll="ls -l"

# If multiple files are specified, open them in tabs.
alias vi="vim "
alias vim="vim -p"

# If a tmux session exists, attack to it. If not, create one with 2 panes
alias tm="tmux attach -d || tmux new-session \; split-window -h"


function mergehead {
    vimdiff <(git show HEAD:$1) $1
}

function mergewith {
    vimdiff <(git show $1:$2) $2
}

function mergehat {
    vimdiff <(git show HEAD^:$1) $1
}

function vif {
    vim `find . -name $1`
}

function scan () { find .  -type f -and \( -name "BUILD_DEFS" -or \
                           -name "BUCK" -or \
                           -name "*.java" -or \
                           -name "*.js" -or \
                           -name "*.css" -or \
                           -name "*.html" -or \
                           -name "*.py" -or \
                           -name "*.php" -or \
                           -name "*.xml"  \) -print0 |  \
        xargs -0 grep -Hn --color=auto "$1"
}


function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tbz2 | *.tar.bz2) tar xvjf $1 ;;
            *.tgz | *.tar.gz) tar xvzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) unrar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xvf $1 ;;
            *.apk | *.jar | *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

export EDITOR=vim

# Enable colors
export CLICOLOR=1;

# Set history size to 200000
export HISTCONTROL=erasedups
export HISTSIZE=200000

#export PS1='\n[\u@\h] [\t] \W$(__git_ps1 " (%s)"): '
# Nice color prompt for OSX 
export PS1='\n\[\033[1;37m\]\u\[\033[0;30m\]@\[\033[0;32m\]\h\[\033[0;0m\] \[\033[0;37m\]\t \[\033[0;36m\]\W\[\033[0;0m\]\[\033[0;33m\]$(__git_ps1 " (%s)")\[\033[0;0m\]\[\033[1;37m\]:\[\033[0;0m\] '

