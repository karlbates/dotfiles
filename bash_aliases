# ~/.aliases: executed from ~/.<shell>rc

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# more colours
#_=`which colormake`
#if [[ $? -eq 0 ]]; then
#    alias make='colormake'
#fi

# some more ls aliases
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

# server
alias ssh-dev-shopper='ssh -A dev-gnpd-shopper-app03.london.mintel.ad'
alias ssh-dev-gda='ssh -A dev-gnpd-da-app01.london.mintel.ad'
alias ssh-gda1='ssh -A gda-app01.lon-dc.mintel.ad'
alias ssh-gda2='ssh -A gda-app02.lon-dc.mintel.ad'
alias ssh-db8='ssh -A internal-db08.lon-dc.mintel.ad'
alias ssh-db9='ssh -A internal-db09.lon-dc.mintel.ad'
alias ssh-dev-gnpd-10='ssh -A dev-gnpd-app10.london.mintel.ad'
alias ssh-dev-gnpd='ssh -A dev-gnpd-app13.london.mintel.ad'
alias ssh-gnpd-db11='ssh -A gnpd-linux-db-primary.svc.mintel.ad'
alias ssh-gnpd-db12='ssh -A gnpd-linux-db-backup.svc.mintel.ad'
alias ssh-gnpd-prod='ssh -A dev-gnpd-production-app01'
alias ssh-gnpd-web='ssh -A dev-gnpd-app13.london.mintel.ad'
alias ssh-dev-ppt='ssh -A est-ppt-app01.london.mintel.ad'

# python
alias py2='python2'
alias py3='python3'
alias ppy3='PYTHONPATH=. python3'

# pytest
alias ppytest='PYTHONPATH=src pytest -svvv'
alias fpytest='PYTHONPATH=func pytest -svvv'

alias pienv='pipenv'

# docker
alias stopker="docker ps -q | xargs -t docker stop"
alias clearker="docker ps -qa | xargs -t docker rm"
alias dieker="stopker && clearker"

# git
alias gt="git"

