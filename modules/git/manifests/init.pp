# Class: git
#
# This class installs git
#
# Actions:
#   - Install the git package
#
class git ($package_name = 'git') {
  package { $package_name:
    ensure => installed,
  }
}
