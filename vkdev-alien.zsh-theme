#how colors fcking works ?
#% echo $TERM
#xterm-256color
# See https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"

ZSH_THEME_GIT_PROMPT_PREFIX="$fg[blue]git : "
ZSH_THEME_GIT_PROMPT_SUFFIX="$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red] [+]$reset_color"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green] [v]$reset_color"

function zle-line-init zle-keymap-select {
	if [ $KEYMAP = vicmd ]; then
		printf "\033[2 q"
	else
		printf "\033[6 q"
	fi
	RPS1="${${KEYMAP/vicmd/-- VIM-MOTION --}/(main|viins)/}"
    #RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}


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

function deuxx(){
	#echo " %{$fg[white]%}[%T] %{$fg[white]%}%B%c%b%{$reset_color%}$(put_spacing)$(git_prompt_info)"
	echo "ac"$(put_spacing)$(git_prompt_info)
}
#PROMPT='%{$fg[white]%}[%T] %{$fg[white]%}%B%c%b%{$reset_color%}$(put_spacing)$(git_prompt_info)'
#PROMPT+='%{$fg[cyan]%}%B |>%(?.:.%{$fg[magenta]%}X)%b%{$fg[cyan]%}%B<|  %b%{$reset_color%}'
#utilise strftime pour faire des comparaisons
#NEWLINE=$'\n'
#PROMPT="%{$fg[white]%}[%T] %{$fg[white]%}%B%c%b%{$reset_color%}$(put_spacing)$(git_prompt_info)%{$fg[cyan]%}%B |>%(?.:.%{$fg[magenta]%}X)%b%{$fg[cyan]%}%B<|  %b%{$reset_color%}"
#precmd() { eval "%{$fg[white]%}[%T] %{$fg[white]%}%B%c%b%{$reset_color%}$(put_spacing)$(git_prompt_info)" }
#PROMPT_COMMAND='%{$fg[white]%}[%T] %{$fg[white]%}%B%c%b%{$reset_color%}$(put_spacing)$(git_prompt_info)'
#precmd(){
#deuxx
#}
#PROMPT='%{$fg[cyan]%}%B |>%(?.:.%{$fg[magenta]%}X)%b%{$fg[cyan]%}%B<|  %b%{$reset_color%}'
#setopt proomptsubst
#PROMPT= 'Euuuh %T $(a_command) vlasu'

#autoload -U add-zsh-hook
#add-zsh-hook precmd prompt_me_setup

#prompt_me_setup () {
#local preprompt_left="df"
#echo 'PUTAIN %T'
#}%

bindkey -v
zle -N zle-line-init
zle -N zle-keymap-select

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="blue"; fi
autoload -U colors && colors
precmd(){
	local preprompt_left="%{%F{238}%}%T  %{%f%}%{%F{063}%}%c%{%f%}%$(put_spacing)$(git_prompt_info)"
	#local preprompt_left='%{$fg[white]%}[%T] %{$fg[white]%}%B%c%b%{$reset_color%}$(put_spacing)$(git_prompt_info)'
	#local preprompt_left="%{%F{238}%}[%T] %{%f%}%{$fg[white]%}%B%c%b%{$reset_color%}$(put_spacing)$(git_prompt_info)"
	#local preprompt_left='\[\033[1;32m\][%T] %{$fg[white]%}%B%c%b%{$reset_color%}$(put_spacing)$(git_prompt_info)'
#    local preprompt_left="%{$fg[white]%}[%T] %{$fg[white]%}%B%c%b%{$reset_color%}"
#    local preprompt_right="$(git_prompt_info)"
#    local preprompt_left_length=${#${(S%%)preprompt_left//(\%([KF1]|)\{*\}|\%[Bbkf])}}
#    local preprompt_right_length=${#${(S%%)preprompt_right//(\%([KF1]|)\{*\}|\%[Bbkf])}}
#    local num_filler_spaces=$((COLUMNS - preprompt_left_length - preprompt_right_length + 15 ))
#    print -Pr $'\n'"$preprompt_left${(l:$num_filler_spaces:)}$preprompt_right"
	print -Pr "$preprompt_left"
}

PROMPT='%{$fg[cyan]%}%B|>%(?.:.%{$fg[magenta]%}X)%b%{$fg[cyan]%}%B<|  %b%{$reset_color%}'

#precmd() { $newline $git_prompt_info}
#PROMPT="%{$fg[blue]%}%n$newline %B[%T]%b %{$fg[blue]%}%c%{$reset_color%}$(git_prompt_info)"
#RPROMTP='$(newline)'


#COMPLETION_WAITING_DOTS="true"

#expand-or-complete-with-dots() {
    # toggle line-wrapping off and back on again
#    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
#    print -Pn "%{%F{red}......%f%}"
#    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam

#    zle expand-or-complete
#    zle -R
#}
#zle -N expand-or-complete-with-dots
#bindkey "^I" expand-or-complete-with-dots

