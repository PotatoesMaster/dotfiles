# nice ls (colors and stuff)
alias ls='ls --classify --tabsize=0 --group-directories-first --literal --color=auto --show-control-chars --human-readable'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias lt='ls -ltr'
alias dir='ls -lSrah'
alias lad='ls -d .*(/)'              # only show dot-directories
alias lsa='ls -a .*(.)'              # only show dot-files
alias lss='ls -l *(s,S,t)'           # only files with setgid/setuid/sticky flag
alias lsl='ls -l *(@)'               # only symlinks
alias lsx='ls -l *(*)'               # only executables
alias lsw='ls -ld *(R,W,X.^ND/)'     # world-{readable,writable,executable} files
alias lsbig="ls -flh *(.OL[1,10])"   # display the biggest files
alias lsd='ls -d *(/)'               # only show directories
alias lse='ls -d *(/^F)'             # only show empty directories
alias lsnew='ls -tlh *(D.om[1,10])'  # display the newest files
alias lsold='ls -rtlh *(D.Om[1,10])' # display the oldest files
alias lssmall='ls -Srl *(.oL[1,10])' # display the smallest files

# time-saving aliases
# ===================

alias s='sudo'
alias v='vim'
alias vd='vimdiff'
alias V='sudo vim'
alias g='git'
alias rd='rmdir'
alias lkg='linkgrab'
alias ux='chmod u+x'
alias maj='yaourt -Syu --aur --devel'
alias sctl='sudo systemctl'
alias sudo='sudo nopasssudo'

# always sudo
# ===========

alias netctl='sudo netctl'
alias netctl-auto='sudo netctl-auto'

# aliases to specify default options
# ==================================

alias pandoc='pandoc --smart --normalize --reference-links'
alias wwwget='wget --trust-server-names --content-disposition'
alias texmex='latexmk -pdf -pdflatex="/usr/bin/xelatex -shell-escape" -interaction=nonstopmode'
alias mktor='mktorrent --announce="udp://tracker.openbittorrent.com:80/announce"'
alias dfc='dfc -fTw -c always | /usr/bin/grep -P "(sd[ab]|media)"'
alias ems-flasher='ems-flasher --verbose'
alias less='less -R'
alias df='df --human-readable'
alias du='du --human-readable'
alias sql='mysql -u root -proot' # for local development only, of course ;)
alias grep='grep --color=auto'
alias info='info --vi-keys'
alias hl='highlight --out-format=ansi'
alias sqlite='sqlite3 -column'

alias ranger='LESS=R$LESS ranger'

# less frequently used aliases, prefixed with colon
# =================================================

alias :newsbeuter-db-optimize='sqlite3 ~/.local/share/newsbeuter/cache.db VACUUM'
alias :restart-netctl-auto='netctl-auto stop wlan0 && netctl-auto start wlan0'
alias :restore-keyboard-layout='xkbcomp -w 0 -R/usr/share/X11/xkb/ ~/.kbd-layout/custom-azerty.xkb $DISPLAY'

# to repair stuff after some updates
alias :repair-gutenprint='sudo /usr/sbin/cups-genppdupdate'
alias :repair-alsa-retore='sudo alsactl -f /var/lib/alsa/asound.state store'

# commands difficult to remember
# ==============================

alias pacgraph="pacgraph -d '#ff3200' -t '#ff8700' -l '#d77f66' -b '#1c1c1c' --disable-palette"
alias topdf='libreoffice --invisible --convert-to pdf'
# ZSH magic: put the text in command buffer, ready to edit
alias ,mencoder="print -z 'mencoder -mc 0 -noskip -oac lavc -ovc lavc -of mpeg -mpegopts format=dvd:tsaf -vf harddup -srate 48000 -af lavcresample=48000 -lavcopts vcodec=mpeg2video:vrc_buf_size=1835:vrc_maxrate=9800:vbitrate=5000:keyint=15:vstrict=0:acodec=mp2:abitrate=192'"
alias ,record-webcam="print -z 'mencoder -mc 0 -noskip -oac lavc -ovc lavc -of mpeg -mpegopts format=dvd:tsaf -vf harddup -tv driver=v4l2:device=/dev/video0:forceaudio:adevice=/dev/dsp -srate 48000 -af lavcresample=48000 -lavcopts vcodec=mpeg2video:vrc_buf_size=1835:vrc_maxrate=9800:vbitrate=5000:keyint=15:vstrict=0:acodec=mp2:abitrate=192 tv:// -o file.mpg'"

# junk
# ====

# web-related commands
alias waspi='wget -rpkE -l 0 -nc -np -nH'
alias wsave='wget -pkE -nc -np -nH'
alias dnsreverse="nmap -oG - -sL"
alias http-headers='noglob wget --server-response -O /dev/null -q'
alias url='filtr '"'"'/((?:https?:\/\/|ftp:\/\/|news:\/\/|mailto:|file:\/\/|www\.)[\w\-\@;\/?:&=%\$_.+!*\x27(),~#]+[\w\-\@;\/?&=%\$_+!*\x27()~])/g'"' | uniq-sparse"
alias hrefs='filtr '"'"'/href="([^"]+)"/g'"'"' | filter_uniq'

# reminder
alias printer='lp'

# amnesia fix
for i in '' -justine -launcher ; do
    alias amnesia$i="export force_s3tc_enable=true;amnesia-tdd$i"
done

# erlang man fix
alias eman='MANPATH=/usr/lib/erlang/man man'

# workaround for my problem at remembering the names of image magick tools
for n in animate compare composite conjure convert display identify import mogrify montage stream; do
    alias im-$n=$n
done

alias jamendo-track='searchjam "$(mpc -f "%file%")"'
alias scope.sh='~/.config/ranger/scope.sh'
alias keysyms="awk '/^#define XK_[_a-zA-Z0-9]*/ { print substr(\$2,4) }' /usr/include/X11/keysymdef.h"
alias installed-packages-by-size='LANG=C pacman -Qi | awk '"'"'/^Name/ {pkg=$3} /Size/ {print $4$5,pkg}'"'"' | sort -n'
alias amoi='sudo chown tharek:users'
alias aroot='sudo chown root:root'
alias urge='echo "\007\c"'
alias zmv='noglob zmv'
alias uniq-sparse="awk '!x[\$0]++'"

alias misc='man ~d/man/astuces/misc.1.gz'

alias r100='mogrify -filter lanczos -resize 100x100'
function v100 () {
    convert "$1" -filter lanczos -resize 100x100 - | display
}
