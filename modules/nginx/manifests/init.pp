# class nginx
# 
# installs nginx package
# and sets the config file
#
class nginx{
  include nginx::service
  nginx::install{'install-nginx':}
}

define nginx::install {
  package {'nginx':
    ensure =>present,
  }
  file {"/etc/nginx/sites-enabled":
    recurse => true,
    purge   => true,
  }
}

class nginx::service{
  service {'nginx':
    ensure  => running,
    require => Package['nginx'],
  }
}

Class['nginx'] -> Class["nginx::service"]

