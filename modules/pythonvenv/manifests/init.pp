# Class: pythonvenv
#
# This class installs python and virtual env
#
# Actions:
#   - Install the:
#       python, 
#       python-dev, 
#       python-pip,
#       python-virtualenv 
#       and you can create a virtual environment
#
class pythonvenv {
  pythonvenv::install {"install-python":}
}

define pythonvenv::install {
  package { "python":
    ensure => present,
  }
  package {"python-virtualenv":
    ensure  => present,
    require => Package["python"],
  }
  package {"python-pip":
    ensure  => present,
    require => Package["python"],
  }
}
