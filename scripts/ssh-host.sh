#!/usr/bin/env bash

get_ssh_commands() {
	local parent_pid=$1
	local ssh_commands=$({ \pgrep -flaP $parent_pid ; \ps -o command -p $parent_pid; } \
		| \xargs -I{} echo {} \
		| \awk '/ssh/' \
		| \sed -E 's/^[0-9]*[[:blank:]]*ssh //' \
	)

	echo $ssh_commands
}

get_ssh_host() {
	local ssh_command="$1"
	local longest_argument=$(echo $ssh_command \
		| awk -v RS=' ' '{print length($0), $0}' \
		| sort -nr \
		| head -n 1 \
		| cut -d' ' -f2- \
	)

	echo $longest_argument
}

ssh_command=$(get_ssh_commands "$1" | \head -n 1)

if [[ -n "$ssh_command" ]]; then
	echo $(get_ssh_host $ssh_command)
fi
