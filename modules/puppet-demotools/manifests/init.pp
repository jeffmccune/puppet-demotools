# Jeff McCune <jeff@puppetlabs.com>
# 2010-05-24
#
# Puppet Demo Tools
# This class sets up a puppet demo VM from scratch.

class puppet-demotools {
  package {
    "puppet-server":
      ensure   => "installed",
  }
  group {
    "puppet":
      name       => "puppet",
      ensure     => "present",
      gid        => "333";
  }
  user {
    "puppet":
      name       => "puppet",
      shell      => "/bin/false",
      ensure     => "present",
      uid        => "333",
      gid        => "333",
      comment    => "puppet",
      home       => "/var/lib/puppet",
      require    => [ Group["puppet"] ],
  }
  file {
    "/root/.ssh":
      path     => "/root/.ssh",
      ensure   => "directory",
      owner    => "0",
      group    => "0",
      mode     => "0700";
  }
  file {
    "/root/.ssh/authorized_keys":
      path     => "/root/.ssh/authorized_keys",
      ensure   => "file",
      source   => [ "puppet:///modules/puppet-demotools/authorized_keys.site",
                    "puppet:///modules/puppet-demotools/authorized_keys" ],
      owner    => "0",
      group    => "0",
      mode     => "0644";
  }
}
