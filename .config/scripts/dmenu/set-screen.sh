#!/usr/bin/sh

# Load config
source $HOME/.config/scripts/dmenu/config.sh

DMENU_PROMPT='Where are you at?'

alias DMENU_LAUNCH=" \
    dmenu -fn '$DMENU_FONT' \
    -i -l 20 \
    -p '$DMENU_PROMPT' \
    -sb '$DMENU_BG_SELECTED' -sf '$DMENU_FG_SELECTED' \
    -nb '$DMENU_BG_NORMAL' -nf '$DMENU_FG_NORMAL'
"

declare -a choices=(
    "Kantor Magang - $HOME/.config/arandr/kantor-magang.sh"

    "quit"
)

# Pipe the choices array to dmenu
choice=$(printf '%s\n' "${choices[@]}" | DMENU_LAUNCH)


# check if user selects quit
if [[ "$choice" == "quit" ]]; then
    exit 1

elif [ "$choice" ]; then
    screen_config=$(printf '%s\n' "${choice}" | awk '{print $NF}')
    
    # launch the editor
    $screen_config

    notify-send "[MONITOR] Screen settings changed by xrandr."

# or maybe if the user pressed ESC (same as quit)
else
    exit 1
fi
