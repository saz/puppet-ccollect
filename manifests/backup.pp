define ccollect::backup(
  $source_host,
  $ensure = present,
  $ssh_user = 'root',
  $source = '/',
  $exclude = undef,
  $rsync_options = '',
  $delete_incomplete = 'y',
  $pre_exec = undef,
  $post_exec = undef
) {
    $local_config_base = "${ccollect::params::config_dir}sources/${name}/"
    $local_backup_dest = "${ccollect::params::backup_dir}${name}/"

    file { $local_backup_dest:
        ensure  => directory,
        owner   => root,
        group   => root,
        require => Class['ccollect::config'],
    }

    file { $local_config_base:
        ensure  => directory,
        owner   => root,
        group   => root,
        require => Class['ccollect::config'],
    }

    file { "${local_config_base}source":
        ensure  => $ensure,
        owner   => root,
        group   => root,
        content => "${ssh_user}@${source_host}:${source}",
        require => File[$local_config_base],
    }

    file { "${local_config_base}destination":
        ensure  => $ensure,
        owner   => root,
        group   => root,
        content => $local_backup_dest,
        require => File[$local_config_base],
    }

    file { "${local_config_base}rsync_options":
        ensure  => $ensure,
        owner   => root,
        group   => root,
        require => File[$local_config_base],
    }

    file { "${local_config_base}delete_incomplete":
        ensure  => $ensure,
        owner   => root,
        group   => root,
        content => $delete_incomplete,
        require => File[$local_config_base],
    }

    $exclude_src = $exclude ? {
      ''      => 'puppet:///modules/ccollect/exclude',
      default => $exclude,
    }
    file { "${local_config_base}exclude":
        ensure  => $ensure,
        owner   => root,
        group   => root,
        source  => $exclude_src,
        require => File[$local_config_base],
    }

    if $pre_exec {
        file { "${local_config_base}pre_exec":
            ensure  => $ensure,
            owner   => root,
            group   => root,
            mode    => '0755',
            source  => $pre_exec,
            require => File[$local_config_base],
        }
    }

    if $post_exec {
        file { "${local_config_base}post_exec":
            ensure  => $ensure,
            owner   => root,
            group   => root,
            mode    => '0755',
            source  => $post_exec,
            require => File[$local_config_base],
        }
    }
}
