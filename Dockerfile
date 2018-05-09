FROM golang:1.9-alpine
MAINTAINER Nauval Atmaja

ENV SRCPATH /go/src/app

# Copy doftiles and make them accessible
# globally
COPY vimrc /etc/vim/vimrc
COPY profile /etc/profile.d/godev.sh
COPY gitconfig /etc/gitconfig
COPY gitmessage /etc/gitmessage

# Seeting up box:
# - add nobody's home directory
# - install package
RUN mkdir /home/nobody && \
	chmod 777 /home/nobody && \
	apk add --no-cache \
	git \
	vim \
	curl

# Install Vim plugins
# using Pathogen to manange the plugin
RUN mkdir -p \
	/usr/share/vim/vimfiles/autoload \
	/usr/share/vim/vimfiles/bundle && \
	curl -LSso /usr/share/vim/vimfiles/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
	cd /usr/share/vim/vimfiles/bundle && \
	git clone --depth 1 --branch 2.5.1 https://github.com/scrooloose/nerdcommenter.git && \
	git clone --depth 1 --branch ver.2.1 https://github.com/Shougo/neocomplete.vim.git && \
	git clone --depth 1 https://github.com/tpope/vim-fugitive.git && \
	git clone --depth 1 --branc v2.1 https://github.com/tpope/vim-surround.git && \
	git clone --depth 1 https://github.com/cohama/lexima.vim.git && \
	git clone --depth 1 https://github.com/airblade/vim-gitgutter.git && \
	git clone --depth 1 --branch v1.16 https://github.com/fatih/vim-go.git && \
	git clone --depth 1 https://github.com/vim-airline/vim-airline.git && \
	rm -rf \
	nerdcommenter/.git \
	neocomplete/.git \
	vim-fugitive/.git \
	vim-surround/.git \
	lexima.vim/.git \
	vim-gitgutter/.git \
	vim-go/.git \
	vim-airline/.git

# Install dependencies
# Tooling:
# - dep
# - govendor v1.0.9
# - reflex v0.2.0
# vim-go dependencies
# - asmfmt
# - errcheck
# - fillstruct
# - gocode
# - godef
# - gogetdoc
# - goimports
# - golint
# - gometalinter
# - gomodifytags
# - gorename
# - gotags
# - guru
# - impl
# - keyify
# - motion
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh && \
	cd /go/src/ && \
	git clone --branch v1.0.9 https://github.com/kardianos/govendor.git && \
	cd govendor && \
	go get && \
	cd /go/src/ && \
	git clone --branch v0.2.0 https://github.com/cespare/reflex.git && \
	cd reflex && \
	go get && \
	cd /go/src && \
	go get -u github.com/klauspost/asmfmt/cmd/asmfmt && \
	go get -u github.com/kisielk/errcheck && \
	go get -u github.com/davidrjenni/reftools/cmd/fillstruct && \
	go get -u github.com/nsf/gocode && \
	go get -u github.com/rogpeppe/godef && \
	go get -u github.com/zmb3/gogetdoc && \
	go get -u golang.org/x/tools/cmd/goimports && \
	go get -u github.com/golang/lint/golint && \
	go get -u github.com/alecthomas/gometalinter && \
	go get -u github.com/fatih/gomodifytags && \
	go get -u golang.org/x/tools/cmd/gorename && \
	go get -u github.com/jstemmer/gotags && \
	go get -u golang.org/x/tools/cmd/guru && \
	go get -u github.com/josharian/impl && \
	go get -u github.com/dominikh/go-tools/cmd/keyify && \
	go get -u github.com/fatih/motion && \
	rm -rf /go/src/* && \
	apk del curl && \
	mkdir -p /go/src/app

# Create script to be executed by reflex upon code changes
RUN mkdir /_tools && \
	touch /_tools/up.sh && \
	echo "#!/bin/sh" >> /_tools/up.sh && \
	echo "reflex -c /_tools/reflex.conf; sh" >> /_tools/up.sh && \
	chmod +x /_tools/up.sh && \
	touch /_tools/reflex.conf && \
	echo "-sg '*.go' /_tools/build.sh" >> /_tools/reflex.conf && \
	touch /_tools/build.sh && \
	echo "#!/bin/sh" >> /_tools/build.sh && \
	echo "cd $SRCPATH && go build -o /appbin && rm -rf /tmp/*" >> /_tools/build.sh && \
	echo "/appbin" >> /_tools/build.sh && \
	chmod +x /_tools/build.sh

VOLUME /go/src/app

WORKDIR /go/src/app

EXPOSE 8080

CMD ["reflex", "-c", "/_tools/reflex.conf"]
