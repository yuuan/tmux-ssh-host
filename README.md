tmux-ssh-host
=================

This is a plugin for [TPM](https://github.com/tmux-plugins/tpm).

This plugin displays the hostname connect by ssh command.

## Usage

Add `#{ssh-host}` format string to your existing window-status-format tmux option.

ex:

```shell
set-window-option -g window-status-format '#I: #{?#{m:ssh,#W},#{ssh-host},#W} '
set-window-option -g window-status-current-format '#I: #{?#{m:ssh,#W},#{ssh-host},#W} '
```

## Install

[See](https://github.com/tmux-plugins/tpm#installation)

## LICENSE

[MIT](https://github.com/yuuan/tmux-ssh-host/blob/master/LICENSE)
