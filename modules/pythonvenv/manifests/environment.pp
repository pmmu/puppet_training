define pythonvenv::environment ($path, $user) {
  exec {"create-ve-$path":
    command => "/usr/bin/virtualenv -q $name",
    cwd     => $path,
    creates => "$path/$name",
  }
  exec {"update-ve-permissions-$path":
    command => "/bin/chown -R $user $path/$name",
    cwd     => $path,
    require => Exec["create-ve-$path"],
  }
}
  # install pip on the virtual machine
  # package {"python-pip":
  #   ensure  => present,
  #   require => Package["python"],
  # }
  # install django on virtual machine
  # exec { "install-django":
  #  command => "/usr/bin/pip install Django",
  #  require => Package["python-pip"],
  #}

