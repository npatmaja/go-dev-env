# Yet Another Docker Image for Golang Development Environment
A docker image for developing program (application) in [Golang](https://golang.org/).
This image enables developers to develop program in Go without installing the language.
To make things easier, this image also by default able to watch Go source files and
build them when changes are detected. Additionally, vim with [vim-go](https://github.com/fatih/vim-go)
is also available for you who uses vim as the main code editor.

## What's included?
- Latest Golang release based on `golang:alpine` image
- Git
- Vim with plugins:
	- [vim-go](https://github.com/fatih/vim-go)
	- [neocomplete](https://github.com/Shougo/neocomplete.vim)
	- [nerdcommenter](https://github.com/scroolose/nerdcommenter)
	- [vim-fugitive](https://github.com/tpope/vim-fugitive)
	- [vim-gitgutter](https://github.com/vim-gitgutter)
	- [vim-airline](https://github.com/vim-airline)
- [govendor](https://github.com/kardianos/govendor)
- [reflex](https://github.com/cespare/reflex), a small tool to watch a directory and rerun a command when
  certain files change.

## Using the image
By default the images expose port `8080` to be linked to the host or other
images. Your working directory should be mounted to the image's `/go/src/app`
volume as it is the image's working directory. The main file of your program
should be named with `main.go` to benefit the auto build upon changes, otherwise
you should overide the default comand.

### Watch and build Go files upon changes
```
$ docker run -v ${PWD}:/go/src/app -p "8080:8080" npatmaja/godev
```

### Edit files using Vim
```
$ docker run -it -v ${PWD}:/go/src/app -p "8080:8080" npatmaja/godev vim
```
If you want to disable hardware control flow when using vim, i.e., enable
`CTRL-S` and `CTRL-Q`, then you would want to use the following:
```
$ docker run it -v ${PWD}:/go/src/app -p "8080:8080" npatmaja/godev sh -l
the-container-id:go/src/app# vim
```
`sh -l` tells `sh` to act as a login shell which then it will execute `/etc/profiles` and also every `*.sh`
`/etc/profile.d/` where the script to disable hardawaer control flow reside.

### Handling permission issue
By default, Docker runs all commands with `root` user. This will create a permission issue
when creating/editing your program's source code as the created/edited file will be
owned by `root` user even after terminating the running container, which I found really
annoying. To coupe with the issue, one of the solution is to
[specify a user](https://docs.docker.com/engine/reference/run/#/user) when running the
docker image using `-u` or `--user`:
```
 $ docker run it -v ${PWD}:/go/src/app -p "8080:8080" -u `id -u`:`id -g` npatmaja/godev sh -l
 
```
The aforementioned command will pass the host's current user id and groud id as container's user.
Hence, the resulting files owned by the same UID and GID.
