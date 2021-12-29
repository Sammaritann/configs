#!/bin/bash

alias cal='cal --monday --three --color=auto'

alias mv='mv -v -i'
alias cp='cp -v -i'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias info='info --vi-keys'
alias tree='tree -a --dirsfirst -I .git'
alias ls="$LS_COMMAND --color=auto --group-directories-first -A --sort=extension -h"
alias ll="$LS_COMMAND --color=auto --group-directories-first -A --sort=extension -h -l"

alias st='git status'
alias logfiles='git log --oneline --name-only'
alias blame='git blame --date="format:%d %b %y"'
alias ggui='git gui > /dev/null 2>&1 & disown'

alias tmuxNewNamedSession="tmux new -s "
alias clipboard_to_png='xclip -selection clipboard -t image/png -o > '
alias create_project='${MY_TEMPLATES_DIR}/install.sh'

