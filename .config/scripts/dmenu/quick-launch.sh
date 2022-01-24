#!/usr/bin/sh

# Load config
source $HOME/.config/scripts/dmenu/config.sh

TEXT_EDITOR="kitty -e nvim"
DMENU_PROMPT='Open config file: '

alias DMENU_LAUNCH=" \
    dmenu -fn '$DMENU_FONT' \
    -i -l 20 \
    -p '$DMENU_PROMPT' \
    -sb '$DMENU_BG_SELECTED' -sf '$DMENU_FG_SELECTED' \
    -nb '$DMENU_BG_NORMAL' -nf '$DMENU_FG_NORMAL'
"

declare -a choices=(
    "Notes Wiki"
    "Whatsapp"
    "quit"
)

# Pipe the choices array to dmenu
choice=$(printf '%s\n' "${choices[@]}" | DMENU_LAUNCH)


# check if user selects quit
if [[ "$choice" == "quit" ]]; then
    exit 1

elif [[ "$choice" ]]; then
    case $choice in
        "Notes Wiki")
            nvim $HOME/Documents/notes-wiki/index.wiki ;;

        "Whatsapp")
            chromium --new-window "https://web.whatsapp.com" ;;
    esac
# or maybe if the user pressed ESC (same as quit)
else
    exit 1
fi
