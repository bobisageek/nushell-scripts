export alias l = ls
export alias ll = ^ls -altr
export alias lll = ls -al
export alias c = ^clear
export alias e = ^$env.EDITOR
export alias bbr = ^rlwrap bb

export def --env mkcd [path] { mkdir $path; cd $path }
export def --env "up" [count: int = 1] {
  cd (1..$count | each { '..' } | path join)
}

export def --env cd_fzf [base_dir: string = '.', fd_opts: list<string> = []] {
  let fzf_opts = ["--preview" $"fd -I --strip-cwd-prefix --base-directory ($base_dir)/{}"]
  let dest = do -i { ^fd -I --strip-cwd-prefix --type directory --type symlink --base-directory $base_dir ...$fd_opts | fzf ...$fzf_opts }
  cd ($base_dir | path join $dest)
}

export def hist_fzf [] {
  let input = (commandline)
  let fzf_cmd = ["fzf" "--scheme=history" $"--query=($input)"]
  let cmd_line = history | get command | reverse | uniq | to text | run-external $fzf_cmd
  commandline edit -r $cmd_line
}
