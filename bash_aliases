# ~/.bash_aliases: executed from ~/.bashrc

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
alias make='colormake'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# server aliases
alias ssh-dev-shopper='ssh dev-gnpd-shopper-app03.london.mintel.ad'
alias ssh-dev-gda='ssh dev-gnpd-da-app01.london.mintel.ad'
alias ssh-dev-gnpd-10='ssh dev-gnpd-app10.london.mintel.ad'
alias ssh-dev-gnpd='ssh dev-gnpd-app13.london.mintel.ad'
alias ssh-gnpd-db11='ssh gnpd-linux-db-primary.svc.mintel.ad'
alias ssh-gnpd-db12='ssh gnpd-linux-db-backup.svc.mintel.ad'
alias ssh-gnpd-prod='ssh dev-gnpd-production-app01'
alias ssh-gnpd-web='ssh dev-gnpd-app13.london.mintel.ad'
alias ssh-dev-ppt='ssh est-ppt-app01.london.mintel.ad'

# python aliases
alias python2='python'
alias python='python3'
