conky.config = {
	out_to_console = true,
	out_to_x = false,
	total_run_times = 0,
	update_interval = 1,
	if_up_strictness = 'address',
}

block {
    color = 'eab93d', -- yellow
    text  = '${cpu cpu0}% ${freq_g} GHz ${hwmon temp 1}° '
}

block {
    color = '587aa4', -- blue
    text  = ' eth0 - ${upspeedf eth0} ↑ ↓ ${downspeedf eth0} ',
    cond  = 'up eth0'
}

block {
    color = '89b6e2', -- cyan
    text  = ' ${wireless_essid wlan0} - ${wireless_link_qual_perc wlan0}%  ${upspeedf wlan0} ↑ ↓ ${downspeedf wlan0} ',
    cond  = 'up wlan0'
}

block {
    color = '93d44f', -- green
    text  = ' ${if_match "${mpd_status}"=="Paused"}\\"${else}►$endif ${mpd_title 50}${if_match "${mpd_album}"!=""} - ${mpd_album 50}${endif}${if_match "${mpd_artist}"!=""} - ${mpd_artist 50}$endif [$mpd_elapsed / $mpd_length] ',
    cond  = 'match "${mpd_status}"!="MPD not responding"'
}

block {
    color = 'f6a24f', -- orange
    text  = ' ${if_mixer_mute}┄${else}~$mixer%$endif '
}

block {
    color = 'ff6565', -- red
    text  = ' ${if_match "${acpiacadapter AC0}"=="on-line"}ac${else}bat${endif} '
}

block {
    color = 'ffffff', -- white
    text  = ' ${time %a%d/%m %R}'
}
