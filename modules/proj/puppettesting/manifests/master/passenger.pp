# Class: puppettesting::master::passenger
#
#   2010-07-07 Jeff McCune <jeff@puppetlabs.com>
# 
#   Manage a puppet master running within passenger.
#
# Parameters:
#
#   $params::passenger_module_path
#   $params::passenger_module_version
#
# Actions:
#
# Requires:
#
#   Class["apache"]
#   Service["apache"]
#
# Sample Usage:
#
#   include puppettesting::master::passenger
#
class puppettesting::master::passenger inherits puppettesting::master {
  $module = "puppettesting"
  # Variables
  $passenger_module_path = $params::passenger_module_path
  $passenger_version = $params::passenger_version
  $passenger_ruby = $params::passenger_ruby
  # Classes to include
  include apache::ssl

  # We need certificates to be generated before Apache starts up
  Puppettesting::Master::Certificates["${fqdn}"] { notify +> Service["apache"] }

  # Resource defaults
  File {
    owner => "0",
    group => "0",
    mode  => "0644",
  }
  # Resources
  file {
    [ "/etc/puppet/rack", "/etc/puppet/rack/public" ]:
      ensure => directory;
    "/etc/puppet/rack/config.ru":
      content => template("${module}/etc/puppet/rack/config.ru"),
      owner => puppet,
      notify => [ Service["apache"] ];
    "/etc/httpd/conf.d/passenger.conf":
      content => template("${module}/etc/httpd/conf.d/passenger.conf"),
      notify => [ Service["apache"] ];
  }
}
# EOF
