# Class: ccollect
#
# This module manages ccollect
#
# Parameters:
#   backup_dir: backup destination, defaults to /var/lib/backups
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#   Ccollect backup node:
#   class { 'ccollect':
#       backup_dir => '/path/to/backup/dir/',
#   }
#
#   Ccollect::Backup <<| |>> {
#       ensure => present,
#   }
#
#   Nodes to backup:
#   @@ccollect::backup { $fqdn: }
#
#
# [Remember: No empty lines between comments and class definition]
class ccollect(
  $backup_dir = '/var/lib/backups/'
) {
  include ::ccollect::params
  include ::ccollect::install
  include ::ccollect::config
}
