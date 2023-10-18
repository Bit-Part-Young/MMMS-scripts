# siyuan default configuration
######################################################################
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

if [ ! -f ~/.ssh/id_rsa ]; then
    echo 'No public/private RSA keypair found.'
    ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
    cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
    echo "StrictHostKeyChecking no" > ~/.ssh/config
    chmod 600 ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/config
fi

######################################################################



# alias
######################################################################

alias ll='ls -hlF'
alias la='ls -hlAF'
alias l='ls -CF'

if which lsd >/dev/null 2>&1; then
  alias ls='lsd'
fi

alias bk="cd ..; ls"
alias dc="cd"
alias ..="cd ../..; ls"
alias clo="rm -rf *.out *.err"

######################################################################



# PATH
######################################################################

export PATH=$HOME/bin:$PATH


######################################################################

