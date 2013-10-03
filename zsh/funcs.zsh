# diff time machine
#
# Usage exemple:
#     $ prediff myfile
#     $ $EDITOR myfile # edit the file
#     $ postdiff myfile # generate a diff from prediff
#
function prediff() {
    if [[ $# != 1 ]]; then
        echo "prediff, make a copy in a temporary directory.\nusage: prediff <filename>\nRun postdiff to make a diff."
    else
        name="$(basename "$1")"
        mkdir -p "/tmp/difftm"
        cp "$1" "/tmp/difftm/$name"
    fi
}
function postdiff() {
    if [[ $# < 1 ]]; then
        echo "postdiff, diff a file previously copied with prediff.\nusage: postdiff <filename> [diff_options]"
    else
        name="$(basename "$1")"
        filepath="$1"
        shift
        diff "$@" "/tmp/difftm/$name" "$filepath"
    fi
}

function hi2odt() {
    if [ $# -lt 2 ]; then
        echo 'usage: hi2odt src dest [extra_options]'
        return
    fi
    param1=$1
    param2=$2
    shift 2
    highlight -O odt --config-file ~c/highlight/themes/brightvariant.theme "$@" -- "$param1" | sed 's/Standard/code/g;s/FreeMono/Inconsolata/g' | ifne sponge "$param2"
}

# hex to dec
function todec() {
    printf "$(for i in "$@"; do print -n '%d '; done)\n" $(for i in "$@"; do print -n ' 0x'$i; done)
}
# dec to hex
function tohex() {
    printf "$(for i in "$@"; do print -n '%x '; done)\n" "$@"
}

function searchjam() {
    xml sel -t -v "//track[id=\"${${1%&stream*}##*id=}\"]" ~/.mpd/jamendo.xml
}

# search a library
function findlib () {
    find /lib /usr/lib /lib64 /usr/lib32 -name "*$1*.so*"
}

# quvi
function dly () {
    if [ $# = 0 ] ; then
        quvi -f mp4_720p --exec "wget -c %u -O %t.mp4" "`xsel -o`"
    else
        quvi -f mp4_720p --exec "wget -c %u -O %t.mp4" $@
    fi
}

# conversion
function flactomp3   {
    flac -d "$1" -c | lame -b 320 - "${1%.flac}.mp3"
}

function flactoogg   {
    ffmpeg -i "$1" -acodec libvorbis -ac 2 -ab 128k "${1%.flac}.ogg"
}

accessed()           { print -l -- *(a-${1:-1}) }
changed()            { print -l -- *(c-${1:-1}) }
modified()           { print -l -- *(m-${1:-1}) }

function waitend()       { while pgrep "$1" ; do sleep "${2-5}" ; done }
function shutdownafter() { waitend "$1" 30 && sudo shutdown -h now }

function filtr()     { [ $# = 1 ] && perl -ne "print "'"$_\n"'" for $1" || perl -ne "print \"$1\" for $2" }
function replace()   { [ $# = 2 ] && perl -pe "$2" -i "$1" || echo "replace file command\nex: replace foo.bar s/foo/bar/g" }
function rantag()    { f=":$(readlink -f "$1")"; tags="$(grep -v "^.$f$" ~/.config/ranger/tagged)\n${${2:0:1}:-*}$f"; echo -n "$tags" | sort -u --key=1.3 > ~/.config/ranger/tagged }
function cssdata()   { [ $# -lt 2 ] && echo "Usage: cssdata file type\nex: cssdata foo.gif image/gif" && return 1 echo -n "url(\"data:$2;base64,"; base64 -w0 $1; echo -n "\")" }
function trash()     { mv $@ $HOME/.trash }
function jamadd()    { [ $# -lt 1 ] && url="$(xsel -o)" || url="$1"; id="${url##*/}"; mpc add "http://api.jamendo.com/get2/stream/track/redirect/?id=$id&streamencoding=mp31" }
function jamaddalbum() { [ $# -lt 1 ] && url="$(xsel -o)" || url="$1"; curl "$url" | sed 's+/track+\n/track+g'| perl -ne 'print "$_\n" for /\/track\/(\d+)/' | filter_uniq | while read i; do mpc add "http://api.jamendo.com/get2/stream/track/redirect/?id=$i&streamencoding=mp31"; done }
function jamplay()   { [ $# -lt 1 ] && url="$(xsel -o)" || url="$1"; curl "$url" | sed 's+/track+\n/track+g'| perl -ne 'print "$_\n" for /\/track\/(\d+)/' | filter_uniq | while read i; do echo "http://api.jamendo.com/get2/stream/track/redirect/?id=$i&streamencoding=mp31"; done > /tmp/jamendo-playlist; mplayer -playlist /tmp/jamendo-playlist }
function jamplayone(){ [ $# -lt 1 ] && url="$(xsel -o)" || url="$1"; echo "$url" | sed 's+/track+\n/track+g'| perl -ne 'print "$_\n" for /\/track\/(\d+)/' | filter_uniq | read i; mplayer "http://api.jamendo.com/get2/stream/track/redirect/?id=$i&streamencoding=mp31" }
function calc()      { echo $(($@)) }; alias '~'='noglob calc'
function gitvimdiff  { GIT_EXTERNAL_DIFF="git_diff_wrapper" git --no-pager diff "$@" }
function album_id    { track_id="$(mpc -f '%file%' | filtr '/id=(\d+)/')"; echo "Track id is $track_id" >&2 ; perl -lne "print for /<album><id>(\\d+)<\\/id>.*?<track><id>$track_id<\\/id>/" < .mpd/jamendo.xml >&1 }
function dl_current  { oggjam "http://www.jamendo.com/en/album/`jamlbum_id`" }
function up()        { for updirs in $(seq ${1:-1}); do cd ..; done; }
function vimpatch()  { vim "$1" +"vert diffpa $2" }
function join()      { glue=$1; shift; echo "${(ej:${glue}:)@}" }
function xvid()      { mencoder -oac mp3lame -ovc xvid -vf scale=1280:720 "$1" -o "$2" -xvidencopts bitrate=1400 }

# package-related stuff
function yql         { /usr/bin/pacman -Ql $@ | sed 's/^[^ ]\+ //;/\/$/ d' }
function grepkg() {
    (( $# < 2 )) && return
    pkg="$1"
    shift
    grep $@ `/usr/bin/pacman -Ql $pkg \
        | sed 's/^[^ ]\+ //;/\/$/ d;/\.bmp$/ d;/\.gif$/ d;/png$/ d;/tga$/ d;/so$/ d;/gz$/ d;/tgz$/ d;/zip$/ d;/class$/ d;/mo$/ d'`
}
function findpkg() {
    (( $# < 2 )) && return
    pkg="$1"
    shift
    yql $pkg | grep $@
}

function mountiso() {
  if [ ! "$1" ]; then
    echo "missing iso image argument"
    return
    elif [ ! -f "$1" ]; then
    echo "$1: iso image not found"
    return
  elif [ "`mount | grep /mnt/iso`" ]; then
    echo "/mnt/iso is already in use"
    return
  fi
  sudo mount -t iso9660 -o loop,ro "$1" /mnt/iso
}

function cl()       { cd "$1" && ls }

# mkdir, then cd
function md()       { mkdir -p "$@" && cd "$@" }
