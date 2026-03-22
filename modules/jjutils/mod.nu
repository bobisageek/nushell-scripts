# aliases for git commands

export alias jjc = ^jj commit
export alias jjs = ^jj status
export alias jjd = ^jj diff

export def "find-jj-repos"  [] {
  fd -Hg .jj | lines | path dirname
}

export def "changed-jj-repos"  [] {
  find-jj-repos | reduce --fold [] {|it, acc| $acc | append {name: $it, diff: (jj -R $it diff -s) } } | where { $in | get diff | is-not-empty }
}



