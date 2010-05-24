# Jeff McCune <jeff@puppetlabs.com>
# 2010-05-24
#
# Puppet Demo Tools
# This class sets up a puppet demo VM from scratch.

class puppet-demotools {
  $module = "puppet-demotools"
  $p_uid = "333"
  $p_gid = "333"
  ###############################
  File { owner => "0", group => "0", mode => "0644" }

  package {
    "puppet-server":
      ensure   => "installed",
  }
  group {
    "puppet":
      name       => "puppet",
      ensure     => "present",
      gid        => "${p_gid}";
  }
  user {
    "puppet":
      name       => "puppet",
      shell      => "/bin/false",
      ensure     => "present",
      uid        => "${p_uid}",
      gid        => "${p_gid}",
      comment    => "puppet",
      home       => "/var/lib/puppet",
      require    => [ Group["puppet"] ],
  }
  file {
    "/root/.ssh":
      path     => "/root/.ssh",
      ensure   => "directory",
      mode     => "0700";
  }
  file {
    "/root/.ssh/authorized_keys":
      path     => "/root/.ssh/authorized_keys",
      ensure   => "file",
      source   => [ "puppet:///modules/puppet-demotools/authorized_keys.site",
                    "puppet:///modules/puppet-demotools/authorized_keys" ],
  }
  file {
    [ "/etc/puppet", "/etc/puppet/manifests" ]:
      path     => "/etc/puppet",
      ensure   => "directory",
      owner    => "${p_uid}",
      group    => "${p_gid}",
  }
  file {
    "/etc/puppet/manifests/site.pp":
      path     => "/etc/puppet/manifests/site.pp",
      ensure   => "file",
      source   => "puppet:///modules/${module}/etc/puppet/manifests/site.pp",
      owner    => "${p_uid}",
      group    => "${p_gid}",
  }
}
