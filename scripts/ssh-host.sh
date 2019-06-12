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

	while (($# > 0)); do
		case "$1" in
			-[BbcDEeFIiJLlmOopQRSWw])
				shift
				;;
			-*)
				;;
			*)
				echo "$1" && break
				;;
		esac
		shift
	done
}

arguments=$(get_ssh_arguments "$1")

if [[ -n "$arguments" ]]; then
	echo $(get_ssh_host $arguments)
fi
