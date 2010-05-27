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
file {
  "/etc/ntp.conf":
    content => "# Empty NTP configuration file."
}

