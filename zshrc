alias dev="mosh $DEVSERVER"
alias tm="tmux attach -d || tmux new-session \; split-window -h"
alias stetho="scripts/dumpapp"
alias vim="vim -p"

export KEYTIMEOUT=1
export TRACE=1

# Fancy hg prompt
#source /opt/facebook/hg/share/scm-prompt

function stabilize() {
    hg rebase -b ${1-.} -d fbandroid/stable
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

# Always actually look in $PATH for executable -- don't trust the cache of executables
zstyle ":completion:*:commands" rehash 1

PROMPT="
%{$fg[green]%}%*%{$reset_color%} \
%{$fg[yellow]%} \
#${hg_info}\
%{$fg[cyan]%}${current_dir}%{$reset_color%} \
%{$fg[white]%}$ %{$reset_color%}"
