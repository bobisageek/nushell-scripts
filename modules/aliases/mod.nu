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

export def --env cd_fzf [] {
  let fzf_opts = ["--preview" "fd -I --strip-cwd-prefix --base-directory {}"]
  let dest = ^fd -I --strip-cwd-prefix --type directory | fzf ...$fzf_opts
  cd $dest
}

export def hist_fzf [] {
  let input = (commandline)
  let fzf_cmd = ["fzf" "--scheme=history" $"--query=($input)"]
  let cmd_line = history | get command | reverse | uniq | to text | run-external $fzf_cmd
  commandline edit -r $cmd_line
}
