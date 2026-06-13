export def ztab [] {
  zellij action list-tabs -j | from json | get name | to text | fzf | zellij action go-to-tab-name $in
}

export def zel_label_tab [] {
  zellij action rename-tab ($env.PWD | path basename)
}
