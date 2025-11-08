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

const NU_LIB_DIRS = $NU_LIB_DIRS ++ [($nu.default-config-dir | path join 'modules')]


###### literals in $env.config

$env.config.show_banner = 'short'
$env.config.table.index_mode = 'auto'
$env.config.use_kitty_protocol = true
$env.config.completions.algorithm = 'fuzzy'
$env.config.history.file_format = 'sqlite'
$env.config.shell_integration.osc133 = true

###### a couple of early env vars

$env.FZF_DEFAULT_OPTS_FILE = $nu.home-path | path join '.config/fzf/fzfrc'
$env.EDITOR = 'nvim'

const carapace_file = if ($"($nu.cache-dir)/carapace.nu" | path exists) { $"($nu.cache-dir)/carapace.nu" } else { null }
source-env $carapace_file

###### add dirs to path
source add_path.nu

source-env $"($nu.default-config-dir)/prompt.nu"

###### overlays

overlay use aliases

const ms_path = if ($nu.default-config-dir | path join 'modules' 'machine-specific' 'mod.nu' | path exists) { 'machine-specific' } else { null }

overlay use $ms_path

overlay use bookmarks

###### keybinds??

use keybinds *

keybind upsert $BOOKMARK_GO_KEYBIND

keybind upsert {
    name: refresh_config
    modifier: control_alt
    keycode: char_r
    mode: emacs
    event: {
        send: executehostcommand
        cmd: 'exec nu'
    }
}

keybind upsert {
    name: go_home
    modifier: control
    keycode: char_h
    mode: emacs
    event: {
        send: executehostcommand
        cmd: 'cd'
    }
}
#### cleanup path
$env.PATH = $env.PATH | uniq

