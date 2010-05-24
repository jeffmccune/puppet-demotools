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
      ensure     => "present",
      gid        => "${p_gid}";
  }
  user {
    "puppet":
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
      ensure   => "directory",
      mode     => "0700";
  }
  file {
    "/root/.ssh/authorized_keys":
      ensure   => "file",
      source   => [ "puppet:///modules/puppet-demotools/authorized_keys.site",
                    "puppet:///modules/puppet-demotools/authorized_keys" ],
  }
  file {
    [ "/etc/puppet", "/etc/puppet/manifests" ]:
      ensure   => "directory",
      owner    => "${p_uid}",
      group    => "${p_gid}",
  }
  file {
    "/etc/puppet/manifests/site.pp":
      ensure   => "file",
      source   => "puppet:///modules/${module}/etc/puppet/manifests/site.pp",
      owner    => "${p_uid}",
      group    => "${p_gid}",
  }

  ## Splunk Pre-setup
  group {
    "splunk":
      name       => "splunk",
      ensure     => "present",
      gid        => "334";
  }
  user {
    "splunk":
      name       => "splunk",
      shell      => "/bin/bash",
      ensure     => "present",
      uid        => "334",
      gid        => "334",
      comment    => "splunk",
      home       => "/opt/splunk",
      require    => [ Group["splunk"] ],
  }
  package {
    "splunk":
      name     => "splunk",
      ensure   => "installed",
      require  => [ User["splunk"] ],
  }

}
