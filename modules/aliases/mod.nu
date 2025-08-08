export alias l = ls
export alias ll = ls -al
export alias lll = ^ls -al
export alias c = ^clear
export alias e = ^nvim
export def --env mkcd [path] { mkdir $path; cd $path }
export alias gca = ^git commit -a
export alias gcb = ^git checkout -b
export alias gco = ^git checkout
export alias gst = ^git status
export alias gdh = ^git diff HEAD

export def gbf  [] {
  git branch --format='%(refname:short)' | fzf | gco $in
}

export def gcp [] {
  gca; git push
}

export def --env "up" [count: int] {
  cd (1..$count | each { '..' } | path join)
}
