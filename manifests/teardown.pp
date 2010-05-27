#! /usr/bin/env puppet --verbose
#

service {
  "ntpd":
    name       => "ntpd",
    enable     => "false",
    ensure     => "stopped",
    hasrestart => "true",
    hasstatus  => "true";
}
service {
  "syslog":
    name       => "syslog",
    enable     => "true",
    ensure     => "running",
    hasrestart => "true",
    hasstatus  => "true";
}
file {
  "/etc/ntp.conf":
    content => "# Empty NTP configuration file."
}
file {
  "/var/log/daemon.log":
    ensure => absent,
    notify => Service["syslog"]
}
