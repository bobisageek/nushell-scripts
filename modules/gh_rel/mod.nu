const record_sep = "\u{1D}"

def make_display [] {
  insert display {|row|
    let deco = [(if $row.isLatest { "latest" } else ""),
     (if $row.isPrerelease { "pre-release" } else "")] | where ($it |is-not-empty) | str join "," | if ($in | is-not-empty) { $" \(($in))" } else ""
    $"($row.tagName) ||| ($row.name)($deco)"
  }
}
export def "ghasset" [repo: string, --not-latest(-l)] {
  let download_dir = '~/github_releases/' | path expand
  mkdir $download_dir
  cd $download_dir
  let rels = gh release list -R $repo --json 'tagName,name,isLatest,isPrerelease' | from json
  let relToUse = if ($not_latest or ($rels | where isLatest == true | length) != 1) {
    $rels | make_display | input list -d display
  } else {
    $rels | where isLatest == true | get 0
  }
  if ($relToUse == null) { return }
  # relToUse if the tag from which we need to get assets
  let assets = gh release view ($relToUse.tagName) -R $repo --json 'assets' | from json | get assets | get name
  if ($assets | is-empty) { print "No assets"; return}
  $assets | input list -m | each -f {|f| ['-p', $f]} |
    gh release download -R $repo ...$in
  print $"Files are in ($download_dir)"
}
