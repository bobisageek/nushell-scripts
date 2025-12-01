export alias l = ls
export alias ll = ls -al
export alias lll = ^ls -al
export alias c = ^clear
export alias e = ^$env.EDITOR
export def --env mkcd [path] { mkdir $path; cd $path }
export alias gca = ^git commit -a
export alias gcb = ^git checkout -b
export alias gco = ^git checkout
export alias gst = ^git status
export alias gdh = ^git diff HEAD
export alias gb = ^git branch
export alias gbl = ^git branch --format='%(refname:short)'
export alias bbr = ^rlwrap bb

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

export def --env "up" [count: int = 1] {
  cd (1..$count | each { '..' } | path join)
}
