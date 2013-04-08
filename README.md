Looking for tricky stuff?
=========================

Here are some pointers to the parts of my config which might be of interest.

*Note*: most of my configuration files are made of copypasta from various
places. The remaining ones were produced either by tweaking default config
files or after documentation.

newsbeuter
----------

I use highlighting rules to have sort of separators in the feed list.
[Here are the highlight rules used][news_rules] and
[here is a pseudo-url acting as a separator][news_url].
Spaces in separators will cause troubles, replace them with non-breaking
spaces.

![newsbeuter screen capture][news_screen]

ranger
------

### Custom commands

TODO

### scope.sh

`scope.sh` is a script ranger use for its file preview.

Differences between my version and ranger's default one:
 * uses `bash`
 * prints file informations using `mediainfo` by default (if file type based preview is not possible)
 * displays info for pdf files (using Poppler's `pdfinfo`) instead of text
 * displays info for gbs files (GameBoy sound files) using [gbsplay]'s `gbsinfo`
 * the output of mediainfo, pdfinfo and gbsinfo is coloured using `highlight` (with a [language definition file][highlight_langdef] passed to `highlight` on its [command line parameters][highlight_invocation])

![ranger screen capture][ranger_screen]

GDB
---

Not much to see here.
Just a [custom prompt with colours][gdb_prompt].

[gdb_prompt]: gdb/gdbinit#L2
[news_rules]: newsbeuter/config#L34
[news_url]: newsbeuter/urls#L2
[highlight_langdef]: highlight/langDefs/mediainfo.lang
[highlight_invocation]: ranger/scope.sh#L23

[news_screen]: _readme_pics_/newsbeuter.png
[ranger_screen]: _readme_pics_/ranger_pdfinfo.png

[gbsplay]: http://gbsplay.berlios.de/
