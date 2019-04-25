# grab things necessary to make debugging containers easier
apk add --no-cache bash-completion iproute2
echo . /usr/share/bash-completion/bash_completion >> /.bashrc
echo . /bashrc >> /.bashrc

if [ -f /extradebug.sh ]; then
	/extradebug.sh
fi

