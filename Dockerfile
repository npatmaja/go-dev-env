FROM golang:alpine
MAINTAINER Nauval Atmaja

ENV SRCPATH /go/src/app

# Copy doftiles and make them accessible
# globally
COPY vimrc /etc/vim/vimrc
COPY profile /etc/profile.d/godev.sh
COPY gitconfig /etc/gitconfig
COPY gitmessage /etc/gitmessage


# RUN echo 'hosts: files [NOTFOUND=return] dns' >> /etc/nsswitch.conf

# Tools
RUN mkdir /_tools && \
	touch /_tools/up.sh && \
	echo "#!/bin/sh" >> /_tools/up.sh && \
	echo "reflex -c /_tools/reflex.conf; sh" >> /_tools/up.sh && \
	chmod +x /_tools/up.sh && \

	# Reflex conf
	touch /_tools/reflex.conf && \
	echo "-sg '*.go' /_tools/build.sh" >> /_tools/reflex.conf && \

	# Build and run script
	touch /_tools/build.sh && \
	echo "#!/bin/sh" >> /_tools/build.sh && \
	echo "cd $SRCPATH && go build -o /appbin && rm -rf /tmp/*" >> /_tools/build.sh && \
	echo "/appbin" >> /_tools/build.sh && \
	chmod +x /_tools/build.sh && \

	# Install tools
	apk add --no-cache \
	git \
	vim \
	curl && \

	# Install vim-plug
	#curl -fLo /usr/share/vim/vimfiles/autoload/plug.vim --create-dirs \
	#https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
	# Install Pathogen
	mkdir -p \
	/usr/share/vim/vimfiles/autoload \
	/usr/share/vim/vimfiles/bundle && \
	curl -LSso /usr/share/vim/vimfiles/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \

	# Vim plugins
	cd /usr/share/vim/vimfiles/bundle && \
	git clone --depth 1 https://github.com/scrooloose/nerdcommenter.git && \
	git clone --depth 1 https://github.com/Shougo/neocomplete.vim.git && \
	git clone --depth 1 https://github.com/tpope/vim-fugitive.git && \
	git clone --depth 1 https://github.com/tpope/vim-surround.git && \
	git clone --depth 1 https://github.com/cohama/lexima.vim.git && \
	git clone --depth 1 https://github.com/airblade/vim-gitgutter.git && \
	git clone --depth 1 https://github.com/fatih/vim-go.git && \
	git clone --depth 1 https://github.com/vim-airline/vim-airline.git && \
	vim +GoInstallBinaries +qall && \
	# Cleanup
	rm -rf \
	nerdcommenter/.git \
	neocomplete/.git \
	vim-fugitive/.git \
	vim-surround/.git \
	lexima.vim/.git \
	vim-gitgutter/.git \
	vim-go/.git \
	vim-airline/.git && \

	# Nobody's home
	mkdir /home/nobody && \
	chmod 777 /home/nobody && \

	# Install govendor
	go get -u github.com/kardianos/govendor && \
	# Install reflex
	go get -u github.com/cespare/reflex && \
	# Cleanup
	rm -rf /go/src/* && \
	apk del curl && \

	# Create workspace
	mkdir -p /go/src/app

VOLUME /go/src/app

WORKDIR /go/src/app

EXPOSE 8080

CMD ["reflex", "-c", "/_tools/reflex.conf"]
