# class to create users
# with ssh key (optional)

class user {

}

define user::create($password, $sshkeytype, $sshkey) {
  
  user {$title:
    ensure     => present,
    #groups     => ['sudo'],
    home       => "/home/$title",
    managehome => true,
    password   => $password,
    shell      => '/bin/bash',
  }

  file {"/home/$title":
    ensure  => directory,
    owner   => $title,
    group   => 'root',
    mode    => 775,
    require => User[$title],
  }

  file {"/home/$title/.ssh":
    ensure  => directory,
    owner   => $title,
    group   => $title,
    mode    => 0770,
    require => File["/home/$title"],
  }

  if ($sshkey != ''){
    ssh_authorized_key {$title:
      ensure => present,
      name   => $title,
      user   => $title,
      type   => $sshkeytype,
      key    => $sshkey,
    }
  }
}