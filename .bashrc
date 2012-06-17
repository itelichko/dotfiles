if [[ $- != *i* ]] ; then
	return
fi

# Put your fun stuff here.
function prompt {
	local GITSTATUS=
	if [ ! -z $GIT_BRANCH ]; then
	if [ ! -z $GIT_DIRTY  ]; then
		GITSTATUS="${GRAY}(git:${RED}${GIT_BRANCH}${GRAY}) "
	else
		GITSTATUS="${GRAY}(git:${GRAY}${GIT_BRANCH}${GRAY}) "
	fi fi

	echo "${RED}${USER}${GRAY}@${RED}${HOSTNAME} \
${GRAY}&${BROWN}${JOBNUM} \
${GRAY}^${BROWN}${TTY:5} \
${GRAY}+${BROWN}${SHLVL} \
${GRAY}!${BROWN}${HISTNUM} \
${BLUE}${PWDNAME} ${GITSTATUS}${GRAY}${FILL}\n${MAGENTA}％ ${RESET}"
}
function escape {
	echo "\[\033[$1\]"
}
function color {
	  RESET=$(escape '0m')
	    RED=$(escape '1;31m')
	  BROWN=$(escape '1;33m')
	   BLUE=$(escape '1;34m')
	MAGENTA=$(escape '1;35m')
	   GRAY=$(escape '38;5;242m')
}
function nocolor {
	  RESET=
	    RED=
	  BROWN=
	   BLUE=
	MAGENTA=
	   GRAY=
}
function parse_git_status {
	GIT_BRANCH=
	GIT_DIRTY=

	local GIT_BIN=$(which git 2>/dev/null)
	[[ -z $GIT_BIN ]] && return

	local CUR_DIR=$PWD
	while [ ! -d ${CUR_DIR}/.git ] && [ ! $CUR_DIR = "/" ]; do
		CUR_DIR=${CUR_DIR%/*};
	done
	[[ ! -d ${CUR_DIR}/.git ]] && return

	[[ $CUR_DIR == $HOME ]] && [[ $PWD != $HOME ]] && return

	GIT_BRANCH=$($GIT_BIN symbolic-ref HEAD 2>/dev/null)
	[[ -z $GIT_BRANCH ]] && return
	GIT_BRANCH=${GIT_BRANCH#refs/heads/}

	local GIT_STATUS=$($GIT_BIN status --porcelain 2>/dev/null)
	[[ -n $GIT_STATUS ]] && GIT_DIRTY=true
}
function promptCommand {
	export TTY=`tty`
	local OLDSTTY=$(stty -g) # get cursor position and add new line
	exec < /dev/tty          # if we are not in the first column
	stty raw -echo min 0
	echo -en "\033[6n" > /dev/tty && read -sdR CURPOS
	stty $OLDSTTY
	exec < $TTY
	[[ ${CURPOS##*;} -gt 1 ]] && echo -e "\033[3;31m↵\033[0m"

	PWDNAME=$PWD
	JOBNUM=$(( $(jobs | grep -v Done | wc -l) + 0 ))
	HISTNUM=$(( $(history | tail -n 1 | cut -b 1-6) ))

	parse_git_status
	nocolor
		FILL=
		PROMPT=$(prompt)
		#$PROMPT
		#echo $PROMPT
		local FSZ=$(( $COLUMNS - $(printf "${PROMPT/％*/}" | wc -c | tr -d " ") ))
		for (( ; FSZ >= 0 ; FSZ-- )) ; do
			FILL="${FILL}─"
		done
	color
	PS1=$(prompt)
}
export PROMPT_COMMAND=promptCommand
export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"
export PAGER="/usr/bin/less -isR"
export EDITOR=/usr/bin/vim

[[ -n $DISPLAY ]] &&  export TERM=screen-256color

umask 0077
set -o vi
