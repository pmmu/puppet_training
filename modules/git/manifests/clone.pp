define git::clone ($repo, $path, $dir){
  exec { "clone-$name-$path":
    command => "/usr/bin/git clone $repo $path/$dir",
    creates => "$path/$dir",
    require => [Class["git"], File[$path]],
  }
}
