if [[ $- != *i* ]] ; then
	return
fi

export GIT_BIN=$(which git 2>/dev/null)
export TTY=$(tty)
export COLUMNS=$(tput cols) # COLUMNS is not set under cygwin

function escape { echo "\[\033[$1\]"; }

function str2clr { local S="$1"
	if [ "$S" != "root" ] ; then
		local C=0
		while [ ! -z "${S}" ]; do
			local L=$(printf "%d" "'${S:0:1}") # decimal code of first letter
			C=$(( ($C+$L)%137 ))
			S=${S:1} # chop first letter from string
		done
		echo $(($C + 94)) # match the range of readable colors
	else echo 255; fi
}

if [[ "$TERM" == *-256color ]] ; then
    RESET_REAL=$(escape '0m')
      RED_REAL=$(escape '1;31m')
    BROWN_REAL=$(escape '1;33m')
     BLUE_REAL=$(escape '1;34m')
LIGHTBLUE_REAL=$(escape '1;32m')
  MAGENTA_REAL=$(escape '1;35m')
     GRAY_REAL=$(escape '38;5;242m')
USERCOLOR_REAL=$(escape "38;5;$(str2clr "${USER}")m")
HOSTCOLOR_REAL=$(escape "38;5;$(str2clr "${HOSTNAME}")m")
else
    RESET_REAL=$(escape '0m')
      RED_REAL=$(escape '1;31m')
    BROWN_REAL=$(escape '1;33m')
     BLUE_REAL=$(escape '1;34m')
LIGHTBLUE_REAL=$(escape '1;39m')
  MAGENTA_REAL=$(escape '1;35m')
     GRAY_REAL=$(escape '1;30m')
USERCOLOR_REAL=$(escape '1;36m')
HOSTCOLOR_REAL=$(escape '1;36m')
fi

function color { #{{{
    RESET=$RESET_REAL
      RED=$RED_REAL
    BROWN=$BROWN_REAL
     BLUE=$BLUE_REAL
LIGHTBLUE=$LIGHTBLUE_REAL
  MAGENTA=$MAGENTA_REAL
     GRAY=$GRAY_REAL
USERCOLOR=$USERCOLOR_REAL
HOSTCOLOR=$HOSTCOLOR_REAL
} #}}}
function nocolor { #{{{
    RESET=
      RED=
    BROWN=
     BLUE=
LIGHTBLUE=
  MAGENTA=
     GRAY=
USERCOLOR=
HOSTCOLOR=
} #}}}

function prompt { #{{{
	local GITSTATUS=
	if [ ! -z $GIT_BRANCH ]; then
	if [ ! -z $GIT_DIRTY  ]; then
		GITSTATUS="${RED}@${GIT_BRANCH} "
	else
		GITSTATUS="${GRAY}@${GIT_BRANCH} "
	fi fi

	PRETTYPWD=""
	if [ -z ${PWD/${HOME}\/*/} ] ; then
		PRETTYPWD="${LIGHTBLUE}~${BLUE}${PWD/${HOME}/}"
	else
		PRETTYPWD="${BLUE}${PWD}"
	fi

	PROMPT="${USERCOLOR}${USER}${GRAY}@${HOSTCOLOR}${HOSTNAME} \
${GRAY}&${BROWN}${JOBNUM} \
${GRAY}^${BROWN}${TTY:5} \
${GRAY}+${BROWN}${SHLVL} \
${GRAY}!${BROWN}${HISTNUM} \
${PRETTYPWD} ${GITSTATUS}${GRAY}${FILL}\n${MAGENTA}# ${RESET}"
} #}}}
function gitstatus { #{{{
	GIT_BRANCH=
	GIT_DIRTY=

	[[ -z "$GIT_BIN" ]] && return

	local CUR_DIR=$PWD
	while [ ! -d "${CUR_DIR}/.git" ] && [ ! "${CUR_DIR}" = "" ]; do
		CUR_DIR=${CUR_DIR%/*};
	done
	[[ ! -d "${CUR_DIR}/.git" ]] && return

	[[ "$CUR_DIR" == "$HOME" ]] && [[ "$PWD" != "$HOME" ]] && return

	GIT_BRANCH=$($GIT_BIN symbolic-ref HEAD 2>/dev/null)
	[[ -z "$GIT_BRANCH" ]] && return
	GIT_BRANCH=${GIT_BRANCH#refs/heads/}

	local GIT_STATUS=$($GIT_BIN status --porcelain 2>/dev/null)
	[[ -n "$GIT_STATUS" ]] && GIT_DIRTY=true
} #}}}
function promptcmd { #{{{
	PWDNAME=${PWD}
	JOBNUM=$(( $(jobs -r | wc -l) + 0 ))
	HISTNUM=$(( $(history 1 | cut -b 1-6) + 1 ))

	gitstatus

	nocolor
	prompt
		FILL=""
		for (( I = $COLUMNS; I >= 1 ; I-- )) ; do
			FILL="${FILL}─"
		done
		BURP="${PROMPT/─*#*/}"
		while [ -n "$BURP" ] ; do
			BURP=${BURP/?/}
			FILL=${FILL/─/}
		done
	color
	prompt
	PS1=$PROMPT
} #}}}

SSH_ENV="$HOME/.ssh/environment"

function runagent { #{{{
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	chmod 600 "${SSH_ENV}"
	. "${SSH_ENV}" > /dev/null
} #}}}

if [ -z "${SSH_AUTH_SOCK}" -o -n "${SSH_AGENT_PID}" ]; then
	if [ -f "${SSH_ENV}" ]; then # no forwarded agent, use (or start) local one
		. "${SSH_ENV}" > /dev/null # source current SSH settings
		ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
			runagent; # agent is (probably) dead, restart it
		}
	else runagent; fi
fi

export PROMPT_COMMAND=promptcmd
export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"
export PAGER="/usr/bin/less -isR"
export EDITOR="/usr/bin/vim"

umask 0077
set -o vi

alias ..="source ~/.bashrc"
alias ll="ls -alrth"
alias 256color="export TERM=screen-256color; .."
alias 16color="export TERM=screen; .."

[[ -e ~/.local/bin/env.sh ]] && . ~/.local/bin/env.sh
