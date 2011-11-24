# puppet-ccollect

Manage ccollect via Puppet

## How to use

### Destination node
```
    class { 'ccollect':
        backup_dir = '/backup/ccollect/',
    }

    # Realize all collected nodes
    Ccollect::Backup <<| |>> {
        ensure => present,
    }
```

### Source node(s)
```
    @@ccollect::backup {
        ssh_user          => root,
        source            => '/',
        destination       => $fqdn,
        exclude           => 'puppet:///files/another/exclude/file',
        rsync_options     => '',
        delete_incomplete => 'y',
        pre_exec          => 'puppet:///files/path/to/pre/exec/script',
        post_exec         => 'puppet:///files/path/to/post/exec/script',
    }
```

* ssh_user:
    User to connect as to remote host
    **Default:** root

* source:
    Start position of rsync
    **Default:** /

* destination:
    Backup destination, relative to 'backup_dir' (e.g '/var/lib/backup/host.example.com/')
    **Default:** $fqdn

* exclude:
    Exclude list to use
    **Default:** 'puppet:///modules/ccollect/exclude'

* rsync_options:
    Additional rsync options
    **Default:** ''

* delete_incomplete:
    Delete incomplete backups
    **Default:** y

* pre_exec:
    Script to execute before backing up host
    **Default:** ''

* post_exec:
    Script to execute after backing up host
    **Default:** ''
    

