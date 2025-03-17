export def --env "upsert" [keybind: record]: nothing -> nothing {
    $env.config.keybindings = ($env.config.keybindings |
    where name != $keybind.name |
    append [$keybind])
}