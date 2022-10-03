#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# SETUP ENVIRONMENT VARIABLES
source $HOME/.alias_envs

# SET BACKGROUND (using nitrogen restore will remember last wallpaper set)
nitrogen --restore

# START COMPOSITOR (picom)
picom &

# START STATUS BAR (Suckless Status)
slstatus &

# START NOTIFICATION DAEMON (dunst)
dunst &

# START KEYBOARD HOTKEY DAEMON (sxhkd)
# had to use this, dwm keybindings are not flexible
# enough
sxhkd &

# START SCREENSHOT UTILITY IN BACKGROUND (flameshot)
flameshot &

# START NETWORK MANAGER APPLET (nm-applet)
nm-applet &

# START BLUETOOTH MANAGER APPLET (blueman-applet``)
blueman-applet &

# START WINDOW MANAGER (DWM - Dynamic Window Manager)
exec dwm
