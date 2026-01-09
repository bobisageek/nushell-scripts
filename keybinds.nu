use keybinds *

keybind upsert {
  name: bookmark_selector
  modifier: control
  keycode: char_g
  mode: [emacs, vi_insert, vi_normal]
  event: {
    send: executehostcommand
    cmd: 'bookmark go'
  }
}

keybind upsert {
  name: bookmark_go_and_edit
  modifier: control
  keycode: char_e
  mode: [emacs, vi_insert, vi_normal]
  event: {
    send: executehostcommand
    cmd: 'bookmark go; e'
  }
}

keybind upsert {
  name: refresh_config
  modifier: control_alt
  keycode: char_r
  mode: [emacs, vi_insert, vi_normal]
  event: {
    send: executehostcommand
    cmd: 'exec nu'
  }
}

keybind upsert {
  name: go_home
  modifier: control
  keycode: char_h
  mode: [emacs, vi_insert, vi_normal]
  event: {
    send: executehostcommand
    cmd: 'cd'
  }
}

keybind upsert {
  name: toggle_edit_mode
  modifier: control_alt
  keycode: char_e
  mode: [emacs, vi_insert, vi_normal]
  event: {
    send: executehostcommand
    cmd: 'toggle_edit_mode'
  }
}

keybind upsert {
  name: cd_fzf
  modifier: alt
  keycode: char_z
  mode: [emacs, vi_insert, vi_normal]
  event: {
    send: executehostcommand
    cmd: 'cd_fzf'
  }
}

keybind upsert {
  name: cd_fzf_and_edit
  modifier: alt_shift
  keycode: char_z
  mode: [emacs, vi_insert, vi_normal]
  event: {
    send: executehostcommand
    cmd: 'cd_fzf; e'
  }
}


keybind upsert {
  name: hist_fzf
    modifier: control
    keycode: char_r
    mode: [emacs, vi_insert, vi_normal]
    event: {
    send: executehostcommand
    cmd: 'hist_fzf'
  }
}

