# Install config files
# ====================

# WARNING: running it can overwrite your config files.

# Path of the makefile
MKPATH="$(shell pwd)/"

XDG_CONFIG_DIR=~/.config/

all: i3_ mplayer_ ncmpcpp_ pentadactyl_ gdb_ git_ nano_ rtorrent_ vim_ zsh_ misc feh_ highlight_ newsbeuter_ ranger_

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

vim_:
	ln -sf {$(MKPATH)vim/,~/.}vimrc
	mkdir -p ~/.vim/after
	ln -sf {$(MKPATH),~/.}vim/after/css.vim
	mkdir -p ~/.vim/colors
	ln -sf {$(MKPATH),~/.}vim/colors/harold.vim
	mkdir -p ~/.vim/ftdetect
	ln -sf {$(MKPATH),~/.}vim/ftdetect/django.vim
	ln -sf {$(MKPATH),~/.}vim/ftdetect/luakit.vim
	ln -sf {$(MKPATH),~/.}vim/ftdetect/plantuml.vim
	ln -sf {$(MKPATH),~/.}vim/ftdetect/txt2tags.vim
	ln -sf {$(MKPATH),~/.}vim/ftdetect/xkb.vim
	mkdir -p ~/.vim/ftplugin
	ln -sf {$(MKPATH),~/.}vim/ftplugin/luakit.vim
	ln -sf {$(MKPATH),~/.}vim/ftplugin/txt2tags.vim
	mkdir -p ~/.vim/indent
	ln -sf {$(MKPATH),~/.}vim/indent/luakit.vim
	mkdir -p ~/.vim/plugin
	ln -sf {$(MKPATH),~/.}vim/plugin/vim_movelines.vim
	mkdir -p ~/.vim/syntax
	ln -sf {$(MKPATH),~/.}vim/syntax/luakit.vim
	ln -sf {$(MKPATH),~/.}vim/syntax/plantuml.vim
	ln -sf {$(MKPATH),~/.}vim/syntax/ranger.vim
	ln -sf {$(MKPATH),~/.}vim/syntax/wps.vim
	ln -sf {$(MKPATH),~/.}vim/syntax/xkb.vim
	mkdir -p ~/.vim/UltiSnips
	ln -sf {$(MKPATH),~/.}vim/UltiSnips/htmldjango.snippets
	ln -sf {$(MKPATH),~/.}vim/UltiSnips/java.snippets
	ln -sf {$(MKPATH),~/.}vim/UltiSnips/txt2tags.snippets

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
