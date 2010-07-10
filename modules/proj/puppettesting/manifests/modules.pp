# Class: puppettesting::modules
#
#   This class creates a bunch of modules for testing the master
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppettesting::modules {
  $module = "puppettesting"
  file { "/etc/puppet/modules":
    ensure => directory,
    recurse => true,
    purge => true,
  }
  puppettesting::puppetmodule {
    [ "one", "two", "three" ]:
      location => "/etc/puppet/modules";
  }
}
