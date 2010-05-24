class puppetdemotools::splunk {
  $module = "puppetdemotools"
  $splunk_uid = "334"
  $splunk_gid = "334"

  ## Defaults
  File { owner => "0", group => "0", mode => "0644" }
  Exec { path => "/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin" }
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
      groups     => [ "root", "puppet", "sys", "utmp", "lp" ],
      comment    => "Splunk Server",
      home       => "/opt/splunk",
      require    => [ Group["splunk"] ],
  }
  package {
    "splunk":
      name     => "splunk",
      ensure   => "installed",
      notify   => Exec ["fix-splunk-perms" ],
      require  => [ User["splunk"] ],
  }
  exec {
    "fix-splunk-perms":
      command     => "chmod -R u+rwX /opt/splunk",
      refreshonly => true,
      returns     => [ 0 ];
  }
}
