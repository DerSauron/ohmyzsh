# xterm title

autoload -Uz add-zsh-hook

function xterm_title_precmd() {
    print -Pn -- '\e]0;%2~ %(!.#.$)\a'
}

function xterm_title_preexec() {
    local cmd
    if [ "$1" != "" ]; then
        cmd="${(q)1}"
    else
        cmd="${(q)2}"
    fi
    cmd=$(print -Pn "%10>...>$cmd" | tr -d "\n")
    print -Pn -- "\e]0;%1~ : ${cmd}\a"
}

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
    add-zsh-hook -Uz precmd xterm_title_precmd
    add-zsh-hook -Uz preexec xterm_title_preexec
fi
