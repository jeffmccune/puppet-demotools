# Jeff McCune <jeff@puppetlabs.com>
# 2010-05-24
#
# Puppet Demo Tools
# This class sets up a puppet demo VM from scratch.

class puppetdemotools {
  # Setup local yum repository
  require puppetdemotools::localyum
  include puppetdemotools::splunk

  ###############################
  $module = "puppetdemotools"
  $p_uid = "333"
  $p_gid = "333"
  ###############################
  File { owner => "0", group => "0", mode => "0644" }
  Package { ensure => installed }

  package {
    [ "puppet-server", "rubygems", "gcc" ]:
  }
  package {
    "ruby-debug":
      name     => "ruby-debug",
      ensure   => "installed",
      provider => "gem",
      require  => [ Package["rubygems"],
                    Package["gcc"] ];
  }

  group {
    "puppet":
      ensure     => "present",
      gid        => "${p_gid}";
  }
  user {
    "puppet":
      shell      => "/bin/nologin",
      ensure     => "present",
      uid        => "${p_uid}",
      gid        => "${p_gid}",
      comment    => "puppet",
      home       => "/var/lib/puppet",
      require    => [ Group["puppet"] ],
  }
  file {
    "/usr/lib/ruby/site_ruby/1.8/puppet/reports/logversion.rb":
      ensure => "../../../../../../../demo/puppet-demotools/lib/puppet/reports/logversion.rb",
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
    [ "/etc/puppet", "/etc/puppet/manifests", "/var/run/puppet" ]:
      ensure   => "directory",
      owner    => "${p_uid}",
      group    => "${p_gid}",
  }
  file {
    "/var/log/puppet":
      ensure   => "directory",
      owner    => "${p_uid}",
      group    => "${p_gid}",
      mode     => "0750",
  }
  file {
    "/etc/puppet/puppet.conf":
      path     => "/etc/puppet/puppet.conf",
      ensure   => "file",
      source   => "puppet:///modules/${module}/etc/puppet/puppet.conf",
      mode     => "0644",
  }
  file {
    "/etc/puppet/manifests/site.pp":
      ensure   => "file",
      source   => "puppet:///modules/${module}/etc/puppet/manifests/site.pp",
      owner    => "${p_uid}",
      group    => "${p_gid}",
  }
}
