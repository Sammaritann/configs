#!/bin/bash

COLOR_END=$'\033[0m'
COLOR_ERROR=$'\033[31m'
COLOR_WARNING=$'\033[30;43m'
COLOR_SUCCESS=$'\033[32m'

# Create link to given target in given directory
# @param[in] $1 Target file or directory
# @param[in] $2 Directory to store link into
# @param[in] $3 Link type: "symbolic|hard". Symbolic by default
function create_link() {
	local target=$1
	local directory=$2
	local ln_cmd="ln --symbolic --relative"
	local link_type="symbolic"
	if [[ "$# -ge 3" && $3 = "hard" ]]; then
		ln_cmd="ln"
		link_type="hard"
	fi

	if [[ "$directory" != */ ]]; then
		directory="$directory/"
	fi
	local link_name="${directory}$(basename ${target})"
	if [ -e "${link_name}" ]; then
		if [ "${link_name}" -ef "${target}" ]; then
			echo ${COLOR_SUCCESS}"[x] Already exists: ${target} -> ${link_name}"${COLOR_END}
		else
			echo ${COLOR_WARNING}"[ ] File ${link_name} exists. Cannot link ${target}"${COLOR_END}
		fi
	else
		mkdir -p "$directory"
		$ln_cmd "$target" "$directory"
		if [ "${link_name}" -ef "${target}" ]; then
			echo ${COLOR_SUCCESS}"[+] Created ${link_type} link: ${target} -> ${link_name}"${COLOR_END}
		else
			echo ${COLOR_ERROR}"[ ] Failed to create: ${target} -> ${link_name}"${COLOR_END}
		fi
	fi
}

create_link alacritty ~/.config/
create_link bash/.bashrc ~/
create_link bash/.bash_aliases ~/
# TODO FEATURE: Interactive .bash_local creation?
if [ ! -e ~/.bash_local ]; then
	cp bash/.bash_local ~/
	echo ${COLOR_WARNING}"[+] Created default ~/.bash_local. Adjust defaults if needed"${COLOR_END}
else
	echo ${COLOR_WARNING}"[ ] Found existing ~/.bash_local. Check default bash/.bash_local for missing variables!"${COLOR_END}
fi
create_link gdb/.gdbinit ~/
create_link gdb/.gdbearlyinit ~/
create_link git/.gitconfig ~/
create_link i3 ~/.config/
create_link sway ~/.config/
create_link nvim ~/.config/
# Why hardlink? See redshift/README.md
create_link redshift/redshift.conf ~/.config/ hard
create_link gammastep ~/.config/
create_link terminal-colors.d ~/.config/
create_link tmux/.tmux.conf ~/
create_link X11/.Xresources ~/
create_link X11/.xsession ~/
create_link X11/.xprofile ~/
create_link X11/.Xresources.d ~/

