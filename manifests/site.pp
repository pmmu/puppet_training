
## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Define filebucket 'main':
filebucket { 'main':
  server => 'learn.localdomain',
  path   => false,
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }

  include setup
  include git
  include pythonvenv
  include ssh
  include user
  #include nginx

  user::create {'jenkins':
    password   => '$1$963viJj/$VUiSdG/Sjsj4bsQD1uXTX0',
    sshkeytype => 'ssh-rsa',
    sshkey     => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA09Erk4PaCNG7DUmJvvkjn9TojRJ/00nixSy4WEw0E1x2kx2KERvj9EPVuWg0vXmEhgCKqp2ikV6N9tJmfaKDUqfO7iO/QyoOMInB4l4t9CL+Ji2nDKLeoUWveX6EV+YF/f6nPKtPYErzP+JpQngoYURaabrLs5VZqWN1NvbhlGrfExtF+aXGpM4RPmaRD8IEKYbiWFb9uap3WrQXDJksYYcNRgluiuSgwFBNmzdyfunItRI4BI4PaNlHUXtUF8eLcMopxZaNb/1rUMjGPYFXV2D9153q4V/qKpXRL9zPMAeFe8I0DN3e3BJM5Mo255HlwztBT4sbZk5afRsNYtWELw=='
  }

  file {'/usr/local/app':
    ensure  => directory,
    owner   => jenkins,
    group   => root,
    mode    => 775,
    require => User['jenkins'],
  }

  #clone git code into the server
  git::clone {'djangoCI':
    repo    => 'https://github.com/pmmu/djangoCI.git',
    path    => '/usr/local/app',
    dir     => 'django',
  }

  #set up folder as a virtual environment
  pythonvenv::environment {'ve':
    path => '/usr/local/app',
    user => 'jenkins',
  }

  #setup a config file for the django website in nginx confs
  #nginx::siteconfig{'django':
  #  source => 'puppet:///files/configs/django-nginx.conf',
  #}
}
