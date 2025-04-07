const bookmarkPath = $nu.data-dir | path join 'bookmarks'
const record_sep = "\u{1D}"
export-env {
 $env.BOOKMARKS_FILE = $bookmarkPath | path join 'bookmarks.nuon'
}

def bm_list [] {
  mkdir $bookmarkPath
  touch $env.BOOKMARKS_FILE
  open $env.BOOKMARKS_FILE | collect
}

def "to lines" [] {
  match $in {
    null => null
    _    => { $in | each { $'($in.desc)($record_sep)($in.path)'} | str join "\n" }
  }
}

export def bookmark [] { bookmark add }

export def "bookmark list" [] {
  bm_list
}

export def "bookmark add" [path?: string, description?: string] {
  let path = $path | default $env.PWD | path expand
  let description = if $description != null {
    $description
  } else {
    input -d ($env.PWD | path basename) 'Description for this path...? '
  }
  bm_list |
    append {path: $path, desc: $description } |
    reverse |
    uniq-by path |
    where { $in.path | is-not-empty } |
    save $env.BOOKMARKS_FILE --force
}

def multi_sel [] {
  $in | to lines | ^fzf -m -0 --delimiter $record_sep --with-nth '{1} ({2})' --accept-nth 2
}

def single_sel [query: string] {
  $in | to lines | ^fzf -1 --delimiter $record_sep --with-nth '{1} ({2})' --accept-nth 2 -q $query
}

export def "bookmark delete" [...descs: string] {
  let descs = if ($descs | is-not-empty) {
    $descs | path expand
  } else {
    bm_list | multi_sel | lines
  }
  bm_list | where path not-in $descs | save $env.BOOKMARKS_FILE --force
}

export def --env "bookmark go" [...queries: string] {
  let target = bm_list | single_sel ($queries | str join ' ')
  if $target != null {
    cd $target
  }
}

export const BOOKMARK_GO_KEYBIND = {
  name: bookmark_selector
  modifier: control
  keycode: char_g
  mode: emacs
  event: {
    send: executehostcommand
    cmd: 'bookmark go'
  }
}
