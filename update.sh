#!/bin/bash

versions=(
    1.9
    1.10
    1.11
)

for version in "${versions[@]}"
do
    for variant in \
		alpine3.{7,8} \
	; do
		echo "Updating Dockerfile for Golang $version/$variant"
		mkdir -p $version/$variant
		cp vimrc profile gitmessage gitconfig $version/$variant
	    tag=${variant#alpine} # yields 3.7,3.8...
	    template='alpine'

		sed \
			-e 's!%%VERSION%%!'"$version"'!g' \
			-e 's!%%VARIANT%%!'"$variant"'!g' \
			"Dockerfile-${template}.template" > "$version/$variant/Dockerfile"
	done
done
