# Install config files
# ====================

# WARNING: running it can overwrite your config files.

# Path of the makefile
MKPATH="$(shell pwd)/"

XDG_CONFIG_DIR=~/.config/

all: i3_ mplayer_ ncmpcpp_ pentadactyl_ gdb_ git_ nano_ rtorrent_ zsh_ misc feh_ highlight_ newsbeuter_ ranger_

i3_:
	mkdir -p ~/.i3
	chmod u+x i3/barscript
	ln -sf {$(MKPATH),~/.}i3/barscript
	ln -sf {$(MKPATH),~/.}i3/config
	ln -sf {$(MKPATH),~/.}i3/conky.conf

mplayer_:
	mkdir -p ~/.mplayer
	ln -sf {$(MKPATH),~/.}mplayer/config
	ln -sf {$(MKPATH),~/.}mplayer/input.conf

ncmpcpp_:
	mkdir -p ~/.ncmpcpp
	ln -sf {$(MKPATH),~/.}ncmpcpp/config
	ln -sf {$(MKPATH),~/.}ncmpcpp/keys

pentadactyl_:
	mkdir -p ~/.pentadactyl/colors
	ln -sf {$(MKPATH),~/.}pentadactyl/colors/molokai.penta
	mkdir -p ~/.pentadactyl/plugins
	ln -sf {$(MKPATH),~/.}pentadactyl/plugins/http-headers.js
	ln -sf {$(MKPATH)pentadactyl/,~/.}pentadactylrc

gdb_:
	ln -sf {$(MKPATH)gdb/,~/.}gdbinit

git_:
	ln -sf {$(MKPATH)git/,~/.}gitconfig
	ln -sf {$(MKPATH)git/,~/.}gitk

nano_:
	ln -sf {$(MKPATH)nano/,~/.}nanorc

rtorrent_:
	ln -sf {$(MKPATH)rtorrent/,~/.}rtorrent.rc

zsh_:
	ln -sf {$(MKPATH)zsh/,~/.}zshrc
	mkdir -p ~/.zsh
	ln -sf {$(MKPATH),~/.}zsh/git-flow-completion.zsh
	mkdir -p ~/.zsh/completion
	ln -sf {$(MKPATH),~/.}zsh/completion/_haml
	ln -sf {$(MKPATH),~/.}zsh/completion/_mv
	ln -sf {$(MKPATH),~/.}zsh/completion/_rdoc

misc:
	ln -sf {$(MKPATH),~/.}mime.types
	ln -sf {$(MKPATH),~/.}XCompose
	ln -sf {$(MKPATH),~/.}XDefaults
	chmod u+x xinitrc
	ln -sf {$(MKPATH),~/.}xinitrc

# Files located in XDG_CONFIG_DIR follow.

feh_:
	mkdir -p $(XDG_CONFIG_DIR)feh
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}feh/keys
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}feh/themes

highlight_:
	mkdir -p $(XDG_CONFIG_DIR)highlight/langDefs
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}highlight/langDefs/mediainfo.lang

newsbeuter_:
	mkdir -p $(XDG_CONFIG_DIR)newsbeuter
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}newsbeuter/config

ranger_:
	mkdir -p $(XDG_CONFIG_DIR)ranger
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}ranger/commands.py
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}ranger/rc.conf
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}ranger/rifle.conf
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}ranger/scope.sh
	mkdir -p $(XDG_CONFIG_DIR)ranger/colorschemes
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}ranger/colorschemes/greeny.py
	mkdir -p $(XDG_CONFIG_DIR)ranger/plugins
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}ranger/plugins/extra_archives.py
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}ranger/plugins/vcs_symbols.py
	ln -sf {$(MKPATH),$(XDG_CONFIG_DIR)}ranger/plugins/w3mimgdisplay_options.py
