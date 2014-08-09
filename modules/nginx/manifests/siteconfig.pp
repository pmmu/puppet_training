define nginx::siteconfig($source){
  file {"/etc/nginx/sites-enabled/$name":
    ensure  => present,
    source  => $source,
    owner   => root,
    group   => root,
    mode    => 0644,
    require => Class['nginx'],
    notify  => Class["nginx::service"],
  }
}
