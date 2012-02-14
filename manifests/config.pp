class ccollect::config {
  file { $ccollect::params::config_dir:
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/ccollect/config",
    require => Class['ccollect::install'],
  }

  file { "${ccollect::params::config_dir}sources":
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Class['ccollect::install'],
  }

  file { $ccollect::params::backup_dir:
    ensure => directory,
    owner  => root,
    group  => root,
    require => Class['ccollect::install'],
  }
}
