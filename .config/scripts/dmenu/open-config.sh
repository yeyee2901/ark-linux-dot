#!/usr/bin/env sh

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
    "Kitty - $HOME/DATA-SDA4/yeyee/.config/kitty/kitty.conf"
    "Neovim - $HOME/.config/nvim"
    "Vim - $HOME/.vimrc"
    "DWM - $HOME/.config/dwm/config.def.h"
    "Suckless Status - $HOME/.config/slstatus/config.def.h"
    "SXHKD - $HOME/.config/sxhkd/sxhkdrc"
    "Dunst - $HOME/.config/dunst/dunstrc"

    "XInit - $HOME/.xinitrc"
    "ZSH - $HOME/.zshrc"
    "ZProfile - $HOME/.zprofile"

    "Environment Vars - $HOME/.alias_envs"
    "Dmenu Scripts - $HOME/.config/scripts/dmenu"

    "Screen - $HOME/.config/scripts/dmenu/set-screen.sh"

    "quit"
)

# Pipe the choices array to dmenu
choice=$(printf '%s\n' "${choices[@]}" | DMENU_LAUNCH)


# check if user selects quit
if [[ "$choice" == "quit" ]]; then
    exit 1

elif [[ "$choice" ]]; then
    if [[ "$choice" == *"Screen"* ]]; then
        config=$(printf '%s\n' "${choice}" | awk '{print $NF}')
        $config

    else
        config=$(printf '%s\n' "${choice}" | awk '{print $NF}')
        $TEXT_EDITOR "$config"

    fi

# or maybe if the user pressed ESC (same as quit)
else
    exit 1
fi
