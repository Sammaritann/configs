# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s expand_aliases

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# This permits the root user on the local machine to connect to X windows display.
xhost +local:root > /dev/null 2>&1

function duration_timer_start {
  start_timestamp=${start_timestamp:-$SECONDS}
}

function duration_timer_stop {
  total_duration_seconds=$(($SECONDS - $start_timestamp))
  duration_seconds=$(( total_duration_seconds % 60 ))
  duration_minutes=$(( (total_duration_seconds / 60) % 60 ))
  duration_hours=$(( total_duration_seconds / 3600 ))

  if [[ $total_duration_seconds -ge 60 ]]
  then
    total_duration_string="${total_duration_seconds}s (${duration_hours}h ${duration_minutes}m ${duration_seconds}s)"
  else
    total_duration_string="${total_duration_seconds}s"
  fi

  total_duration_string="${total_duration_string}"

  unset start_timestamp
}

trap 'duration_timer_start' DEBUG

if [ "$PROMPT_COMMAND" == "" ]; then
  PROMPT_COMMAND="duration_timer_stop"
else
  PROMPT_COMMAND="$PROMPT_COMMAND; duration_timer_stop"
fi

BORDER_COLOR='\[\033[00;90m\]'
CLEAR_COLOR='\[\033[00m\]'
CWD_COLOR='\[\033[01;34m\]'
USERNAME_COLOR='\[\033[01;32m\]'
PS1=$BORDER_COLOR'────────────────── Duration: ${total_duration_string} ─── Exit status: '\$?' ──────────────────\n\n⌠'$USERNAME_COLOR'\u@\h'$CLEAR_COLOR':'$CWD_COLOR'\w'$CLEAR_COLOR'\n'$BORDER_COLOR'⌡$'$CLEAR_COLOR' '

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

# Append patterns to LS_COLORS
# Warning: asterisk is prepended to all patterns, 
#   therefore default keywords e.g. "di" will lead to error
# 1st argument: patterns. E.g. ".h .cpp"
# 2nd argument: color value. E.g. "01;34"
function append_to_LS_COLORS () {
  local patterns=$1
  local color=$2

  local prepend_asterisk=1
  if [[ $# -eq 3 ]] && [[ $3 == "no_asterisk" ]]
  then
    prepend_asterisk=0
  fi

  for pattern in $patterns
  do
    if [[ $prepend_asterisk -eq 1 ]]
    then
      pattern="*$pattern"
    fi
    LS_COLORS="$LS_COLORS:$pattern=$color"
  done
}

function config_colors {
  # Effects
  local DEFAULT="00"
  local BOLD="01"
  local UNDERLINED="04"
  local FLASHING="05"
  local REVERTED="07"
  local CONCEALED="08"

  # Colors
  local BLACK="30"
  local RED="31"
  local GREEN="32"
  local ORANGE="33"
  local BLUE="34"
  local PURPLE="35"
  local CYAN="36"
  local GREY="37"

  # Backgrounds
  local BLACK_BG="40"
  local RED_BG="41"
  local GREEN_BG="42"
  local ORANGE_BG="43"
  local BLUE_BG="44"
  local PURPLE_BG="45"
  local CYAN_BG="46"
  local GREY_BG="47"

  # Extra colors
  local DARK_GREY="90"
  local LIGHT_RED="91"
  local LIGHT_GREEN="92"
  local YELLOW="93"
  local LIGHT_BLUE="94"
  local LIGHT_PURPLE="95"
  local TURQUOISE="96"
  local WHITE="97"

  local DARK_GREY_BG="100"
  local LIGHT_RED_BG="101"
  local LIGHT_GREEN_BG="102"
  local YELLOW_BG="103"
  local LIGHT_BLUE_BG="104"
  local LIGHT_PURPLE_BG="105"
  local TURQUOISE_BG="106"
  local WHITE_BG="107"

  # TODO Refactor? Delete?
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

  local NOT_INTERESTING_COLOR=$DARK_GREY

  export GCC_COLORS=":error=$BOLD;$RED:warning=$BOLD;$PURPLE:note=$BOLD;$CYAN:path=$BOLD;$CYAN"
  GCC_COLORS="$GCC_COLORS:range1=$GREEN:range2=$BLUE:locus=$DARK_GREY:quote=$BOLD;$LIGHT_BLUE"
  GCC_COLORS="$GCC_COLORS:fnname=$BOLD;$GREEN:targs=$PURPLE:fixit-insert=$GREEN:fixit-delete=$RED"
  GCC_COLORS="$GCC_COLORS:diff-filename=$BOLD:diff-hunk=$GREEN:diff-delete=$RED:diff-insert=$GREEN:type-diff=$BOLD;$GREEN"

  export LS_COLORS=""
  append_to_LS_COLORS "di" "$GREEN" "no_asterisk"             # directories
  append_to_LS_COLORS "ex" "$RED" "no_asterisk"               # executables
  append_to_LS_COLORS "ln" "target" "no_asterisk"             # symbolic link
  append_to_LS_COLORS "or" "$WHITE;$RED_BG" "no_asterisk"     # broken symlink

  local C_HEADERS=".h .hpp .hxx"
  local C_SOURCES=".c .cpp .cxx"
  local C_SOURCES_COLOR="$BLUE"
  append_to_LS_COLORS "$C_HEADERS" "$C_HEADERS_COLOR"
  append_to_LS_COLORS "$C_SOURCES" "$C_SOURCES_COLOR"

  local BUILD_FILES="Makefile CMakeLists.txt"
  local BUILD_FILES_COLOR="$BLACK;$YELLOW_BG"
  append_to_LS_COLORS "$BUILD_FILES" "$BUILD_FILES_COLOR"

  local VISUAL_STUDIO_FILES=".filters .rc .user .vcproj .vcxproj .sln .manifest .ui"
  local SOURCE_CONTROL_FILES=".git .github .gitignore .gitmodules .gitattributes"
  local VISUAL_STUDIO_FILES_COLOR="$NOT_INTERESTING_COLOR"
  local SOURCE_CONTROL_FILES_COLOR="$NOT_INTERESTING_COLOR"
  append_to_LS_COLORS "$VISUAL_STUDIO_FILES" "$VISUAL_STUDIO_FILES_COLOR"
  append_to_LS_COLORS "$SOURCE_CONTROL_FILES" "$SOURCE_CONTROL_FILES_COLOR"
}
config_colors

# Define LS_COMMAND variable containing command for printing directory contents
# Defaults to "ls"
function config_ls
{
  LS_COMMAND="ls"
  if command -v lsd &> /dev/null
  then
    LS_COMMAND="lsd"
  fi
}
config_ls

function config_completions {
  # Show completion options
  bind 'set show-all-if-ambiguous on'

  # Pressing tab will traverse completion options
  # bind 'TAB:menu-complete'

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi
}
config_completions

function config_path {
  # Rust build system thing(?)
  if [ -f "$HOME/.cargo/env" ]; then
      . "$HOME/.cargo/env"
  fi

  # Directory for locally installed third-party tools for neovim
  # Like LuaLS/lua-language-server or OpenDebugAD7 server
  PATH="$PATH:$HOME/.config/nvim/bin"

  if [ -d "$HOME/.local/bin" ]; then
      PATH="$PATH:$HOME/.local/bin"
  fi
}
config_path

export FZF_DEFAULT_OPTS="
--inline-info \
--ansi \
--color=16"

if [ -e ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -e ~/.bash_local ]; then
    . ~/.bash_local
fi
