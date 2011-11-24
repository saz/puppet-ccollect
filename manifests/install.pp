class ccollect::install {
    package { $ccollect::params::package_name:
        ensure => present,
    }
}
