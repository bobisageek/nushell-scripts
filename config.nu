# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

const NU_LIB_DIRS = $NU_LIB_DIRS ++ [($nu.default-config-dir | path join 'modules')]


###### literals in $env.config

$env.config.show_banner = 'short'
$env.config.table.index_mode = 'auto'
$env.config.use_kitty_protocol = true

###### prompt changes

$env.PROMPT_COMMAND = {||
    let dir = match (do -i { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)(ansi reset)"

    let colored_path = $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (char newline)
        '❌'
        (ansi rb)
        ($env.LAST_EXIT_CODE)
        (ansi reset)
        (char newline)
    ] | str join)
    } else { '' }

    $'($last_exit_code)🤨 ($colored_path)'
}

$env.PROMPT_INDICATOR = '> '

$env.TRANSIENT_PROMPT_COMMAND = ''
# $env.TRANSIENT_PROMPT_INDICATOR = ''

$env.PROMPT_COMMAND_RIGHT = ''

$env.TRANSIENT_PROMPT_COMMAND_RIGHT = ''

###### overlays

overlay use aliases

const ms_path = if ($nu.default-config-dir | path join 'modules' 'machine-specific' 'mod.nu' | path exists) { 'machine-specific' } else { null }

overlay use $ms_path

###### keybinds??

use keybinds

keybinds upsert {
    name: refresh_config
    modifier: control_alt
    keycode: char_r
    mode: emacs
    event: {
        send: executehostcommand
        cmd: 'source $nu.config-path; print $"(char newline)🤐"'
    }
}

keybinds upsert {
    name: go_home
    modifier: control
    keycode: char_h
    mode: emacs
    event: {
        send: executehostcommand
        cmd: 'cd'
    }
}