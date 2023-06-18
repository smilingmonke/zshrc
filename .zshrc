
# Enable colors and change prompt:
autoload -U colors && colors


export EDITOR=nvim
export VISUAL=nvim

alias vim=nvim
alias l='ls -lah'
alias v='nvim'
alias zrc="$EDITOR $HOME/.zshrc"
alias dim="sudo brightnessctl s 5%"
alias udim="sudo brightnessctl s 100%"
alias p="sudo pacman"


# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


bindkey -v
export KEYTIMEOUT=1

autoload -z edit-commmand-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

PROMPT="%F{green}[%n@%m] %~ %f<+> "
RPROMPT="%* %? %h"


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
