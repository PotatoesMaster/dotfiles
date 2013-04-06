# Install config files
# ====================

# WARNING: running it can overwrite your config files.

# Path of the makefile
MKPATH="$(shell pwd)"

XDG_CONFIG_DIR=~/.config

all: i3_ mplayer_ ncmpcpp_ pentadactyl_ gdb_ git_ nano_ rtorrent_ vim_ zsh_ misc feh_ highlight_ newsbeuter_ ranger_

i3_:
	mkdir -p ~/.i3
	chmod u+x i3/barscript
	ln -sf $(MKPATH)/i3/barscript                       ~/.i3/barscript
	ln -sf $(MKPATH)/i3/config                          ~/.i3/config
	ln -sf $(MKPATH)/i3/conky.conf                      ~/.i3/conky.conf

mplayer_:
	mkdir -p ~/.mplayer
	ln -sf $(MKPATH)/mplayer/config                     ~/.mplayer/config
	ln -sf $(MKPATH)/mplayer/input.conf                 ~/.mplayer/input.conf

ncmpcpp_:
	mkdir -p ~/.ncmpcpp
	ln -sf $(MKPATH)/ncmpcpp/config                     ~/.ncmpcpp/config
	ln -sf $(MKPATH)/ncmpcpp/keys                       ~/.ncmpcpp/keys

pentadactyl_:
	ln -sf $(MKPATH)/pentadactyl/pentadactylrc          ~/.pentadactylrc
	mkdir -p ~/.pentadactyl/colors
	ln -sf $(MKPATH)/pentadactyl/colors/molokai.penta   ~/.pentadactyl/colors/molokai.penta

gdb_:
	ln -sf $(MKPATH)/gdb/gdbinit                        ~/.gdbinit

git_:
	ln -sf $(MKPATH)/git/gitconfig                      ~/.gitconfig
	ln -sf $(MKPATH)/git/gitk                           ~/.gitk

nano_:
	ln -sf $(MKPATH)/nano/nanorc                        ~/.nanorc

rtorrent_:
	ln -sf $(MKPATH)/rtorrent/rtorrent.rc               ~/.rtorrent.rc

vim_:
	ln -sf $(MKPATH)/vim/vimrc                          ~/.vimrc
	mkdir -p ~/.vim/after
	ln -sf $(MKPATH)/vim/after/css.vim                  ~/.vim/after/css.vim
	mkdir -p ~/.vim/colors
	ln -sf $(MKPATH)/vim/colors/harold.vim              ~/.vim/colors/harold.vim
	mkdir -p ~/.vim/ftdetect
	ln -sf $(MKPATH)/vim/ftdetect/django.vim            ~/.vim/ftdetect/django.vim
	ln -sf $(MKPATH)/vim/ftdetect/luakit.vim            ~/.vim/ftdetect/luakit.vim
	ln -sf $(MKPATH)/vim/ftdetect/plantuml.vim          ~/.vim/ftdetect/plantuml.vim
	ln -sf $(MKPATH)/vim/ftdetect/txt2tags.vim          ~/.vim/ftdetect/txt2tags.vim
	ln -sf $(MKPATH)/vim/ftdetect/xkb.vim               ~/.vim/ftdetect/xkb.vim
	mkdir -p ~/.vim/ftplugin
	ln -sf $(MKPATH)/vim/ftplugin/luakit.vim            ~/.vim/ftplugin/luakit.vim
	ln -sf $(MKPATH)/vim/ftplugin/txt2tags.vim          ~/.vim/ftplugin/txt2tags.vim
	mkdir -p ~/.vim/indent
	ln -sf $(MKPATH)/vim/indent/luakit.vim              ~/.vim/indent/luakit.vim
	mkdir -p ~/.vim/plugin
	ln -sf $(MKPATH)/vim/plugin/vim_movelines.vim       ~/.vim/plugin/vim_movelines.vim
	mkdir -p ~/.vim/syntax
	ln -sf $(MKPATH)/vim/syntax/luakit.vim              ~/.vim/syntax/luakit.vim
	ln -sf $(MKPATH)/vim/syntax/plantuml.vim            ~/.vim/syntax/plantuml.vim
	ln -sf $(MKPATH)/vim/syntax/ranger.vim              ~/.vim/syntax/ranger.vim
	ln -sf $(MKPATH)/vim/syntax/wps.vim                 ~/.vim/syntax/wps.vim
	ln -sf $(MKPATH)/vim/syntax/xkb.vim                 ~/.vim/syntax/xkb.vim
	mkdir -p ~/.vim/UltiSnips
	ln -sf $(MKPATH)/vim/UltiSnips/htmldjango.snippets  ~/.vim/UltiSnips/htmldjango.snippets
	ln -sf $(MKPATH)/vim/UltiSnips/java.snippets        ~/.vim/UltiSnips/java.snippets
	ln -sf $(MKPATH)/vim/UltiSnips/txt2tags.snippets    ~/.vim/UltiSnips/txt2tags.snippets

zsh_:
	ln -sf $(MKPATH)/zsh/zshrc                          ~/.zshrc
	mkdir -p ~/.zsh
	ln -sf $(MKPATH)/zsh/git-flow-completion.zsh        ~/.zsh/git-flow-completion.zsh
	mkdir -p ~/.zsh/completion
	ln -sf $(MKPATH)/zsh/completion/_haml               ~/.zsh/completion/_haml
	ln -sf $(MKPATH)/zsh/completion/_mv                 ~/.zsh/completion/_mv
	ln -sf $(MKPATH)/zsh/completion/_rdoc               ~/.zsh/completion/_rdoc

misc:
	ln -sf $(MKPATH)/mime.types                         ~/.mime.types
	ln -sf $(MKPATH)/XCompose                           ~/.XCompose
	ln -sf $(MKPATH)/XDefaults                          ~/.XDefaults
	chmod u+x xinitrc
	ln -sf $(MKPATH)/xinitrc                            ~/.xinitrc

# Files located in XDG_CONFIG_DIR follow.

feh_:
	mkdir -p $(XDG_CONFIG_DIR)/feh
	ln -sf $(MKPATH)/feh/keys                           $(XDG_CONFIG_DIR)/feh/keys
	ln -sf $(MKPATH)/feh/themes                         $(XDG_CONFIG_DIR)/feh/themes

highlight_:
	mkdir -p $(XDG_CONFIG_DIR)/highlight/langDefs
	ln -sf $(MKPATH)/highlight/langDefs/mediainfo.lang  $(XDG_CONFIG_DIR)/highlight/langDefs/mediainfo.lang

newsbeuter_:
	mkdir -p $(XDG_CONFIG_DIR)/newsbeuter
	ln -sf $(MKPATH)/newsbeuter/config                  $(XDG_CONFIG_DIR)/newsbeuter/config

ranger_:
	mkdir -p $(XDG_CONFIG_DIR)/ranger
	ln -sf $(MKPATH)/ranger/commands.py                 $(XDG_CONFIG_DIR)/ranger/commands.py
	ln -sf $(MKPATH)/ranger/rc.conf                     $(XDG_CONFIG_DIR)/ranger/rc.conf
	ln -sf $(MKPATH)/ranger/rifle.conf                  $(XDG_CONFIG_DIR)/ranger/rifle.conf
	ln -sf $(MKPATH)/ranger/scope.sh                    $(XDG_CONFIG_DIR)/ranger/scope.sh
	mkdir -p $(XDG_CONFIG_DIR)/ranger/colorschemes
	ln -sf $(MKPATH)/ranger/colorschemes/greeny.py      $(XDG_CONFIG_DIR)/ranger/colorschemes/greeny.py
	mkdir -p $(XDG_CONFIG_DIR)/ranger/plugins
	ln -sf $(MKPATH)/ranger/plugins/extra_archives.py   $(XDG_CONFIG_DIR)/ranger/plugins/extra_archives.py
	ln -sf $(MKPATH)/ranger/plugins/vcs_symbols.py      $(XDG_CONFIG_DIR)/ranger/plugins/vcs_symbols.py
	ln -sf $(MKPATH)/ranger/plugins/w3mimgdisplay_options.py  $(XDG_CONFIG_DIR)/ranger/plugins/w3mimgdisplay_options.py
