#!/bin/bash

# This script is an entry point for neovim build environment container

command=${1:-help}
shift

# Run repository build and forward build type
if [ $command == "build" ]; then
	build_type=${1:-${BUILD_TYPE:-$DEFAULT_BUILD_TYPE}}
	install_dir=$DEFAULT_INSTALL_DIR
	cd $SOURCE_LOCATION && \
		make CMAKE_BUILD_TYPE=$build_type \
			CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$install_dir" && \
		make install
elif [ $command == "help" ]; then
	echo "Usage example:"
	echo -e "  $0 build"
	echo -e "  $0 run [Release|Debug|RelWithDebInfo|...]"
	exit 0
else
	>&2 echo "Unknown command. Try \"docker run --entrypoint=<command>\" otherwise?"
	exit 1
fi

