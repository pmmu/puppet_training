define pythonvenv::environment ($path) {
  exec {"create-ve-$path":
    command => "/usr/bin/virtualenv -q $name",
    cwd     => $path,
    creates => "$path/$name",
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

