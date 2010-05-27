notice("puppet-demotools, jeff@puppetlabs.com, Twitter: 0xEFF")

# $my_timezone = "America/New_York"
$my_timezone = "Europe/Brussels"

File { owner => "root", group => "root", mode => "0644" }

# Set hostname
puppet::hostname {
  'puppet':
    domainname => 'demo.lan',
    before => [ Class["puppetdemotools"],
                Class["puppetdemotools::splunk"], ]
}

file {
}

# Configure the timezone
file {
  "/etc/localtime":
    ensure => "/usr/share/zoneinfo/Europe/Brussels";
  "/etc/sysconfig/clock":
    content  => "ZONE=\"${my_timezone}\"\nUTC=true\nARC=false\n";
}

# Set the time
exec {
  "/usr/sbin/ntpdate time.apple.com":
}

include puppetdemotools
