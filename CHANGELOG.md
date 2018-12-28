# Changelog
## 1.0.0 - (December 31, 2017)

FEATURES:
* Go 1.9 from docker image `golang:1.9-alpine`

IMPROVEMENTS:
* Use released version of each dependencies whenever possible to ensure stability [[GH-9]](https://github.com/npatmaja/go-dev-env/pull/9)

BUG FIXES:
* Fix build failure when installing vim-go's dependencies using `GoInstallBinaries` [[GH-9]](https://github.com/npatmaja/go-dev-env/pull/9)

## 1.1.0 - (December 27, 2018)

FEATURES:
* Support for multiple golang version: different docker container for different version
* Add godep as the dependency management tool

