export alias l = ls
export alias ll = ls -al
export alias lll = ^ls -al
export alias c = ^clear
export alias e = ^$env.EDITOR
export alias bbr = ^rlwrap bb

export def --env mkcd [path] { mkdir $path; cd $path }
export def --env "up" [count: int = 1] {
  cd (1..$count | each { '..' } | path join)
}
