# Class: apache::ssl
#
# This class installs Apache SSL capabilities
#
# Parameters:
# - The $ssl_package name from the apache::params class
#
# Actions:
#   - Install Apache SSL capabilities
#
# Requires:
#
#   class puppettesting::master::certificates
#
# Sample Usage:
#
class apache::ssl inherits apache {
  $module = "apache"
  File { owner => "0", group => "0", mode  => "0644", }
  ######
  # Add the SSL configuration.
  case $operatingsystem {
    'centos', 'fedora', 'redhat': {
      package {
          $apache::params::ssl_package:
            require => Package['httpd'],
            notify => Service["apache"],
        }
      file {
        "/etc/httpd/conf.d/000_ssl.conf":
          source => "puppet:///modules/${module}/etc/httpd/conf.d/000_ssl.conf",
          notify => Service["apache"],
      }
    }
    'ubuntu', 'debian': {
        a2mod {
          "ssl":
            ensure => present,
            notify => Service["apache"],
        }
    }
  }
}
# EOF
