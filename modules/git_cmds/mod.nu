# aliases for git commands

export alias gca = ^git commit -a
export alias gcb = ^git checkout -b
export alias gco = ^git checkout
export alias gst = ^git status
export alias gdh = ^git diff HEAD
export alias gb = ^git branch
export alias gbl = ^git branch --format='%(refname:short)'

export def gbf  [] {
  gbl | do -c { fzf } | gco $in
}

export def "g cleanup" [] {
  gbl | do -c { fzf -m } | lines | each { ^git branch -D $in }
}

export def gcp [] {
  gca; git push
}

export def "g finish" [] {
    let cb = (git branch --show-current); git checkout main; git pull; git branch -d $cb
}

