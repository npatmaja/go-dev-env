# Set stty to ixon to enable <C-s> in vim. Ref http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

export PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"

# Set hom folder to /home/nobody for non root user
LUID=`id -u`

if [ $LUID -gt 0 ] ; then
	export HOME=/home/nobody
fi

# Aliases
alias ll="ls -al"
