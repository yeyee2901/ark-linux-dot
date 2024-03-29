#!/usr/bin/env sh

# Load config
source $HOME/.config/scripts/dmenu/config.sh

DMENU_PROMPT='Quick Launch:'

alias DMENU_LAUNCH=" \
    dmenu -fn '$DMENU_FONT' \
    -i -l 20 \
    -p '$DMENU_PROMPT' \
    -sb '$DMENU_BG_SELECTED' -sf '$DMENU_FG_SELECTED' \
    -nb '$DMENU_BG_NORMAL' -nf '$DMENU_FG_NORMAL'
"

declare -a choices=(
    "Kitty - Kerjaan"
    "WPS - Writer"
    "WPS - Spreadsheet"
    "WPS - Powerpoint"
    "WPS - PDF"
)

# Pipe the choices array to dmenu
choice=$(printf '%s\n' "${choices[@]}" | DMENU_LAUNCH)


# check if user selects quit
if [[ "$choice" == "quit" ]]; then
    exit 1

elif [[ "$choice" ]]; then
    case $choice in
        Kitty*)
            case $choice in
                *Kerjaan)
                    kitty --session $HOME/.config/kitty/sessions/kerjaan-session.conf ;;
            esac ;;

        WPS*)
            case $choice in
                *Writer)
                    wps ;;
                *Spreadsheet)
                    et ;;
                *Powerpoint)
                    wpp ;;
                *PDF)
                    wpspdf ;;
            esac

    esac
# or maybe if the user pressed ESC (same as quit)
else
    exit 1
fi
