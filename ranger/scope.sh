#!/bin/bash

# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | success. display stdout as preview
# 1    | no preview | failure. display no preview at all
# 2    | plain text | display the plain content of the file
# 3    | fix width  | success. Don't reload when width changes
# 4    | fix height | success. Don't reload when height changes
# 5    | fix both   | success. Don't ever reload

filepath="$1" # Full path of the selected file
maxln=200     # Stop after $maxln lines.  Can be used like ls | head -n $maxln

# "success" returns the exit code of the first program in the last pipe chain
function success { test ${PIPESTATUS[0]} = 0; }

# Use sed to remove spaces so the output fits into the narrow window
# and color output using mediainfo
colormedia() {
    sed 's/ \{1,14\}:/:/;' | \
        highlight --config-file="$HOME/.config/highlight/langDefs/mediainfo.lang" -O ansi --syntax mediainfo
}

extension="${filepath##*.}"
case "$extension" in
    iso)
        exit 1;;
    # Archive extensions:
    7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
    rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip|cbz|cbr)
        s="`du \"$filepath\"`" && [ "${s%%	*}" -lt 20480 ] && atool -l "$filepath" | head -n $maxln && exit 3;;
    # jpeg
    jpg|jpeg)
        e="`exif "$filepath" --machine-readable`"
        if [ "$e" != "" ]
        then
            ( mediainfo "$filepath" | \
                    head -n -1; echo "$e" | \
                    awk 'BEGIN { print "Exif"}; { split($0,a,"\t"); printf("%- 40s : %s\n", a[1], a[2])}' ) | \
                colormedia
            success && exit 5
        fi
        ;;
    # PDF documents:
    pdf)
        s="`du \"$filepath\"`" && (echo "PDF" ; pdfinfo "$filepath") | colormedia
        success && exit 3;;
    # HTML Pages:
    htm|html|xhtml)
        width="$2"    # Width of the preview pane (number of fitting characters)
        w3m -dump "$filepath" | head -n $maxln | fmt -s -w $width
        success && exit 4
        ;;
    torrent)
        torrentinfo -f "$filepath"
        success && exit 5
        ;;
    gbs)
        ( echo "GBS file" ; gbsinfo "$filepath" ) | colormedia
        success && exit 5
        ;;
esac

mimetype=$(mimetype -b "$filepath")
case "$mimetype" in
    # Syntax highlight for text files:
    text/* | */xml)
        highlight -O ansi "$filepath" | head -n $maxln
        success && exit 5 || exit 2;;
esac

# Display information about files:
mediainfo "$filepath" | colormedia
success && exit 5

exit 1
