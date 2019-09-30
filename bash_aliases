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

# python aliases
alias py2='python2'
alias py3='python3'
alias ppy3='PYTHONPATH=. python3'

# pytest alias
alias ppytest='PYTHONPATH=src pytest -svvv'

alias pienv='pipenv'
