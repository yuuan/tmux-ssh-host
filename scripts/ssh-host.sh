#!/usr/bin/env bash

get_ssh_arguments() {
	local parent_pid=$1
	local arguments=$({ \pgrep -flaP $parent_pid ; \ps -o command -p $parent_pid; } \
		| \xargs -I{} echo {} \
		| \awk '/ssh/' \
		| \head -n 1 \
		| \sed -E 's/^[0-9]*[[:blank:]]*ssh //' \
	)

	echo $arguments
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

arguments=$(get_ssh_arguments "$1")

if [[ -n "$arguments" ]]; then
	echo $(get_ssh_host $arguments)
fi
