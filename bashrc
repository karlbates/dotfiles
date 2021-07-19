# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi


# set colour codes (fg=foreground, bg=background)
# name      standard    bright
#           fg  bg      fg  bg
# black     30  40      90  100
# red       31  41      91  101
# green     32  42      92  102
# yellow    33  43      93  103
# blue      34  44      94  104
# magenta   35  45      95  105
# cyan      36  46      96  106
# white     37  47      97  107

# eg "\e[1;30;47m" = bold black letters ith white background
#     ^^            escape code (\e or \033)
#       ^           [ required
#        ^          format, optional (0=standard, 1=bold)
#         ^         separator
#          ^^       text code
#            ^      separator
#             ^^    background code
#               ^   end code
C_RESET="\033[0m"
# standard colours
  C_black="\033[30m"
    C_red="\033[31m"
  C_green="\033[32m"
 C_yellow="\033[33m"
   C_blue="\033[34m"
C_magenta="\033[35m"
   C_cyan="\033[36m"
  C_white="\033[37m"
# bold standard colours
  C_BLACK="\033[1;30m"
    C_RED="\033[1;31m"
  C_GREEN="\033[1;32m"
 C_YELLOW="\033[1;33m"
   C_BLUE="\033[1;34m"
C_MAGENTA="\033[1;35m"
   C_CYAN="\033[1;36m"
  C_WHITE="\033[1;37m"
# bright colours
  C_B_black="\033[90m"
    C_B_red="\033[91m"
  C_B_green="\033[92m"
 C_B_yellow="\033[93m"
   C_B_blue="\033[94m"
C_B_magenta="\033[95m"
   C_B_cyan="\033[96m"
  C_B_white="\033[97m"
# bold bright colours
  C_B_BLACK="\033[1;90m"
    C_B_RED="\033[1;91m"
  C_B_GREEN="\033[1;92m"
 C_B_YELLOW="\033[1;93m"
   C_B_BLUE="\033[1;94m"
C_B_MAGENTA="\033[1;95m"
   C_B_CYAN="\033[1;96m"
  C_B_WHITE="\033[1;97m"
# custom colours
C_OCHRE="\033[38;5;95m"
C_WHITE_RED="\033[1;37;41m"


function git_branch {
    local git_status="$(timeout 2 git status 2> /dev/null)"
    local on_branch="On branch ([^${IFS}]*)"
    local on_commit="HEAD detached at ([^${IFS}]*)"

    if [[ $git_status =~ $on_branch ]]; then
        local branch=${BASH_REMATCH[1]}
        echo "($branch)"
    elif [[ $git_status =~ $on_commit ]]; then
        local commit=${BASH_REMATCH[1]}
        echo "($commit)"
    fi
}

function git_colour {
    local git_status="$(timeout 2 git status 2> /dev/null)"

    if [[ ! $git_status =~ "working directory clean" ]]; then
        echo -e ${C_RED}red
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
        echo -e ${C_YELLOW}yellow
    elif [[ $git_status =~ "nothing to commit" ]]; then
        echo -e ${C_GREEN}green
    else
        echo -e ${C_OCHRE}ochre
    fi
}

function parse_git_branch {
    local branch=$(git_branch)
    case "$branch" in
    "(master)"|master)
        echo -en " ${C_red}${branch}"
        ;;
    "")
        ;;
    *)
        echo -en " ${C_YELLOW}${branch}"
        ;;
    esac
}

function user_colour {
    case $USER in
    root)
        echo -e $C_WHITE_RED
        ;;
    *)
        echo -e $C_MAGENTA
        ;;
    esac
}

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}"
    PS1+="\[\$(user_colour)\]\u"
    PS1+="\[$C_RESET\]@"
    PS1+="\[$C_GREEN\]\h"
    PS1+="\[$C_RESET\]:"
    PS1+="\[$C_BLUE\]\W"
    PS1+="\[$C_RESET\]"
    PS1+="\$(parse_git_branch)"
    PS1+="\n"
    PS1+="\[$C_RESET\]\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# added by perl
PATH="/home/$USER/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/$USER/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/$USER/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/$USER/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/$USER/perl5"; export PERL_MM_OPT;

##########
## self added
export EDITOR=vim
export USING_PER_DEV_REPLICATION=1
export PIPENV_VENV_IN_PROJECT=1

if [[ -f $HOME/.env ]]; then
    source $HOME/.env
fi

function path_remove {
  # Delete path by parts so we can never accidentally remove sub paths
  PATH=${PATH//":$1:"/":"} # delete any instances in the middle
  PATH=${PATH/#"$1:"/} # delete any instance at the beginning
  PATH=${PATH/%":$1"/} # delete any instance in the at the end
}

function _tmux {
tmux new-session -d -s $1
tmux send-keys -t $1 "export PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/var/cfengine/bin:/usr/share/doc/subversion-1.6.11:/opt/mv_pro_5.0/montavista/pro/devkit/arm/v5t_le/bin/:/home/london/$USER/bin" enter
tmux send-keys -t $1 "unset XDG_DATA_DIRS" Enter
tmux send-keys -t $1 "unset X_SCLS" Enter
tmux send-keys -t $1 "unset PKG_CONFIG_PATH" Enter
tmux send-keys -t $1 "unset LD_LIBRARY_PATH" Enter
tmux attach -t $1
}

alias tmuxx=_tmux

function glog {
   git log --graph --all --format=format:"%x09%C(yellow)%h%C(reset) %C(green)%ai%x08%x08%x08%x08%x08%x08%C(reset) %C(bold white)%cn%C(reset)%C(auto)%d%C(reset)%n%x09%C(white)%s%C(reset)" --abbrev-commit "$@"
   echo
}


if [ -d /opt/rh/rh-python36 ]; then
    source /opt/rh/rh-python36/enable
fi

if [ -d /opt/rh/httpd24 ]; then
    source /opt/rh/httpd24/enable
fi

if [ -f $HOME/.local/autocomplete/make_sh_autocomplete ]; then
    source $HOME/.local/autocomplete/make_sh_autocomplete
fi


# CUDA et al
if [ -d /usr/local/cuda ]; then
    PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
    export CUDA_HOME=/usr/local/cuda
fi


# jfrog
if [[ -f $HOME/.jfrog-credentials ]]; then
    now=$(date +%s)
    enddate=$(jq -r .expiry_date $HOME/.jfrog-credentials)
    jfrog_user=$(jq -r .username $HOME/.jfrog-credentials)
    end=$(date -d ${enddate} +%s)
    if [[ $now -gt $end ]]; then
        rm $HOME/.jfrog-credentials
        rm $HOME/.jfrog-env
    fi
fi
if [[ -n $PORTUNUS_USER ]]; then
    jfrog_user=$PORTUNUS_USER
fi
if [[ -f $HOME/.jfrog-env ]]; then
    source $HOME/.jfrog-env
elif [[ `which portunus` ]]; then
    if [[ -n "$jfrog_user" ]]; then
        echo "portunus (user: $jfrog_user)"
        portunus -u $jfrog_user
    else
        echo portunus
        portunus
    fi

    source $HOME/.jfrog-env
fi

# thefuck
_=which thefuck
if [[ $? -eq 0 ]]; then
    eval "$(thefuck --alias)"
fi



