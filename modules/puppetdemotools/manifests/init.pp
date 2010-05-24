# Jeff McCune <jeff@puppetlabs.com>
# 2010-05-24
#
# Puppet Demo Tools
# This class sets up a puppet demo VM from scratch.

class puppetdemotools {
  # Setup local yum repository
  require puppetdemotools::localyum

  ###############################
  $module = "puppetdemotools"
  $p_uid = "333"
  $p_gid = "333"
  $splunk_uid = "334"
  $splunk_gid = "334"
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
      source   => [ "puppet:///modules/${module}/authorized_keys.site",
                    "puppet:///modules/${module}/authorized_keys" ],
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
      gid        => "${splunk_uid}";
  }
  user {
    "splunk":
      name       => "splunk",
      shell      => "/bin/bash",
      ensure     => "present",
      uid        => "${splunk_uid}",
      gid        => "${splunk_gid}",
      comment    => "Splunk Server",
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
