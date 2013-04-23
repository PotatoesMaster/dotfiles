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

export PATH=~/.bin:~/.gem/ruby/1.9.1/bin:"$PATH" # add user's .bin directory to path

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

# notifications
dunst &

# For use with slim to select wm
case "${1-i3}" in
	i3)
		exec i3 &>/dev/null
		;;
	other) # place-holder
		exec other &>/dev/null
		;;
esac
