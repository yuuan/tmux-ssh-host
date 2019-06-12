#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

script="#($CURRENT_DIR/scripts/ssh-host.sh #{pane_pid})"
pattern="\#{ssh-host}"

do_interpolation() {
	local string="$1"
	local interpolated="${string/$pattern/$script}"

	echo "$interpolated"
}

update_tmux_window_option() {
	local option="$1"
	local option_value="$(tmux show-window-option -gv "$option")"
	local new_option_value="$(do_interpolation "$option_value")"

	tmux set-window-option -g "$option" "$new_option_value"
}

update_tmux_window_option "window-status-format"
update_tmux_window_option "window-status-current-format"
