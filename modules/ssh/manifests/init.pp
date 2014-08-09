# class ssh
#
# for installing setting up ssh
#

class ssh {
  include ssh::install
  include ssh::config
  include ssh::service
}

class ssh::install{
  package {'openssh':
    ensure => present,
  }
  package {"openssh-server":
    ensure  => present,
    require => Package['openssh'],
  }
}

class ssh::config{
  file {"/etc/ssh/sshd_config":
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => 600,
    #source => "puppet://files/configs/sshd_config",
    notify => Class["ssh::service"]
  }
}

class ssh::service{
  service {'sshd':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}


Class["ssh::install"] -> Class["ssh::config"] -> Class["ssh::service"]
