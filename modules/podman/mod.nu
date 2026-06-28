export def "podman ilines" [] {
  podman images | detect columns --guess | update REPOSITORY {|r| $'($r.REPOSITORY):($r.TAG)' } | reject TAG | rename Image
}

export def "podman psrm" [] {
  podman ps -aq | lines | each { ^podman rm $in }
}

export def "podman iclean" [] {
  podman images | detect columns --guess | where TAG == '<none>' | get 'IMAGE ID' | each { podman rmi $in }
}

export def "podman cleanup" [] {
  podman images | fzf --accept-nth=3 --with-nth=1,2,3 -m --header-lines=1 | lines | each { podman rmi $in }
}

