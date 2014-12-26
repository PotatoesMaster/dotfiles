#!/bin/bash

feh --bg-scale ~/.slim/background.jpg # display background image
( rm -rf ~/.trash; mkdir ~/.trash ) & # empty trash

# group can't write and others can nothing
umask 027

export I3_COLOR=9afe2e

export AWT_TOOLKIT=XToolkit # Use XToolkit in java applications
export _JAVA_OPTIONS=-Dawt.useSystemAAFontSettings=on # fix ugly fonts in java applications
export GTK2_RC_FILES="$HOME/.gtkrc-2.0" # needed by qt to use gtk look'n feel
export MOZ_DISABLE_PANGO=1
export GTK_IM_MODULE=xim # X input methods (e.g. XCompose) in more applications
export TERMINAL='urxvt -e'
export TERMCMD=urxvt
export GOPATH="$HOME/sources/go"

export PATH=~/.bin:~/.scripts:"$PATH"

xset +fp /usr/share/fonts/local # add directory to X font path
xsetroot -cursor_name left_ptr # arrow cursor on root window

# custom keyboard mapping
xkbcomp -w 0 -R/usr/share/X11/xkb/ ~/.kbd-layout/custom-azerty.xkb $DISPLAY

# turn off the screen after a while
xset +dpms
xset dpms 0 0 180

# lock numpad
numlockx &

# drive automounting
devmon.init &

# freedesktop file manager interface implementation
# https://gist.github.com/PotatoesMaster/8038613
fdfmdaemon.py &

# notifications
dunst &

# For use with slim to select wm
exec "${1-i3}" &>/dev/null
