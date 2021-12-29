#!/bin/bash

command=${1:-help}
shift

default_image=buz_buildenv:neovim
default_build_type=Release

if [ $command == "build_image" ]; then
	image=${1:-$default_image}
	docker build -t $image . && \
		echo "Created image $image"
elif [ $command == "run" ]; then
	build_type=${1:-$default_build_type}
	image=${2:-$default_image}
	mkdir -p out && \
		docker run --rm -it -v "$(pwd)/out:/mnt/build_output" $image build $build_type
elif [ $command == "help" ]; then
	echo "Usage example:"
	echo -e "  $0 build_image [tag]       - Build docker image. Default tag: \"$default_image\""
	echo -e "  $0 run [build_type] [tag]  - Run container and build neovim. Default build type: \"$default_build_type\""
	echo -e "  $0 help                    - Print this message"
else
	>&2 echo "Unknown command"
	exit 1
fi

