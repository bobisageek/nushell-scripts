# insert or replace (by name) a keybind
export def --env "keybind upsert" [keybind: record]: nothing -> nothing {
  $env.config.keybindings = ($env.config.keybindings |
  where name != $keybind.name |
  append [$keybind])
}

