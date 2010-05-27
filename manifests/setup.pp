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
  "/etc/localtime":
    ensure => "/usr/share/zoneinfo/Europe/Brussels"
}

file {
  "/etc/sysconfig/clock":
    content  => "ZONE=\"${my_timezone}\"\nUTC=true\nARC=false\n"
}

include puppetdemotools
