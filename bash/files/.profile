# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Turn on vi mode!
set -o vi 

alias .profile='vim ~/.profile'
alias .profile.d='cd ~/.profile.d'
alias profile='sudo vim /etc/profile'
alias profile.d='cd /etc/profile.d/'

alias init.d='cd /etc/init.d'

alias Downloads='cd ~/Downloads'
alias Desktop='cd ~/Desktop'

for script in ~/.profile.d/*.sh ; do
        if [ -r $script ] ; then
                . $script
        fi
done

# Put .bashrc.d on the path
pathappend ~/.bashrc.d

# Put pwd on the path.
pathappend .
