class ccollect::params {
  case $ccollect::backup_dir {
    '': { $backup_dir = '/var/lib/backups/' }
    default: { $backup_dir = $ccollect::backup_dir }
  }

  case $::osfamily {
    'Debian': {
      $package_name = 'ccollect'
      $config_dir = '/etc/ccollect/'
    }
    default: {
      fail("Unsupported platform: ${::osfamily}")
    }
  }
}
