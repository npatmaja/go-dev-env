FROM golang:alpine
MAINTAINER Nauval Atmaja

ENV SRCPATH /go/src/app

RUN echo 'hosts: files [NOTFOUND=return] dns' >> /etc/nsswitch.conf

# Tools
RUN mkdir /_tools
RUN touch /_tools/reflex.conf
RUN touch /_tools/build.sh
RUN touch /_tools/up.sh

RUN chmod +x /_tools/up.sh
RUN chmod +x /_tools/build.sh

RUN echo "#!/bin/sh" >> /_tools/up.sh
RUN echo "reflex -c /_tools/reflex.conf; sh" >> /_tools/up.sh

RUN echo "-sg '*.go' /_tools/build.sh" >> /_tools/reflex.conf

RUN echo "#!/bin/sh" >> /_tools/build.sh
RUN echo "cd $SRCPATH && go build -o /appbin && rm -rf /tmp/*" >> /_tools/build.sh
RUN echo "/appbin" >> /_tools/build.sh

# Install tools
RUN apk add --no-cache \
	git \
	vim \
	curl

# Add dotfiles
ADD .vimrc /root
ADD .profile /root
ADD .gitconfig /root
ADD .gitmessage /root

# Install vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN cd /root && \
	mkdir -p .vim/plugged && \
	cd .vim/plugged && \
	git clone --depth 1 https://github.com/scrooloose/nerdcommenter.git && \
	git clone --depth 1 https://github.com/Shougo/neocomplete.git && \
	git clone --depth 1 https://github.com/tpope/vim-fugitive.git && \
	git clone --depth 1 https://github.com/airblade/vim-gitgutter.git && \
	git clone --depth 1 https://github.com/fatih/vim-go.git && \
	git clone --depth 1 https://github.com/vim-airline/vim-airline.git && \
	vim +PlugInstall +GoInstallBinaries +qall && \
	# Cleanup
	rm -rf nerdcommenter/.git neocomplete/.git vim-fugitive/.git \
	vim-gitgutter/.git vim-go/.git vim-airline/.git

# Install govendor
RUN go get -u github.com/kardianos/govendor && \
# Install reflex
	go get -u github.com/cespare/reflex && \
# Cleanup
	rm -rf /go/src/* && \
	apk del curl

# Create workspace
RUN mkdir -p /go/src/app

VOLUME /go/src/app

WORKDIR /go/src/app

EXPOSE 8080

CMD ["reflex", "-c", "/_tools/reflex.conf"]
