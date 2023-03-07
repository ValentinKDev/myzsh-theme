# See https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"

ZSH_THEME_GIT_PROMPT_PREFIX="$fg[blue]git : "
ZSH_THEME_GIT_PROMPT_SUFFIX="$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red] [+]$reset_color"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green] [v]$reset_color"



function get_pwd() { echo "${PWD/$HOME/~}" | xargs -n 1 basename }

function get_user_name() { echo "$USERNAME" }

function put_spacing() {
	local git=$(git_prompt_info)
	if [ ${#git} != 0 ]; then
		((git=${#git} - 20))
	else
		git=0
	fi

	local termwidth
	(( termwidth = ${COLUMNS} - 8 - ${#$(get_pwd)} - ${git}))

	local spacing=""
	for i in {1..$termwidth}; do
		spacing="${spacing} "
	done
	echo $spacing
}

function deuxx(){ echo "ac"$(put_spacing)$(git_prompt_info) }

#Print a notification when text field entre vim's command mode
function zle-line-init zle-keymap-select {
	if [ $KEYMAP = vicmd ]; then
		printf "\033[2 q"
	else
		printf "\033[6 q"
	fi
	RPS1="${${KEYMAP/vicmd/-- VIM-MOTION --}/(main|viins)/}"
	RPS2=$RPS1
	zle reset-prompt
}

#Enable vim commande mode
bindkey -v
zle -N zle-line-init
zle -N zle-keymap-select

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="blue"; fi
autoload -U colors && colors
precmd(){
	local preprompt_left="%{%F{238}%}%T  %{%f%}%{%F{063}%}%c%{%f%}%$(put_spacing)$(git_prompt_info)"
	print -Pr "$preprompt_left"
}

PROMPT='%{$fg[cyan]%}%B|>%(?.:.%{$fg[magenta]%}X)%b%{$fg[cyan]%}%B<|  %b%{$reset_color%}'
