if [[ $- != *i* ]] ; then
	return
fi

# Put your fun stuff here.
umask 0077

export LANG=en_US.UTF-8
export PATH="/home/test/.local/bin:$PATH"
export PAGER="/usr/bin/less -isR"

set -o vi
export EDITOR=/usr/bin/vim
export PROMPT_COMMAND='export TTY=`tty`'
export PS1="\
\[\033[1;31m\]\u\[\033[1;30m\]@\[\033[1;31m\]\H \
\[\033[1;30m\]&\[\033[0;33m\]\j \
\[\033[1;30m\]^\[\033[1;33m\]\${TTY:5} \
\[\033[1;30m\]+\[\033[1;33m\]\${SHLVL} \
\[\033[1;30m\]!\[\033[1;33m\]\! \
\[\033[1;34m\]\w\[\033[1;35m\] \n％ \[\033[0;0m\]"

[[ -n $DISPLAY ]] &&  export TERM=screen-256color
