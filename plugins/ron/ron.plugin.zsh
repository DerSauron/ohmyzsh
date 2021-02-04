# ron's plugin

# some helper
if [ -e /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -e /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# ubuntu command not found
if [ -x /usr/lib/command-not-found ]; then
    function command_not_found_handler() {
        if [ -x /usr/lib/command-not-found ]; then
            /usr/lib/command-not-found -- "$1"
            return $?
        else
            printf "%s: command not found\n" "$1" >&2
            return 127
        fi
    }
fi

# editor
export EDITOR=nano
export VISUAL=nano

# colors
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
alias grep='grep --color=always'

# pager
export SYSTEMD_PAGER=

# make
export MAKEFLAGS="-j$(nproc)"

# GTK config
export GTK_OVERLAY_SCROLLING=0

# QT config
export QT_LOGGING_RULES="*.debug=false;va.*=true"

# path
path=(~/bin $path)
export PATH

# macros
function cgrep() {
    [ "$1" == "" ] && exit 1
    find \( -name "*.cc" -o -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.hpp" -o -name "*.hxx" \) \
        -type f -exec grep "$@" {} +
}
