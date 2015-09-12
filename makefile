# Install config files
# ====================

# WARNING: running it can overwrite your config files.

# Path of the makefile
MKPATH="$(shell pwd)"

XDG_CONFIG_DIR=~/.config

all: i3_ mpv_ ncmpcpp_ pentadactyl_ gdb_ git_ nano_ rtorrent_ vim_ zsh_ misc feh_ highlight_ newsbeuter_ ranger_ bin_

i3_:
	mkdir -p ~/.i3
	chmod u+x i3/barscript
	ln -sf $(MKPATH)/i3/barscript                       ~/.i3/barscript
	ln -sf $(MKPATH)/i3/blocks_config.lua               ~/.i3/blocks_config.lua
	ln -sf $(MKPATH)/i3/config                          ~/.i3/config
	ln -sf $(MKPATH)/i3/conky.lua                       ~/.i3/conky.lua

mpv_:
	mkdir -p ~/.mpv
	ln -sf $(MKPATH)/mpv/config                     ~/.mpv/config
	ln -sf $(MKPATH)/mpv/input.conf                 ~/.mpv/input.conf

ncmpcpp_:
	mkdir -p ~/.ncmpcpp
	ln -sf $(MKPATH)/ncmpcpp/config                     ~/.ncmpcpp/config
	ln -sf $(MKPATH)/ncmpcpp/keys                       ~/.ncmpcpp/keys

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
	ln -sf $(MKPATH)/vim/vimrc.local                    ~/.vimrc.local
	test -d ~/.vim/bundle/vundle || git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

zsh_:
	ln -sf $(MKPATH)/zsh/zshrc                          ~/.zshrc
	mkdir -p ~/.zsh
	ln -sf $(MKPATH)/zsh/funcs.zsh                      ~/.zsh/funcs.zsh
	ln -sf $(MKPATH)/zsh/alias.zsh                      ~/.zsh/alias.zsh
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
	mkdir -p ~/.kbd-layout
	ln -sf $(MKPATH)/kbd-layout/custom-azerty.xkb       ~/.kbd-layout/custom-azerty.xkb

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
	ln -sf $(MKPATH)/ranger/plugins/plugin_date_linemode.py      $(XDG_CONFIG_DIR)/ranger/plugins/plugin_date_linemode.py
	ln -sf $(MKPATH)/ranger/plugins/plugin_ipc.py      $(XDG_CONFIG_DIR)/ranger/plugins/plugin_ipc.py
	ln -sf $(MKPATH)/ranger/plugins/extra_archives.py   $(XDG_CONFIG_DIR)/ranger/plugins/extra_archives.py
	ln -sf $(MKPATH)/ranger/plugins/plugin_play_filter.py      $(XDG_CONFIG_DIR)/ranger/plugins/plugin_play_filter.py
	ln -sf $(MKPATH)/ranger/plugins/vcs_symbols.py      $(XDG_CONFIG_DIR)/ranger/plugins/vcs_symbols.py
	ln -sf $(MKPATH)/ranger/plugins/w3mimgdisplay_options.py  $(XDG_CONFIG_DIR)/ranger/plugins/w3mimgdisplay_options.py
	ln -sf $(MKPATH)/ranger/plugins/zsh_expand.py      $(XDG_CONFIG_DIR)/ranger/plugins/zsh_expand.py

scripts_:
	ln -sf $(MKPATH)/scripts                            $(HOME)/.scripts
