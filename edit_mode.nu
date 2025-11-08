const toggles = {'vi': 'emacs', 'emacs': 'vi'}

export def --env toggle_edit_mode [] {
  let new_mode = $toggles | get -o $env.config.edit_mode | default 'vi'
  print $"Setting edit mode to ($new_mode)"
  $env.config.edit_mode = $new_mode
}