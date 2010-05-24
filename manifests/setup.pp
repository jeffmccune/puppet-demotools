notice("puppet-demotools, jeff@puppetlabs.com, Twitter: 0xEFF")

# Set hostname
puppet::hostname {
  'puppet':
    domainname => 'demo.lan',
    before => Class["puppetdemotools"],
}

include puppetdemotools
